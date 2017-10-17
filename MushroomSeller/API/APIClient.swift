//
//  APIClient.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation
import UIKit
import Deferred
import Firebase

enum MushroomSellerError: Error {
    case malformedJSON
    case mismatchedParams
    case unexpectedModel
    case unknown
}

public protocol APIClientType {
    func retrieveMushroomTypes() -> Task<[MushroomTypeResponse]>
    func retrieveMushroomList(type: MushroomType) -> Task<[MushroomInfoResponse]>
}

class APIClient: APIClientType {
    
    //MARK: - Stored Properties
    fileprivate var ref: DatabaseReference!
    
    func retrieveMushroomTypes() -> Task<[MushroomTypeResponse]> {
        
        guard let jsonData = JsonReader.readJson("mushroomTypes") else {
            return Task(failure: MushroomSellerError.malformedJSON)
        }
        
        guard let decoded = try? JSONDecoder().decode([MushroomTypeResponse].self, from: jsonData) else {
            return Task(failure: MushroomSellerError.mismatchedParams)
        }
        return Task(success: decoded)  
    }
    
    func retrieveMushroomList(type: MushroomType) -> Task<[MushroomInfoResponse]> {
        
        //Firebase get mushrooms list
        ref = Database.database().reference()
        
        let task: Task<[String:Any]> = {
            
            let deferred = Deferred<Task<[String:Any]>.Result>()
            
            self.ref.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                
                guard let mushroomDict = snapshot.value as? [String: Any] else {
                    deferred.fail(with: MushroomSellerError.unexpectedModel)
                    return
                }
                
                deferred.succeed(with: mushroomDict)
            })
            
            return Task(future: Future(deferred))
        }()
        
        return task.andThen(upon: .main, start: { (mushroomDict) -> Task<[MushroomInfoResponse]> in
            self.retrieveMushrooms(mushrooms: mushroomDict)
        })
    }
    
    private func retrieveMushrooms(mushrooms: [String : Any]) -> Task<[MushroomInfoResponse]> {
        
        //Iterate tournaments
        let taskArray: [Task<MushroomInfoResponse>] = mushrooms.flatMap { (mushroomDic: (key: String, value: Any)) -> Task<MushroomInfoResponse>? in
            
            //Get each tournament
            guard let mushroom = mushroomDic.value as? [String: Any] else {
                return Task(failure: MushroomSellerError.unexpectedModel)
            }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: mushroom, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                return Task(failure: MushroomSellerError.malformedJSON)
            }
            
            guard let decoded = try? JSONDecoder().decode(MushroomInfoResponse.self, from: jsonData) else {
                return Task(failure: MushroomSellerError.mismatchedParams)
            }
            
            return Task(success: MushroomInfoResponse(withResponse: decoded, andScientificName: mushroomDic.key))
        }
        
        //[Task<MushroomInfoResponse>] to Task<[MushroomInfoResponse]>
        // Map each successful task into an array of SuccessValue
        return taskArray.coalesce()
    }
}

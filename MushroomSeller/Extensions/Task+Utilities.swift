//
//  Task+Utilities.swift
//  MushroomSeller
//
//  Created by Pia on 15/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation
import Deferred

extension Collection where Iterator.Element : FutureProtocol, Iterator.Element.Value: Either, Iterator.Element.Value.Left == Error {
    func coalesce<SuccessValue>() -> Task<[SuccessValue]> {
        let finalTask: Task<[SuccessValue]> = allSucceeded()
            .map(upon: .main, transform: { _ -> [SuccessValue] in
                // Map each successful task into an array of SuccessValue
                self.flatMap({ (try? $0.peek()?.extract()) as? SuccessValue })
            })
        
        return finalTask
    }
}

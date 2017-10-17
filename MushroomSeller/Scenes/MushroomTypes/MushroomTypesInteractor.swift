//
//  MushroomTypesInteractor.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation
import Deferred

class MushroomTypesInteractor {
    
    //MARK: - Stored properties
    let apiClient: APIClientType
    
    //MARK: - Initializer
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
}

extension MushroomTypesInteractor: MushroomTypesInteractorProtocol {
    
    func retrieveData() -> Task<[MushroomTypeViewModel]> {
        let task = apiClient.retrieveMushroomTypes()
        return task.map(upon: .main) { (typeList) -> [MushroomTypeViewModel] in
            typeList.map({ (response) -> MushroomTypeViewModel in
                return MushroomTypeViewModel(fromResponse: response)
            })
        }
    }
}

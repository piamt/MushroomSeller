//
//  MushroomListInteractor.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import Deferred

class MushroomListInteractor {

    //MARK: - Stored properties
    let apiClient: APIClientType
    
    //MARK: - Initializer
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
}

extension MushroomListInteractor: MushroomListInteractorProtocol {

    func retrieveData(forType type: MushroomType) -> Task<[MushroomInfoViewModel]> {
        return apiClient.retrieveMushroomList(type: type)
            .map(upon: .main, transform: { (infoArray) -> [MushroomInfoViewModel] in
                infoArray.map({ (response) -> MushroomInfoViewModel in
                    MushroomInfoViewModel(fromResponse: response)
                })
            })
    }
}


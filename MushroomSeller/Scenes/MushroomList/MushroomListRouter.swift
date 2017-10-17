//
//  MushroomListRouter.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation

class MushroomListRouter {

    //MARK: - Stored properties
    unowned let view: MushroomListViewController

    //MARK: Initializer
    init(view: MushroomListViewController) {
        self.view = view
    }
}

extension MushroomListRouter: MushroomListRouterProtocol {
    func navigateToNextScene() {
        //Navigate to next scene
    }
}

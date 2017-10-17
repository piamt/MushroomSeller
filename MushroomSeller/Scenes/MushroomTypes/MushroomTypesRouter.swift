//
//  MushroomTypesRouter.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import UIKit

class MushroomTypesRouter {

    //MARK: - Stored properties
    unowned let view: MushroomTypesViewController
    let apiClient: APIClientType

    //MARK: Initializer
    init(view: MushroomTypesViewController, apiClient: APIClientType) {
        self.view = view
        self.apiClient = apiClient
    }
}

extension MushroomTypesRouter: MushroomTypesRouterProtocol {

    func navigateToNextScene(selectedType: MushroomType) {
        //If new navigation 
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.router.navigateToMushroomList(type: selectedType)
        
        //If same navigation
        let viewController = MushroomListBuilder.build(apiClient: apiClient, type: selectedType)
        viewController.title = selectedType.rawValue
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}

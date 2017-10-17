//
//  MushroomListBuilder.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import Deferred

protocol MushroomListPresenterProtocol {
    func viewDidLoad()
}

protocol MushroomListInteractorProtocol {
    @discardableResult func retrieveData(forType type: MushroomType) -> Task<[MushroomInfoViewModel]>
}

protocol MushroomListUserInterfaceProtocol: class {
    func configureFor(viewModel: [MushroomInfoViewModel])
}

protocol MushroomListRouterProtocol {
    func navigateToNextScene()
}

class MushroomListBuilder {

    //MARK: - Configuration
    static func build(apiClient: APIClientType, type: MushroomType) -> MushroomListViewController {
        let viewController = MushroomListViewController()
        let router = MushroomListRouter(view: viewController)
        let interactor = MushroomListInteractor(apiClient: apiClient)
        let presenter = MushroomListPresenter(router: router, interactor: interactor, view: viewController, type: type)

        viewController.presenter = presenter

        return viewController
    }
}

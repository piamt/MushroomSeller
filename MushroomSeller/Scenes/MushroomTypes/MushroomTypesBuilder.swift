//
//  MushroomTypesBuilder.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import Deferred

protocol MushroomTypesPresenterProtocol {
    func viewDidLoad()
    func didClickOnType(type: MushroomType)
}

protocol MushroomTypesInteractorProtocol {
    @discardableResult func retrieveData() -> Task<[MushroomTypeViewModel]>
}

protocol MushroomTypesUserInterfaceProtocol: class {
    func configureFor(viewModel: [MushroomTypeViewModel])
}

protocol MushroomTypesRouterProtocol {
    func navigateToNextScene(selectedType: MushroomType)
}

class MushroomTypesBuilder {

    //MARK: - Configuration
    static func build(apiClient: APIClientType) -> MushroomTypesViewController {
        let viewController = MushroomTypesViewController()
        let router = MushroomTypesRouter(view: viewController, apiClient: apiClient)
        let interactor = MushroomTypesInteractor(apiClient: apiClient)
        let presenter = MushroomTypesPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}

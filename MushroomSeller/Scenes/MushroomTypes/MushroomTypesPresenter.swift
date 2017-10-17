//
//  MushroomTypesPresenter.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation

class MushroomTypesPresenter {

    //MARK: - Stored properties
    fileprivate let router: MushroomTypesRouterProtocol
    fileprivate let interactor: MushroomTypesInteractorProtocol
    fileprivate unowned let view: MushroomTypesUserInterfaceProtocol

    //MARK: - Initializer
    init(router: MushroomTypesRouterProtocol, interactor: MushroomTypesInteractorProtocol, view: MushroomTypesUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension MushroomTypesPresenter: MushroomTypesPresenterProtocol {

    func viewDidLoad() {
        interactor.retrieveData().upon(.main) { result in
            switch result {
                case .failure(let error):
                    print(error)
                    //TODO: Treat error
                case .success(let model):
                    print(model)
                    self.view.configureFor(viewModel: model)
            }
        }
    }
    
    func didClickOnType(type: MushroomType) {
        //Show mushroom list for type
        router.navigateToNextScene(selectedType: type)
    }
}

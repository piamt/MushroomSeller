//
//  MushroomListPresenter.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation

class MushroomListPresenter {

    //MARK: - Stored properties
    fileprivate let router: MushroomListRouterProtocol
    fileprivate let interactor: MushroomListInteractorProtocol
    fileprivate unowned let view: MushroomListUserInterfaceProtocol
    
    let type: MushroomType

    //MARK: - Initializer
    init(router: MushroomListRouterProtocol,
         interactor: MushroomListInteractorProtocol,
         view: MushroomListUserInterfaceProtocol,
         type: MushroomType) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.type = type
    }
}

extension MushroomListPresenter: MushroomListPresenterProtocol {

    func viewDidLoad() {
        interactor.retrieveData(forType: type).upon(.main) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            //TODO: Treat error
            case .success(let model):
                dump(model)
                //Filter just the mushrooms with the specific type asked by the user
                self.view.configureFor(viewModel: model.filter( { $0.type == self.type } ))
            }
        }
    }
}

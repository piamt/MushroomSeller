//
//  AppRouter.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation
import UIKit

protocol AppRouterProtocol: class {
    func navigateToMushroomList(type: MushroomType)
}

class AppRouter {
    
    // MARK: - Stored properties
    fileprivate let window: UIWindow
    fileprivate let rootViewController = AppRootViewController()
    fileprivate let apiClient = APIClient()
    
    // MARK: - Initializer
    init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
    }
    
    // MARK: - Public API
    func startApplication() {
        let controller = MushroomTypesBuilder.build(apiClient: apiClient)
        let navigationController = UINavigationController(rootViewController: controller)
        rootViewController.transition(to: navigationController)
    }
}

extension AppRouter: AppRouterProtocol {
    func navigateToMushroomList(type: MushroomType) {
        let controller = MushroomListBuilder.build(apiClient: apiClient, type: type)
        let navigationController = UINavigationController(rootViewController: controller)
        rootViewController.transition(to: navigationController)
    }
}

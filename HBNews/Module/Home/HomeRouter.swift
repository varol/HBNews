//
//  HomeRouter.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import UIKit

protocol HomeRouterInterface: AnyObject {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {

}

class HomeRouter: NSObject {
    static func setupModule() -> HomeViewController {
        let vc = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor,
        router: router,
        view: vc)
        
        vc.presenter = presenter
        interactor.output = presenter
        return vc
    }
}

extension HomeRouter: HomeRouterInterface {

    func navigate(_ route: HomeRoutes) {
        
    }
}


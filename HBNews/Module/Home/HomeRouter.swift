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
    case details(source: Source?)
}

class HomeRouter {
    weak var viewController: HomeViewController?

    static func setupModule() -> HomeViewController {
        let vc = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor,
        router: router,
        view: vc)
        
        vc.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}

extension HomeRouter: HomeRouterInterface {

    func navigate(_ route: HomeRoutes) {
        switch route {
        case .details(source: let source):
            let vc = DetailsRouter.setupModule()
            vc.source = source
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


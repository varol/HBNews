//
//  DetailsRouter.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import UIKit

protocol DetailsRouterInterface: AnyObject {
    func navigate(_ route: DetailsRoutes)
}

enum DetailsRoutes {
    case openURL(url: URL)
}

class DetailsRouter: NSObject {
    weak var viewController: DetailsViewController?
    
    static func setupModule() -> DetailsViewController {
        let vc = DetailsViewController()
        let interactor = DetailsInteractor()
        let router = DetailsRouter()
        let presenter = DetailsPresenter(interactor: interactor,
        router: router,
        view: vc)

        vc.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}

extension DetailsRouter: DetailsRouterInterface {
    func navigate(_ route: DetailsRoutes) {
        switch route {
        case .openURL(url: let url):
            UIApplication.shared.open(url)
        }
    }
}


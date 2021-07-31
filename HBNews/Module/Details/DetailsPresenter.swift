//
//  DetailsPresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsPresenterInterface: AnyObject {

}

final class DetailsPresenter: DetailsPresenterInterface {

    unowned var view: DetailsViewControllerInterface!
    let router: DetailsRouterInterface!
    let interactor: DetailsInteractorInterface!

    init(interactor: DetailsInteractorInterface,  router: DetailsRouterInterface, view:  DetailsViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailsPresenter: DetailsInteractorOutputInterface {

}

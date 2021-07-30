//
//  SplashPresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation

protocol SplashPresenterInterface: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterInterface {
    unowned var view: SplashViewControllerInterface!
    let router: SplashRouterInterface!
    let interactor: SplashInteractorInterface!

    init(interactor: SplashInteractorInterface,  router: SplashRouterInterface, view:  SplashViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
}

extension SplashPresenter: SplashInteractorOutput {
    func internetConnection(status: Bool) {
        status ? router.navigate(.homeScreen) : view.noConnection()
    }
}

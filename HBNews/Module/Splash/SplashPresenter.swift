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
    weak var view: SplashViewControllerInterface?
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
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.router.navigate(.homeScreen)
            }
        } else {
            view?.noConnection()
        }
    }
}

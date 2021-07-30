//
//  SplashInteractor.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation

protocol SplashInteractorInterface: AnyObject {
    func checkInternetConnection()
}

protocol SplashInteractorOutput: AnyObject {
    func internetConnection(status: Bool)
}

final class SplashInteractor {
    var output: SplashInteractorOutput?
}

extension SplashInteractor: SplashInteractorInterface {
    func checkInternetConnection() {
        let internetConnectionStatus = NetworkManager.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internetConnectionStatus)
    }
}

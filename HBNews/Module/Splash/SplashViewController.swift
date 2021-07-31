//
//  SplashViewController.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import UIKit

protocol SplashViewControllerInterface: AnyObject {
    func noConnection()
}

final class SplashViewController: BaseViewController {
    var presenter: SplashPresenterInterface!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

extension SplashViewController: SplashViewControllerInterface {
    func noConnection() {
        showAlert(title: "Error", message: "No internet connection")
    }
}

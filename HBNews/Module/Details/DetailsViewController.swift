//
//  DetailsViewController.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import UIKit

protocol DetailsViewControllerInterface: AnyObject {

}

class DetailsViewController: BaseViewController {
    var presenter: DetailsPresenterInterface!
    var sourceId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("İD", sourceId ?? "")
    }
}

extension DetailsViewController: DetailsViewControllerInterface {

}

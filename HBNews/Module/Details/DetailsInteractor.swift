//
//  DetailsInteractor.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsInteractorInterface: AnyObject {

}

protocol DetailsInteractorOutputInterface: AnyObject {

}

final class DetailsInteractor {
    var output: DetailsInteractorOutputInterface?
}

extension DetailsInteractor: DetailsInteractorInterface {

}

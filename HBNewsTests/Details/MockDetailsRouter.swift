//
//  MockDetailsRouter.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockDetailsRouter: DetailsRouterInterface {
    var invokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: DetailsRoutes, Void)?
    var invokedNavigateParametersList = [(route: DetailsRoutes, Void)]()

    func navigate(_ route: DetailsRoutes) {
        invokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
        invokedNavigateParametersList.append((route, ()))
    }
}

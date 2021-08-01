//
//  MockHomeRouter.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockHomeRouter: HomeRouterInterface {
    var invokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: HomeRoutes, Void)?
    var invokedNavigateParametersList = [(route: HomeRoutes, Void)]()

    func navigate(_ route: HomeRoutes) {
        invokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
        invokedNavigateParametersList.append((route, ()))
    }
}

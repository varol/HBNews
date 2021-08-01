//
//  MockHomeInteractor.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockHomeInteractor: HomeInteractorInterface {
    var invokedFetchNewsSources = false
    var invokedFetchNewsSourcesCount = 0

    func fetchNewsSources() {
        invokedFetchNewsSources = true
        invokedFetchNewsSourcesCount += 1
    }
}

//
//  MockDetailsInteractor.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockDetailsInteractor: DetailsInteractorInterface {
    var invokedFetchNewsDetails = false
    var invokedFetchNewsDetailsCount = 0
    var invokedFetchNewsDetailsParameters: (sourceId: String, page: Int, qInTitle: String?)?
    var invokedFetchNewsDetailsParametersList = [(sourceId: String, page: Int, qInTitle: String?)]()

    func fetchNewsDetails(with sourceId: String, page: Int, qInTitle: String?) {
        invokedFetchNewsDetails = true
        invokedFetchNewsDetailsCount += 1
        invokedFetchNewsDetailsParameters = (sourceId, page, qInTitle)
        invokedFetchNewsDetailsParametersList.append((sourceId, page, qInTitle))
    }

    var invokedRefreshNewsDetails = false
    var invokedRefreshNewsDetailsCount = 0
    var invokedRefreshNewsDetailsParameters: (sourceId: String, page: Int, qInTitle: String?)?
    var invokedRefreshNewsDetailsParametersList = [(sourceId: String, page: Int, qInTitle: String?)]()

    func refreshNewsDetails(with sourceId: String, page: Int, qInTitle: String?) {
        invokedRefreshNewsDetails = true
        invokedRefreshNewsDetailsCount += 1
        invokedRefreshNewsDetailsParameters = (sourceId, page, qInTitle)
        invokedRefreshNewsDetailsParametersList.append((sourceId, page, qInTitle))
    }
}

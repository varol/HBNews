//
//  MockDetailsCellDelegate.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockDetailsCellDelegate: DetailsCellDelegate {

    var invokedAddReadingListButtonTapped = false
    var invokedAddReadingListButtonTappedCount = 0
    var invokedAddReadingListButtonTappedParameters: (url: String, Void)?
    var invokedAddReadingListButtonTappedParametersList = [(url: String, Void)]()

    func addReadingListButtonTapped(url: String) {
        invokedAddReadingListButtonTapped = true
        invokedAddReadingListButtonTappedCount += 1
        invokedAddReadingListButtonTappedParameters = (url, ())
        invokedAddReadingListButtonTappedParametersList.append((url, ()))
    }
}

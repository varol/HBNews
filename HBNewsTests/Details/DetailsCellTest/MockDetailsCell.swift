//
//  MockDetailsCell.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockDetailsCell: DetailsCellInterface {

    var invokedSetNewsImageView = false
    var invokedSetNewsImageViewCount = 0
    var invokedSetNewsImageViewParameters: (imageUrl: String, Void)?
    var invokedSetNewsImageViewParametersList = [(imageUrl: String, Void)]()

    func setNewsImageView(_ imageUrl: String) {
        invokedSetNewsImageView = true
        invokedSetNewsImageViewCount += 1
        invokedSetNewsImageViewParameters = (imageUrl, ())
        invokedSetNewsImageViewParametersList.append((imageUrl, ()))
    }

    var invokedSetReadingListButtonTitle = false
    var invokedSetReadingListButtonTitleCount = 0
    var invokedSetReadingListButtonTitleParameters: (text: String, isAdded: Bool)?
    var invokedSetReadingListButtonTitleParametersList = [(text: String, isAdded: Bool)]()

    func setReadingListButtonTitle(_ text: String, isAdded: Bool) {
        invokedSetReadingListButtonTitle = true
        invokedSetReadingListButtonTitleCount += 1
        invokedSetReadingListButtonTitleParameters = (text, isAdded)
        invokedSetReadingListButtonTitleParametersList.append((text, isAdded))
    }

    var invokedSetTitleLabel = false
    var invokedSetTitleLabelCount = 0
    var invokedSetTitleLabelParameters: (text: String, Void)?
    var invokedSetTitleLabelParametersList = [(text: String, Void)]()

    func setTitleLabel(_ text: String) {
        invokedSetTitleLabel = true
        invokedSetTitleLabelCount += 1
        invokedSetTitleLabelParameters = (text, ())
        invokedSetTitleLabelParametersList.append((text, ()))
    }

    var invokedSetDescriptionLabel = false
    var invokedSetDescriptionLabelCount = 0
    var invokedSetDescriptionLabelParameters: (text: String, Void)?
    var invokedSetDescriptionLabelParametersList = [(text: String, Void)]()

    func setDescriptionLabel(_ text: String) {
        invokedSetDescriptionLabel = true
        invokedSetDescriptionLabelCount += 1
        invokedSetDescriptionLabelParameters = (text, ())
        invokedSetDescriptionLabelParametersList.append((text, ()))
    }

    var invokedVibrateForReadingList = false
    var invokedVibrateForReadingListCount = 0

    func vibrateForReadingList() {
        invokedVibrateForReadingList = true
        invokedVibrateForReadingListCount += 1
    }
}

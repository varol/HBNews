//
//  MockSourcesCell.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockSourcesCell: SourcesCellInterface {

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
}

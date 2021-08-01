//
//  MockThrottler.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import Foundation
@testable import HBNews

final class MockThrottler: ThrottlerInterface {

    var invokedThrottler = false
    func throttle(_ block: @escaping () -> Void) {
        invokedThrottler = true
        block()
    }
}

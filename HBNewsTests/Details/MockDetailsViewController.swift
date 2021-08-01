//
//  MockHomeViewController.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

@testable import HBNews
import UIKit

final class MockDetailsViewController: DetailsViewControllerInterface {
    
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }

    var invokedPrepareNavigationBar = false
    var invokedPrepareNavigationBarCount = 0

    func prepareNavigationBar() {
        invokedPrepareNavigationBar = true
        invokedPrepareNavigationBarCount += 1
    }

    var invokedPrepareSearchBar = false
    var invokedPrepareSearchBarCount = 0
    var invokedPrepareSearchBarParameters: (placeholder: String, Void)?
    var invokedPrepareSearchBarParametersList = [(placeholder: String, Void)]()

    func prepareSearchBar(_ placeholder: String) {
        invokedPrepareSearchBar = true
        invokedPrepareSearchBarCount += 1
        invokedPrepareSearchBarParameters = (placeholder, ())
        invokedPrepareSearchBarParametersList.append((placeholder, ()))
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedShowLoadingView = false
    var invokedShowLoadingViewCount = 0

    func showLoadingView() {
        invokedShowLoadingView = true
        invokedShowLoadingViewCount += 1
    }

    var invokedHideLoadingView = false
    var invokedHideLoadingViewCount = 0

    func hideLoadingView() {
        invokedHideLoadingView = true
        invokedHideLoadingViewCount += 1
    }

    var invokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters: (title: String, Void)?
    var invokedSetTitleParametersList = [(title: String, Void)]()

    func setTitle(_ title: String) {
        invokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
        invokedSetTitleParametersList.append((title, ()))
    }

    var invokedGetSource = false
    var invokedGetSourceCount = 0
    var stubbedGetSourceResult: Source!

    func getSource() -> Source? {
        invokedGetSource = true
        invokedGetSourceCount += 1
        return stubbedGetSourceResult
    }

    var invokedHideKeyboard = false
    var invokedHideKeyboardCount = 0

    func hideKeyboard() {
        invokedHideKeyboard = true
        invokedHideKeyboardCount += 1
    }
}

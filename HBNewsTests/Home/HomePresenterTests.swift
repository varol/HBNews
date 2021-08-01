//
//  HomePresenterTests.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import XCTest
@testable import HBNews

class HomePresenterTests: XCTestCase {
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(interactor: interactor, router: router, view: view)
    }
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertEqual(view.invokedPrepareTableViewCount, 0)
        XCTAssertFalse(view.invokedSetTitle)
        XCTAssertNil(view.invokedSetTitleParameters)
        XCTAssertFalse(interactor.invokedFetchNewsSources)
        XCTAssertEqual(interactor.invokedFetchNewsSourcesCount, 0)

        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertTrue(view.invokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "News Sources")
        XCTAssertTrue(interactor.invokedFetchNewsSources)
        XCTAssertEqual(interactor.invokedFetchNewsSourcesCount, 1)
    }

    func test_fetchNewsSourcesOutput() {
        XCTAssertFalse(view.invokedHideLoadingView)
        XCTAssertEqual(presenter.numberOfItems(), 0)
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertNil(presenter.source(_: 0))
        
        presenter.fetchNewsSourcesOutput(result: .success(.response))
        
        XCTAssertTrue(view.invokedHideLoadingView)
        XCTAssertEqual(presenter.numberOfItems(), 128)
        XCTAssertTrue(view.invokedReloadData)
        XCTAssertNotNil(presenter.source(_: 0))
    }
    
    func test_numberOfItems_NilResponse_ReturnItemCount() {
        XCTAssertEqual(presenter.numberOfItems(), 0)
    }
}

extension NewsSourcesResponse {
    static var response: NewsSourcesResponse {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "NewsSourcesResponse", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(NewsSourcesResponse.self, from: data)
        return homeResponse
    }

    static var emptyResponse: NewsSourcesResponse? {
        nil
    }
}

//
//  DetailsPresenterTests.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import XCTest
@testable import HBNews

class DetailsPresenterTests: XCTestCase {
    var presenter: DetailsPresenter!
    var view: MockDetailsViewController!
    var interactor: MockDetailsInteractor!
    var router: MockDetailsRouter!
    var throttler: MockThrottler!

    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        throttler = .init()
        presenter = .init(interactor: interactor,
                          router: router,
                          view: view,
                          throttler: throttler)
    }

    func test_viewDidLoad_InvokesView() {
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertEqual(view.invokedPrepareTableViewCount, 0)
        XCTAssertFalse(view.invokedPrepareNavigationBar)
        XCTAssertFalse(view.invokedPrepareSearchBar)
        XCTAssertNil(view.invokedPrepareSearchBarParameters)
        XCTAssertFalse(view.invokedSetTitle)
        XCTAssertNil(view.invokedSetTitleParameters)
        XCTAssertFalse(interactor.invokedFetchNewsDetails)
        XCTAssertNil(interactor.invokedFetchNewsDetailsParameters)

        presenter.viewDidLoad()

        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertNotNil(view.invokedPrepareTableViewCount)
        XCTAssertTrue(view.invokedPrepareNavigationBar)
        XCTAssertTrue(view.invokedPrepareSearchBar)
        XCTAssertEqual(view.invokedPrepareSearchBarParameters?.placeholder, "Search News")
        XCTAssertTrue(view.invokedSetTitle)
        XCTAssertNotNil(view.invokedSetTitleParameters)
        XCTAssertTrue(interactor.invokedFetchNewsDetails)
        XCTAssertNotNil(interactor.invokedFetchNewsDetailsParameters)
        XCTAssertEqual(interactor.invokedFetchNewsDetailsParameters?.page, 1)
    }
    
    func test_numberOfItems_ReturnItemCount() {
        presenter.fetchNewsDetailsOutput(result: .success(.response))
        XCTAssertEqual(presenter.numberOfItems(), 20)
    }
    
    func test_numberOfItems_NilResponse_ReturnItemCount() {
        XCTAssertEqual(presenter.numberOfItems(), 0)
    }
    
    func test_refreshNewsDetailsWithValidData() {
        XCTAssertFalse(interactor.invokedRefreshNewsDetails)
        XCTAssertEqual(interactor.invokedRefreshNewsDetailsCount, 0)
        XCTAssertNil(interactor.invokedRefreshNewsDetailsParameters?.page)

        presenter.refreshNewsDetails(with: "bbc-news", page: 1)
        
        XCTAssertTrue(interactor.invokedRefreshNewsDetails)
        XCTAssertEqual(interactor.invokedRefreshNewsDetailsCount, 1)
        XCTAssertEqual(interactor.invokedRefreshNewsDetailsParameters?.page, 1)
        XCTAssertEqual(interactor.invokedRefreshNewsDetailsParameters?.sourceId, "bbc-news")
    }
    
    func test_articleWithValidData(){
        presenter.fetchNewsDetailsOutput(result: .success(.response))
        XCTAssertNotNil(presenter.article(_: 1))
    }
    
    func test_didSelectItemAtWithValidData() {
        XCTAssertFalse(router.invokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 0)
        
        presenter.fetchNewsDetailsOutput(result: .success(.response))
        presenter.didSelectItemAt(index: 1)
        
        XCTAssertTrue(router.invokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
    }
    
    func test_searchNewsWithTitle(){
        XCTAssertFalse(throttler.invokedThrottler)
        XCTAssertFalse(interactor.invokedFetchNewsDetails)
        XCTAssertEqual(interactor.invokedFetchNewsDetailsCount, 0)
        XCTAssertNil(interactor.invokedFetchNewsDetailsParameters?.qInTitle)

        presenter.searchNewsWithTitle(qInTitle: "Biden")
        
        XCTAssertTrue(throttler.invokedThrottler)
        XCTAssertTrue(interactor.invokedFetchNewsDetails)
        XCTAssertEqual(interactor.invokedFetchNewsDetailsCount, 1)
        XCTAssertEqual(interactor.invokedFetchNewsDetailsParameters?.qInTitle, "Biden")
        XCTAssertEqual(interactor.invokedFetchNewsDetailsParameters?.page, 1)
    }
    
    func test_refreshNewsDetailsOutput_InvokesView() {
        XCTAssertFalse(view.invokedReloadData)

        presenter.refreshNewsDetailsOutput(result: .success(.response))

        XCTAssertTrue(view.invokedReloadData)
    }
}

extension NewsDetailsResponse {
    static var response: NewsDetailsResponse {
        let bundle = Bundle(for: DetailsPresenterTests.self)
        let path = bundle.path(forResource: "NewsDetailsResponse", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(NewsDetailsResponse.self, from: data)
        return homeResponse
    }

    static var emptyResponse: NewsDetailsResponse? {
        nil
    }
}

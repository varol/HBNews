//
//  SourcesCellPresenterTests.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.


import XCTest
@testable import HBNews

class SourcesCellPresenterTests: XCTestCase {
    var view: MockSourcesCell!
    var presenter: SourcesCellPresenter!

    override func setUp() {
        super.setUp()
        view = .init()
        let source = Source(id: nil, name: "bbc-news", sourceDescription: "bbc", url: "", category: nil, language: nil, country: nil)
        presenter = .init(view: view, source: source)
    }

    func test_load_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedSetTitleLabel)
        XCTAssertFalse(view.invokedSetDescriptionLabel)
        
        presenter.load()

        XCTAssertTrue(view.invokedSetTitleLabel)
        XCTAssertTrue(view.invokedSetDescriptionLabel)
    }
    
    func test_loadWithValidData(){
        XCTAssertFalse(view.invokedSetTitleLabel)
        XCTAssertFalse(view.invokedSetDescriptionLabel)
        
        presenter.load()

        XCTAssertEqual(view.invokedSetTitleLabelParameters?.text, "bbc-news")
        XCTAssertEqual(view.invokedSetDescriptionLabelParameters?.text, "bbc")
    }
}

//
//  DetailsCellPresenterTests.swift
//  HBNewsTests
//
//  Created by Varol AKSOY on 1.08.2021.
//

import XCTest
@testable import HBNews

class DetailsCellPresenterTests: XCTestCase {
    var view: MockDetailsCell!
    var presenter: DetailsCellPresenter!
    var delegate: MockDetailsCellDelegate!
    var article : Article!
    
    override func setUp() {
        super.setUp()
        view = .init()
        delegate = .init()
        let article = Article(source: nil,
                              author: nil,
                              title: "bbc-news",
                              description: "bbc",
                              url: "",
                              urlToImage: "url",
                              publishedAt: nil,
                              content: nil,
                              readingListStatus: false)
        presenter = .init(view: view, article: article, delegate: delegate)
    }

    func test_viewDidLoad_InvokesView() {
        XCTAssertFalse(view.invokedSetTitleLabel)
        XCTAssertFalse(view.invokedSetDescriptionLabel)
        XCTAssertFalse(view.invokedSetNewsImageView)
        XCTAssertFalse(view.invokedSetReadingListButtonTitle)
        XCTAssertNil(view.invokedSetTitleLabelParameters?.text)
        XCTAssertNil(view.invokedSetDescriptionLabelParameters?.text)
        XCTAssertNil(view.invokedSetNewsImageViewParameters?.imageUrl)

        presenter.load()
        
        XCTAssertTrue(view.invokedSetTitleLabel)
        XCTAssertTrue(view.invokedSetDescriptionLabel)
        XCTAssertTrue(view.invokedSetNewsImageView)
        XCTAssertTrue(view.invokedSetReadingListButtonTitle)
        XCTAssertEqual(view.invokedSetTitleLabelParameters?.text, "bbc-news")
        XCTAssertEqual(view.invokedSetDescriptionLabelParameters?.text, "bbc")
        XCTAssertEqual(view.invokedSetNewsImageViewParameters?.imageUrl, "url")
    }
    
    func test_addReadingListButtonTapped(){
        XCTAssertFalse(view.invokedVibrateForReadingList)
        XCTAssertFalse(delegate.invokedAddReadingListButtonTapped)
        XCTAssertNil(view.invokedSetReadingListButtonTitleParameters?.text)

        presenter.addReadingListButtonTapped()
        
        XCTAssertTrue(view.invokedVibrateForReadingList)
        XCTAssertTrue(delegate.invokedAddReadingListButtonTapped)
        XCTAssertEqual(view.invokedSetReadingListButtonTitleParameters?.text, "Okuma listemden \nçıkar")
    }
}

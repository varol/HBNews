//
//  DetailsPresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsPresenterInterface: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func fetchNewsDetails(with sourceId: String, page: Int)
    func article(_ index: Int) -> Article?
    func didSelectItemAt(index: Int)
    func fetchNextPage()
}

final class DetailsPresenter: DetailsPresenterInterface {
    private var articles: [Article] = []
    private var shouldFetchNextPage: Bool = true
    private var isLoading: Bool = false
    private var pageNumber: Int = 1

    unowned var view: DetailsViewControllerInterface?
    let router: DetailsRouterInterface!
    let interactor: DetailsInteractorInterface!

    init(interactor: DetailsInteractorInterface,  router: DetailsRouterInterface, view:  DetailsViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.prepareTableView()
        view?.prepareSearchBar("Search News")
        
        if let title = view?.getSource()?.name {
            view?.setTitle(title)
        }
        
        if let sourceId = view?.getSource()?.id {
            fetchNewsDetails(with: sourceId, page: pageNumber)
            print(sourceId)
        }
    }
    
    func numberOfItems() -> Int {
        articles.count
    }
    
    func fetchNewsDetails(with sourceId: String, page: Int) {
        interactor.fetchNewsDetails(with: sourceId, page: page)
    }
    
    func article(_ index: Int) -> Article? {
        articles[safe: index]
    }
    
    func didSelectItemAt(index: Int) {
        if let urlString = articles[safe: index]?.url, let url = URL(string: urlString){
            router.navigate(.openURL(url: url))
        }
    }
    
    func fetchNextPage() {
        if shouldFetchNextPage {
            pageNumber += 1
            if let sourceId = view?.getSource()?.id {
                fetchNewsDetails(with: sourceId, page: pageNumber)
            }
        }
    }
}

extension DetailsPresenter: DetailsInteractorOutput {
    func fetchNewsDetailsOutput(result: NewsDetailsResult) {
        switch result {
        case .success(let detailsResult):
            if let articles = detailsResult.articles {
                self.articles.append(contentsOf: articles)
            } else {
                shouldFetchNextPage = false
            }
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
}

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
    func fetchNewsDetails(with sourceId: String)
    func article(_ index: Int) -> Article?
    func didSelectRowAt(index: Int)
}

final class DetailsPresenter: DetailsPresenterInterface {
    private var articles: [Article] = []

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
            fetchNewsDetails(with: sourceId)
            print(sourceId)
        }
    }
    
    func numberOfItems() -> Int {
        articles.count
    }
    
    func fetchNewsDetails(with sourceId: String) {
        view?.showLoadingView()
        interactor.fetchNewsDetails(with: sourceId)
    }
    
    func article(_ index: Int) -> Article? {
        articles[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        if let urlString = articles[safe: index]?.url, let url = URL(string: urlString){
            router.navigate(.openURL(url: url))
        }
    }
}

extension DetailsPresenter: DetailsInteractorOutput {
    func fetchNewsDetailsOutput(result: NewsDetailsResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let detailsResult):
            self.articles = detailsResult.articles
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
}

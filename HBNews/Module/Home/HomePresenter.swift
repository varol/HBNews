//
//  HomePresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation

protocol HomePresenterInterface: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func source(_ index: Int) -> Source?

}

final class HomePresenter: HomePresenterInterface {
    
    weak var view: HomeViewControllerInterface!
    let router: HomeRouterInterface!
    let interactor: HomeInteractorInterface!

    private var sources: [Source] = []

    init(interactor: HomeInteractorInterface,  router: HomeRouterInterface, view:  HomeViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view.prepareTableView()
        interactor.fetchNewsSources()
    }
    
    func numberOfItems() -> Int {
        sources.count
    }
    
    func source(_ index: Int) -> Source? {
        sources[safe: index]
    }

}

extension HomePresenter: HomeInteractorOutput {
    func fetchNewsSourcesOutput(result: NewsSourcesResult) {
        switch result {
        case .success(let sourcesResult):
            sources = sourcesResult.sources
            view.reloadData()
        case .failure(let error):
            print(error)
        }
    }
}

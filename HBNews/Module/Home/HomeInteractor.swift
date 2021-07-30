//
//  HomeInteractor.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation

protocol HomeInteractorInterface: AnyObject {
    func fetchNewsSources()
}

protocol HomeInteractorOutput: AnyObject {
    func fetchNewsSourcesOutput(result: NewsSourcesResult)
}

typealias NewsSourcesResult = Result<NewsSourcesResponse,Error>
fileprivate var newsService: MainNewsServiceProtocol = MainNewsService()

final class HomeInteractor {
    var output: HomeInteractorOutput?
}

extension HomeInteractor: HomeInteractorInterface {
    func fetchNewsSources() {
        newsService.fetchNewsSources { (result) in
            self.output?.fetchNewsSourcesOutput(result: result)
        }
    }
}

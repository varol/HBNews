//
//  DetailsInteractor.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsInteractorInterface: AnyObject {
    func fetchNewsDetails(with sourceId: String, page: Int)
}

protocol DetailsInteractorOutput: AnyObject {
    func fetchNewsDetailsOutput(result: NewsDetailsResult)
}

typealias NewsDetailsResult = Result<NewsDetailsResponse,Error>
fileprivate var newsService: MainNewsServiceProtocol = MainNewsService()

final class DetailsInteractor {
    var output: DetailsInteractorOutput?
}

extension DetailsInteractor: DetailsInteractorInterface {
    func fetchNewsDetails(with sourceId: String, page: Int) {
        newsService.fetchDetails(sourceId: sourceId, page: page) { (result) in
            self.output?.fetchNewsDetailsOutput(result: result)
        }
    }
}

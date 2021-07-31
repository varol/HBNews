//
//  DetailsInteractor.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsInteractorInterface: AnyObject {
    func fetchNewsDetails(with sourceId: String, page: Int, qInTitle: String?)
    func refreshNewsDetails(with sourceId: String, page: Int, qInTitle: String?)

}

protocol DetailsInteractorOutput: AnyObject {
    func fetchNewsDetailsOutput(result: NewsDetailsResult)
    func refreshNewsDetailsOutput(result: NewsDetailsResult)
}

typealias NewsDetailsResult = Result<NewsDetailsResponse,Error>
fileprivate var newsService: MainNewsServiceProtocol = MainNewsService()

final class DetailsInteractor {
    var output: DetailsInteractorOutput?
}

extension DetailsInteractor: DetailsInteractorInterface {
    func fetchNewsDetails(with sourceId: String, page: Int, qInTitle: String?) {
        newsService.fetchDetails(sourceId: sourceId, page: page, qInTitle: qInTitle) { (result) in
            self.output?.fetchNewsDetailsOutput(result: result)
        }
    }
    
    func refreshNewsDetails(with sourceId: String, page: Int, qInTitle: String?) {
        newsService.fetchDetails(sourceId: sourceId, page: page, qInTitle: qInTitle) { (result) in
            self.output?.refreshNewsDetailsOutput(result: result)
        }
    }
}

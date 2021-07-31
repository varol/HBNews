//
//  ServiceManager.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation

protocol MainNewsServiceProtocol {
    func fetchNewsSources(completionHandler: @escaping
                        (NewsSourcesResult) -> ())
    func fetchDetails(sourceId: String, page: Int, qInTitle: String?, completionHandler: @escaping
                        (NewsDetailsResult) -> ())
}

struct MainNewsService: MainNewsServiceProtocol {
    func fetchNewsSources(completionHandler: @escaping (NewsSourcesResult) -> ()) {
        NetworkManager.shared.request(Router.sources,
                                      decodeToType: NewsSourcesResponse.self,
                                      completionHandler: completionHandler)
    }
    
    func fetchDetails(sourceId: String, page: Int, qInTitle: String?, completionHandler: @escaping (NewsDetailsResult) -> ()) {
        NetworkManager.shared.request(Router.everything(source: sourceId, page: page, qInTitle: qInTitle),
                                      decodeToType: NewsDetailsResponse.self,
                                      completionHandler: completionHandler)

    }
}

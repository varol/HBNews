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
}

struct MainNewsService: MainNewsServiceProtocol {
    func fetchNewsSources(completionHandler: @escaping (NewsSourcesResult) -> ()) {
        NetworkManager.shared.request(Router.sources,
                                      decodeToType: NewsSourcesResponse.self,
                                      completionHandler: completionHandler)
    }
}

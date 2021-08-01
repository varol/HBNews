//
//  NewsSourcesResponse.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import Foundation

// MARK: - NewsSourcesResponse
struct NewsSourcesResponse: Codable {
    let status: String
    let sources: [Source]
}

// MARK: - Source
struct Source: Codable {
    let id, name, sourceDescription: String?
    let url: String
    let category: Category?
    let language, country: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}

enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}

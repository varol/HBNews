//
//  NewsDetailsResponse.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

// MARK: - NewsDetailsResponse
struct NewsDetailsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: ArticleSource?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case description
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct ArticleSource: Codable {
    let id: String?
    let name: String?
}

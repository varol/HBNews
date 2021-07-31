//
//  DetailsCellPresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsCellPresenterInterface {
    func load()
}

final class DetailsCellPresenter {
    weak var view: DetailsCellInterface?
    private let article: Article

    init(view: DetailsCellInterface?,
         article: Article) {
        self.view = view
        self.article = article
    }
    
}

extension DetailsCellPresenter : DetailsCellPresenterInterface {
    func load() {
        view?.setTitleLabel(article.title ?? "")
        view?.setDescriptionLabel(article.description ?? "")
        view?.setNewsImageView(article.urlToImage ?? "")
    }
}

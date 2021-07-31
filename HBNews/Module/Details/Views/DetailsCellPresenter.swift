//
//  DetailsCellPresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsCellPresenterInterface {
    func load()
    func addReadingListButtonTapped()
}

protocol DetailsCellDelegate: AnyObject {
    func addReadingListButtonTapped(url: String)
}

extension DetailsCellPresenter {
    fileprivate enum Constants {
        static let addReadingList: String = "Okuma listeme \nekle"
        static let removeReadingList: String = "Okuma listemden \nçıkar"
    }
}

final class DetailsCellPresenter {
    weak var view: DetailsCellInterface?
    private var article: Article
    weak var delegate: DetailsCellDelegate?

    init(view: DetailsCellInterface?,
         article: Article,
         delegate: DetailsCellDelegate) {
        self.view = view
        self.article = article
        self.delegate = delegate
    }
    
    private func isAddedReadingList() -> Bool {
        article.readingListStatus ? true : false
    }
}

extension DetailsCellPresenter : DetailsCellPresenterInterface {
    func load() {
        view?.setTitleLabel(article.title ?? "")
        view?.setDescriptionLabel(article.description ?? "")
        view?.setNewsImageView(article.urlToImage ?? "")
        let buttonText = article.readingListStatus ? Constants.removeReadingList : Constants.addReadingList
        view?.setReadingListButtonTitle(buttonText, isAdded: isAddedReadingList())
    }
    
    func addReadingListButtonTapped() {
        view?.vibrateForReadingList()
        article.readingListStatus.toggle()
        if let url = article.url {
            delegate?.addReadingListButtonTapped(url: url)
            let buttonText = article.readingListStatus ? Constants.removeReadingList : Constants.addReadingList
            view?.setReadingListButtonTitle(buttonText, isAdded: !isAddedReadingList())
        }
    }
}

//
//  DetailsPresenter.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import Foundation

protocol DetailsPresenterInterface: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func fetchNewsDetails(with sourceId: String, page: Int)
    func article(_ index: Int) -> Article?
    func didSelectItemAt(index: Int)
    func fetchNextPage()
    func searchNewsWithTitle(qInTitle: String)
    func addReadingListArticle(url: String)
}

extension DetailsPresenter {
    fileprivate enum Constants {
        static let firstPageIndex: Int = 1
        static let pageTitle: String = "Search News"
        static let minimumDelayForSearching: Double = 0.7
        static let readingList = "readingList"
    }
}

final class DetailsPresenter: DetailsPresenterInterface {
    
    private var articles: [Article] = []
    private var shouldFetchNextPage: Bool = true
    private var isLoading: Bool = false
    private var pageNumber: Int = Constants.firstPageIndex
    private let throttler: ThrottlerInterface
    weak var timer: Timer?

    weak var view: DetailsViewControllerInterface?
    let router: DetailsRouterInterface!
    let interactor: DetailsInteractorInterface!

    init(interactor: DetailsInteractorInterface,
         router: DetailsRouterInterface,
         view:  DetailsViewControllerInterface,
         throttler: ThrottlerInterface = Throttler(minimumDelay: Constants.minimumDelayForSearching)) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.throttler = throttler
    }
    
    func viewDidLoad() {
        view?.prepareTableView()
        view?.prepareNavigationBar()
        view?.prepareSearchBar(Constants.pageTitle)
        startTimer()
        if let title = view?.getSource()?.name {
            view?.setTitle(title)
        }
        
        if let sourceId = view?.getSource()?.id {
            fetchNewsDetails(with: sourceId, page: pageNumber)
        }
    }
    
    func numberOfItems() -> Int {
        articles.count
    }
    
    func fetchNewsDetails(with sourceId: String, page: Int) {
        interactor.fetchNewsDetails(with: sourceId, page: page, qInTitle: nil)
    }
    
    func refreshNewsDetails(with sourceId: String, page: Int) {
        interactor.refreshNewsDetails(with: sourceId, page: page, qInTitle: nil)
    }

    func article(_ index: Int) -> Article? {
        articles[safe: index]
    }
    
    func didSelectItemAt(index: Int) {
        if let urlString = articles[safe: index]?.url, let url = URL(string: urlString){
            router.navigate(.openURL(url: url))
        }
    }
    
    func fetchNextPage() {
        if shouldFetchNextPage {
            pageNumber += 1
            if let sourceId = view?.getSource()?.id {
                fetchNewsDetails(with: sourceId, page: pageNumber)
            }
        }
    }
    
    func searchNewsWithTitle(qInTitle: String) {
        articles.removeAll()
        pageNumber = Constants.firstPageIndex
        
        throttler.throttle {[weak self] in
            guard let self = self else { return }
            if let sourceId = self.view?.getSource()?.id {
                self.interactor.fetchNewsDetails(with: sourceId,
                                                 page: self.pageNumber,
                                                 qInTitle: qInTitle)
            }
        }
    }
    
    func addReadingListArticle(url: String) {
        var readingListArray = UserDefaults.standard.array(forKey: Constants.readingList) ?? [String]()

        if let readingListStringArray = readingListArray as? [String] {
            if let index = readingListStringArray.firstIndex(of: url) {
                readingListArray.remove(at: index)
            } else {
                readingListArray.append(url)
            }
        }

        UserDefaults.standard.set(readingListArray, forKey: Constants.readingList)
        UserDefaults.standard.synchronize()
    }
    
    private func checkAndReplaceForReadingList() {
        guard let readingListArray: [String] = UserDefaults.standard.array(forKey: Constants.readingList) as? [String] else {
            view?.reloadData()
            return
        }

        for (index, item) in articles.enumerated() {
            if let url = item.url {
                if readingListArray.contains(url) {
                    articles[index].readingListStatus = true
                }
            }
        }
        view?.reloadData()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            print("hello")
            if let sourceId = self.view?.getSource()?.id {
                self.refreshNewsDetails(with: sourceId, page: Constants.firstPageIndex)
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
    }

    deinit {
        stopTimer()
    }
}

extension DetailsPresenter: DetailsInteractorOutput {
    func fetchNewsDetailsOutput(result: NewsDetailsResult) {
        switch result {
        case .success(let detailsResult):
            if let articles = detailsResult.articles {
                self.articles.append(contentsOf: articles)
            } else {
                shouldFetchNextPage = false
            }
            
            checkAndReplaceForReadingList()
            view?.hideKeyboard()
        case .failure(let error):
            print(error)
        }
    }
    
    func refreshNewsDetailsOutput(result: NewsDetailsResult) {
        switch result {
        case .success(let refreshResult):
            if refreshResult.articles?.first?.url != self.articles.first?.url {
                if let articles = refreshResult.articles {
                    self.articles.removeAll()
                    pageNumber = Constants.firstPageIndex
                    self.articles.append(contentsOf: articles)
                }
            }
            checkAndReplaceForReadingList()

        case .failure(let error):
            print(error)
        }
    }
}

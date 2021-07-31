//
//  DetailsViewController.swift
//  HBNews
//
//  Created by Varol AKSOY on 31.07.2021.
//

import UIKit

protocol DetailsViewControllerInterface: AnyObject {
    func prepareTableView()
    func prepareSearchBar(_ placeholder: String)
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
    func getSource() -> Source?
}

final class DetailsViewController: BaseViewController, LoadingShowable {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var presenter: DetailsPresenterInterface!
    var source: Source?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.delegate = self

    }
}

extension DetailsViewController: DetailsViewControllerInterface {
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(cellType: DetailsCell.self)
    }
    
    func prepareSearchBar(_ placeholder: String) {
        searchBar.tintColor = .white
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .prominent
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func getSource() -> Source? {
        source
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == tableView,
            (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height else { return }
        presenter.fetchNextPage()
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DetailsCell.self,
                                                 for: indexPath)
        if let article = presenter.article(indexPath.item) {
            cell.presenter = DetailsCellPresenter(view: cell, article: article)
        }
        return cell
    }
}

extension DetailsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
    }
}

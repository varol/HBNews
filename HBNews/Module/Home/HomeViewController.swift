//
//  HomeViewController.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import UIKit

protocol HomeViewControllerInterface: AnyObject {
    func prepareTableView()
    func reloadData()
}

class HomeViewController: BaseViewController {
    var presenter: HomePresenterInterface!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension HomeViewController: HomeViewControllerInterface {
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(cellType: SourcesCell.self)
    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SourcesCell.self,
                                                 for: indexPath)
        if let source = presenter.source(indexPath.item) {
            cell.presenter = SourcesCellPresenter(view: cell, source: source)
        }
        return cell
    }
}

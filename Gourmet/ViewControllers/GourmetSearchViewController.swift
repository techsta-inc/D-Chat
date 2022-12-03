//
//  GourmetSearchViewController.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/02.
//

import UIKit

final class GourmetSearchViewController: UIViewController {
    @IBOutlet private var tableview: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    private let gourmetSearchModel = GourmetSearchModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        gourmetSearchModel.delegate = self
    }
}

// MARK: GourmetSearchModelDelegate
extension GourmetSearchViewController: GourmetSearchModelDelegate {
    func searchSuccess() {
        tableview.reloadData()
    }
    func searchError() {
        // TODO: エラー時の実装をする
    }
}

// MARK: UISearchBar
extension GourmetSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        gourmetSearchModel.search(text: searchBar.text)
    }
}

// MARK: UITableViewDelegate
extension GourmetSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: UITableViewDatasource
extension GourmetSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gourmetSearchModel.gourmetList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = gourmetSearchModel.gourmetList[indexPath.row].name
        return cell
    }
}

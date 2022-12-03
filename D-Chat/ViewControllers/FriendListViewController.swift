//
//  FriendListViewController.swift
//  D-Chat
//
//  Created by Tanaka Soushi on 2022/12/02.
//

import UIKit

final class FriendListViewController: UIViewController {
    @IBOutlet private var tableview: UITableView!
    private let friendListModel = FriendListModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "友達"
        tableview.delegate = self
        tableview.dataSource = self
    }
}

// MARK: UITableViewDelegate
extension FriendListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: UITableViewDatasource
extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendListModel.friendList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = friendListModel.friendList[indexPath.row].name
        return cell
    }
}

//
//  TalkListViewController.swift
//  D-Chat
//
//  Created by Tanaka Soushi on 2022/12/02.
//

import UIKit

class TalkListViewController: UIViewController {
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
}

// MARK: UITableViewDelegate
extension TalkListViewController: UITableViewDelegate {
}
// MARK: UITableViewDatasource
extension TalkListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

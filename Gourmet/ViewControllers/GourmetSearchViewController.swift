//
//  GourmetSearchViewController.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/02.
//

import CoreLocation
import UIKit

final class GourmetSearchViewController: UIViewController {
    @IBOutlet private var tableview: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    private let gourmetSearchModel = GourmetSearchModel()
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        gourmetSearchModel.delegate = self
        tableview.register(GourmetTableViewCell.self)
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
        let cell = tableView.dequeueReusableCell(GourmetTableViewCell.self, for: indexPath)
        cell.configure(gourmet: gourmetSearchModel.gourmetList[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}
// MARK: Gourmet
extension GourmetSearchViewController: GourmetTableViewCellDelegate {
    func favoriteButtonTapped(_ data: GourmetViewDataModel, indexPath: IndexPath) {
        // Modelに通知
    }
}
// MARK: CLLocationManagerDelegate
extension GourmetSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = Double(location.coordinate.latitude)
        let long = Double(location.coordinate.longitude)
        gourmetSearchModel.setLocation(lat: lat, long: long)
    }
    // 記述しておかないと実行時エラーになる
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

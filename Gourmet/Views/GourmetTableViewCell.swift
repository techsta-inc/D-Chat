//
//  GourmetTableViewCell.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/04.
//

import UIKit

class GourmetTableViewCell: UITableViewCell {
    @IBOutlet private var shopIconImageView: UIImageView!
    @IBOutlet private var shopName: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var nearestStationLabel: UILabel!
    @IBOutlet private var budgetValueLabel: UILabel!

    override func prepareForReuse() {
        shopIconImageView.image = nil
    }
    func configure(gourmet: GourmetViewDataModel) {
        shopName.text = gourmet.name

        Cache.shared.fetchImage(url: gourmet.shopIcon) { [weak self] data in
            DispatchQueue.main.async { [weak self] in
                if let data = data {
                    self?.shopIconImageView.image = UIImage(data: data)
                } else {
                    self?.shopIconImageView.image = Asset.imagePlaceholder.image
                }
            }
        }
    }
}

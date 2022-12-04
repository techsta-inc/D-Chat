//
//  GourmetTableViewCell.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/04.
//

import UIKit

protocol GourmetTableViewCellDelegate: AnyObject {
    func favoriteButtonTapped(_ data: GourmetViewDataModel, indexPath: IndexPath)
}

final class GourmetTableViewCell: UITableViewCell {
    @IBOutlet private var shopIconImageView: UIImageView!
    @IBOutlet private var shopName: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var nearestStationLabel: UILabel!
    @IBOutlet private var budgetValueLabel: UILabel!
    @IBOutlet private var favoriteButton: UIButton!
    weak var delegate: GourmetTableViewCellDelegate?
    private var isFavorite: Bool = false {
        willSet {
            if isFavorite {
                favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }

    override func prepareForReuse() {
        shopIconImageView.image = nil
    }
    func configure(gourmet: GourmetViewDataModel, indexPath: IndexPath) {
        shopName.text = gourmet.name
        isFavorite = false // ViewDataModelにお気に入りフラグを持たせたい。

        favoriteButton.addAction(.init(handler: { [weak self] _ in
            self?.delegate?.favoriteButtonTapped(gourmet, indexPath: indexPath)
            self?.isFavorite.toggle()
        }), for: .touchUpInside)

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

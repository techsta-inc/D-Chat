//
//  UITableView+Extension.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/04.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: .main), forCellReuseIdentifier: className)
    }
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
}

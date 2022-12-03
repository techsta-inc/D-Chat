//
//  ViewController.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/11/28.
//

import UIKit

private enum ClassTabType: Equatable, CaseIterable {
    case search
    case favorite
    var tabTitle: String {
        switch self {
        case .search:
            return L10n.search
        case .favorite:
            return L10n.favorite
        }
    }
    var viewController: UIViewController.Type {
        switch self {
        case .search:
            return GourmetSearchViewController.self
        case .favorite:
            return FavoriteGourmetListViewController.self
        }
    }
    var image: UIImage? {
        switch self {
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .favorite:
            return UIImage(systemName: "star")
        }
    }
}

final class TopTabViewController: UITabBarController {
    private var viewControllerList: [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        appendViewController()
        setupAppearance()
    }
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemOrange
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
            tabBar.standardAppearance = appearance
        } else {
            tabBar.standardAppearance = appearance
        }
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .blue
    }
    private func appendViewController() {
        ClassTabType.allCases.enumerated().forEach { index, classTabType in
            let viewController = classTabType.viewController.init()
            viewController.tabBarItem = .init(
                title: classTabType.tabTitle,
                image: classTabType.image,
                tag: index
            )
            viewController.title = classTabType.tabTitle
            let navigationController = UINavigationController(rootViewController: viewController)
            viewControllerList.append(navigationController)
        }
        setViewControllers(viewControllerList, animated: false)
    }
}

//
//  ViewController.swift
//  D-Chat
//
//  Created by Tanaka Soushi on 2022/11/28.
//

import UIKit

private enum ClassTabType: Equatable, CaseIterable {
    case friendList
    case talkList
    var tabTitle: String {
        switch self {
        case .friendList:
            return "友達"
        case .talkList:
            return "トーク"
        }
    }
    var viewController: UIViewController.Type {
        switch self {
        case .friendList:
            return FriendListViewController.self
        case .talkList:
            return TalkListViewController.self
        }
    }
    var image: UIImage? {
        switch self {
        case .friendList:
            return UIImage(systemName: "person.2")
        case .talkList:
            return UIImage(systemName: "message")
        }
    }
}

final class ChatTabViewController: UITabBarController {
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
            let navigationController = UINavigationController(rootViewController: viewController)
            viewControllerList.append(navigationController)
        }
        setViewControllers(viewControllerList, animated: false)
    }
}

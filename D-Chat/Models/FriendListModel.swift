//
//  FriendListModel.swift
//  D-Chat
//
//  Created by Tanaka Soushi on 2022/12/03.
//

import Foundation

final class FriendListModel {
    private(set) var friendList: [FriendViewDataModel] = []
    init() {
        setupTestUser()
    }
    private func setupTestUser() {
        for i in 0..<20 {
            friendList.append(.init(name: "テストユーザー\(i)"))
        }
    }
}

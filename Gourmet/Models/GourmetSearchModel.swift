//
//  GourmetSearchModel.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/03.
//

import Foundation

final class GourmetSearchModel {
    private(set) var gourmetList: [GourmetViewDataModel] = []
    init() {
        setupTestUser()
    }
    private func setupTestUser() {
        for i in 1..<21 {
            gourmetList.append(.init(name: "テストデータ\(i)"))
        }
    }
}

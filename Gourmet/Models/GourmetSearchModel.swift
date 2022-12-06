//
//  GourmetSearchModel.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/03.
//

import Foundation

protocol GourmetSearchModelDelegate: AnyObject {
    func searchSuccess()
    func searchError()
}

final class GourmetSearchModel {
    weak var delegate: GourmetSearchModelDelegate?
    private let repository: GourmetRepositoryType
    private(set) var gourmetList: [GourmetViewDataModel] = []
    init(repository: GourmetRepositoryType = GourmetRepository()) {
        self.repository = repository
    }
    func search(text: String?) {
        guard let text = text else { return }
        repository.search(keyword: text) { [weak self] result in
            switch result {
            case let .failure(error):
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.searchError()
                }
            case let .success(response):
                let gourmetList = response.results.shop.map {
                    GourmetViewDataModel(
                        name: $0.name,
                        shopIcon: $0.logoImage
                    )
                }
                self?.gourmetList = gourmetList
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.searchSuccess()
                }
            }
        }
    }
}

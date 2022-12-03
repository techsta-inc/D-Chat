//
//  GourmetRepository.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/04.
//

import Foundation

protocol GourmetRepositoryType {
    func search(keyword: String, _ completion: @escaping (Result<HotPepperResponse, Error>) -> Void)
}

final class GourmetRepository: GourmetRepositoryType {
    let apiClient = APIClient()
    func search(keyword: String, _ completion: @escaping (Result<HotPepperResponse, Error>) -> Void) {
        let request = GourmetAPI.SearchGourmetRequest(queryItems: [
            .init(name: "keyword", value: keyword)
        ])
        apiClient.request(request: request, completion)
    }
}

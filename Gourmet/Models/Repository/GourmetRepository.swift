//
//  GourmetRepository.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/04.
//

import Foundation

protocol GourmetRepositoryType {
    func search(keyword: String, location: (lat: Double, long: Double)?, _ completion: @escaping (Result<HotPepperResponse, Error>) -> Void)
}

final class GourmetRepository: GourmetRepositoryType {
    let apiClient = APIClient()
    func search(keyword: String, location: (lat: Double, long: Double)?, _ completion: @escaping (Result<HotPepperResponse, Error>) -> Void) {
        var queryItems: [URLQueryItem] = [.init(name: "keyword", value: keyword)]
        if let location = location {
            queryItems.append(.init(name: "lat", value: "\(location.lat)"))
            queryItems.append(.init(name: "lng", value: "\(location.long)"))
        }
        let request = GourmetAPI.SearchGourmetRequest(queryItems: [
            .init(name: "keyword", value: keyword)
        ])
        apiClient.request(request: request, completion)
    }
}

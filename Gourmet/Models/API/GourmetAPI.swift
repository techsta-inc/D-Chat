//
//  GourmetRepository.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/04.
//

import Foundation

protocol RequestType {
    var urlComponents: URLComponents { get }
    associatedtype Response: Codable
}

struct GourmetAPI {
    static var baseURLString: String {
        "https://webservice.recruit.co.jp"
    }
    static var defaultQueryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = [
            .init(name: "format", value: "json"),
            .init(name: "key", value: "YourAPIKey"),
            .init(name: "count", value: "50")
        ]
        if let location = Location.shared.longLat {
            queryItems.append(.init(name: "lat", value: "\(location.lat)"))
            queryItems.append(.init(name: "lng", value: "\(location.long)"))
        }
        return queryItems
    }
    struct SearchGourmetRequest: RequestType {
        typealias Response = HotPepperResponse
        var urlComponents: URLComponents = URLComponents(string: "\(GourmetAPI.baseURLString)/hotpepper/gourmet/v1/")!
        init(queryItems: [URLQueryItem]) {
            urlComponents.queryItems = GourmetAPI.defaultQueryItems + queryItems
        }
    }
}

final class APIClient {
    func request<Request: RequestType>(request: Request, _ completion: @escaping (Result<Request.Response, Error>) -> Void) {
        URLSession.shared.dataTask(with: request.urlComponents.url!, completionHandler: { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("response.statusCode = \(response.statusCode)")
            }
            if let error = error {
                completion(.failure(error))
                print("Error: \(error)")
            }

            guard let jsonData = data else { return }
            do {
                let response = try JSONDecoder().decode(Request.Response.self, from: jsonData)
                completion(.success(response))
            } catch {
                completion(.failure(error))
                print("decodeError: \(error)")
            }
        })
        .resume()
    }
}

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
    struct SearchGourmetRequest: RequestType {
        typealias Response = HotPepperResponse
        var urlComponents: URLComponents = URLComponents(string: "\(GourmetAPI.baseURLString)/hotpepper/gourmet/v1/")!
        init(queryItems: [URLQueryItem]) {
            let defaultQueryItems: [URLQueryItem] = [
                .init(name: "format", value: "json"),
                .init(name: "key", value: "fb420e8fa5cb94a2"),
                .init(name: "count", value: "50")
            ]
            urlComponents.queryItems = defaultQueryItems + queryItems
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

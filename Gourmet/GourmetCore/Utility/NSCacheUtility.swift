//
//  NSCacheUtility.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/04.
//

import Foundation
import UIKit

final class Cache: NSCache<AnyObject, AnyObject> {
    static let shared = Cache()
    override private init() {}
    func fetchImage(url: URL?, completion: @escaping (Data?) -> Void) {
        guard let url = url else { return }
        if let imageData = getImage(url: url) {
            completion(imageData)
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, _, _ in
            guard let data = data else { return }
            completion(data)
            self?.setImage(data: data, forKey: url)
        })
        task.resume()
    }
    private func setImage(data: Data, forKey: URL) {
        Cache.shared.setObject(data as AnyObject, forKey: forKey as AnyObject)
    }
    private func getImage(url: URL) -> Data? {
        Cache.shared.object(forKey: url as AnyObject) as? Data
    }
}

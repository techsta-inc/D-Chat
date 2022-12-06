//
//  LocationShared.swift
//  Gourmet
//
//  Created by Tanaka Soushi on 2022/12/07.
//

import Foundation

final class Location {
    var longLat: LongLat?
    static let shared = Location()
    private init() {}
    struct LongLat {
        /// 経度    渋谷駅：35.6581
        let lat: Double
        /// 緯度    渋谷駅：139.7017
        let long: Double
    }
}

//
//  FeatureList.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 18.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class FeatureList {

    public struct FeatureFlag: Codable {
        let musicUrl: String
        let itemsLimitCount: String
        let volume: Int

        private enum CodingKeys: String, CodingKey {
            case musicUrl = "MusicUrl"
            case itemsLimitCount = "LimitItems"
            case volume = "Volume"
        }
    }

    private static let plistName: String = "FeatureList"
    let featureFlag: FeatureFlag!

    init() {
        do {
            let propertiesDecoder = PropertyListDecoder()
            let data = try? Data(
                contentsOf: Bundle.main.url(forResource: FeatureList.plistName, withExtension: "plist")!)
            featureFlag = try? propertiesDecoder.decode(FeatureFlag.self, from: data!)
        }
    }
}

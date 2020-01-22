//
//  SearchResponse.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public struct SearchResponse: Decodable {
    public let resultCount: Int
    public let results: [Track]
}

public struct Track: Decodable {
    public let trackName: String
    public let collectionName: String?
    public let artistName: String
    public let artworkUrl100: String?
    public let previewUrl: String?
}

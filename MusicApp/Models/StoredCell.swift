//
//  StoredCell.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 22.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public class StoredCell: NSObject, NSCoding, Identifiable {
    public var id = UUID()
    public var iconUrlString: String?
    public var trackName: String = ""
    public var collectionName: String = ""
    public var artistName: String = ""
    public var previewUrl: String?
    
    public func encode(with coder: NSCoder) {
        coder.encode(iconUrlString, forKey: "iconUrlString")
        coder.encode(trackName, forKey: "trackName")
        coder.encode(collectionName, forKey: "collectionName")
        coder.encode(artistName, forKey: "artistName")
        coder.encode(previewUrl, forKey: "previewUrl")
    }
    
    public required init?(coder: NSCoder) {
        iconUrlString = coder.decodeObject(forKey: "iconUrlString") as? String ?? ""
        trackName = coder.decodeObject(forKey: "trackName") as? String ?? ""
        collectionName = coder.decodeObject(forKey: "collectionName") as? String ?? ""
        artistName = coder.decodeObject(forKey: "artistName") as? String ?? ""
        previewUrl = coder.decodeObject(forKey: "previewUrl") as? String ?? ""
    }
    
    public init(model: SearchViewModel.Cell) {
        iconUrlString = model.iconUrlString
        trackName = model.trackName
        collectionName = model.collectionName
        artistName = model.artistName
        previewUrl = model.previewUrl
        super.init()
    }
}

//
//  SearchModels.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright (c) 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public enum Search {
    public enum Model {
        public enum Request {
            case getTracks(searchTerm: String)
        }
        public enum Response {
            case presentTracks(searchResponse: SearchResponse?)
            case presentFooterView
        }
        public enum ViewModel {
            case displayTracks(searchViewModel: SearchViewModel)
            case displayFooterView
        }
    }
}

public struct SearchViewModel {
    public struct Cell: TrackCellViewModel {
        public let iconUrlString: String?
        public let trackName: String
        public let collectionName: String
        public let artistName: String
        public let previewUrl: String?
    }
    
    public let cells: [Cell]
}

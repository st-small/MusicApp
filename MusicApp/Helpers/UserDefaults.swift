//
//  UserDefaults.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 21.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import Foundation

public extension UserDefaults {
    private static let favouriteTrackKey = "favouriteTrackKey"
    
    func getSavedTracks() -> [StoredCell] {
        guard let savedTracks = Self.standard.object(forKey: Self.favouriteTrackKey) as? Data else { return [] }
        guard let decodedTracksModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTracks) as? SearchViewStoredModel else { return [] }
        
        return decodedTracksModel.cells
    }
    
    func saveTracks(tracksModel: SearchViewStoredModel) {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracksModel, requiringSecureCoding: false) {
            Self.standard.set(savedData, forKey: Self.favouriteTrackKey)
        }
    }
}

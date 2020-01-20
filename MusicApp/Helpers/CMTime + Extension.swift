//
//  CMTime + Extension.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 19.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import AVKit
import Foundation

public extension CMTime {
    
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormattedString = String(format: "%02d:%02d", minutes, seconds)
        
        return timeFormattedString
    }
}

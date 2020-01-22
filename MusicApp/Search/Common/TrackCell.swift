//
//  TrackCell.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import SDWebImage
import UIKit

public protocol TrackCellViewModel {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

public class TrackCell: UITableViewCell {
    
    public static let reuseId = "TrackCell"
    
    // MARK: - UI elements
    @IBOutlet private weak var trackImageView: UIImageView!
    @IBOutlet private weak var trackName: UILabel!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var collectionName: UILabel!
    @IBOutlet private weak var addTrack: UIButton!
    
    // MARK: - Services
    private let defaults = UserDefaults.standard
    
    // MARK: - Data
    private var cell: SearchViewModel.Cell?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    public func set(viewModel: SearchViewModel.Cell) {
        
        cell = viewModel
        
        let savedTracks = defaults.getSavedTracks()
        let hasFavourite = savedTracks.firstIndex(where: { $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName }) != nil
        addTrack.isHidden = hasFavourite == true ? true : false
        
        trackName.text = viewModel.trackName
        artistName.text = viewModel.artistName
        collectionName.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    // MARK: - Actions
    @IBAction private func addTrackAction() {
        guard let cell = cell else { return }
        addTrack.isHidden = true
        
        var listOfTracks = defaults.getSavedTracks().map({ SearchViewModel.Cell(model: $0) })
        listOfTracks.append(cell)
        
        let stored = SearchViewStoredModel(model: listOfTracks)
        defaults.saveTracks(tracksModel: stored)
    }
}

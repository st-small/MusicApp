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
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        trackImageView.image = nil
    }
    
    public func set(viewModel: TrackCellViewModel) {
        trackName.text = viewModel.trackName
        artistName.text = viewModel.artistName
        collectionName.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        trackImageView.sd_setImage(with: url, completed: nil)
    }
}

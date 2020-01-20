//
//  SearchPresenter.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright (c) 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response)
}

public class SearchPresenter: SearchPresentationLogic {
    public weak var viewController: SearchDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: Search.Model.Response) {
        switch response {
        case .presentTracks(let searchResults):
            let cells = searchResults?.results.map({ cellViewModel(from: $0) }) ?? []
            let searchViewModel = SearchViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayTracks(searchViewModel: searchViewModel))
        case .presentFooterView:
            viewController?.displayData(viewModel: .displayFooterView)
        }
    }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell(iconUrlString: track.artworkUrl100,
                                    trackName: track.trackName,
                                    collectionName: track.collectionName ?? "",
                                    artistName: track.artistName,
                                    previewUrl: track.previewUrl)
    }
}

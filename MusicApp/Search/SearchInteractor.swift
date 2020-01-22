//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright (c) 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol SearchBusinessLogic {
    func makeRequest(request: Search.Model.Request)
}

public protocol SearchDataStore { }

public class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    
    // MARK: - Services
    public var presenter: SearchPresentationLogic?
    private var networkService = NetworkService()
    
    // MARK: - Main logic
    public func makeRequest(request: Search.Model.Request) {
        switch request {
        case .getTracks(let searchTerm):
            loadTracks(searchTerm)
        }
    }
    
    private func loadTracks(_ searchTerm: String) {
        presenter?.presentData(response: .presentFooterView)
        networkService.fetchTracks(searchText: searchTerm) { [weak self] (searchResponse) in
            self?.presenter?.presentData(response: .presentTracks(searchResponse: searchResponse))
        }
    }
}

//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright (c) 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public protocol SearchDisplayLogic: class {
    func displayData(viewModel: Search.Model.ViewModel)
}

public class SearchViewController: UIViewController {
    
    // MARK: - UI elements
    @IBOutlet private weak var tracksTable: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var footerView = SearchFooterView()
    
    // MARK: - Data
    private var timer: Timer?
    private var searchViewModel = SearchViewModel(cells: [])
    public weak var tabBarDelegate: MainTabBarControllerDelegate?
    
    // MARK: - Services
    private let networkService = NetworkService()
    public var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    private var interactor: SearchBusinessLogic?
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        userInterfaceSetup()
    }
    
    private func userInterfaceSetup() {
        view.backgroundColor = .white
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        setupSearchBar()
        setupTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let keyWindow = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.filter({ $0.isKeyWindow }).first
        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
        tabBarVC?.trackDetailView.delegate = self
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        tracksTable.register(nib, forCellReuseIdentifier: TrackCell.reuseId)
        tracksTable.tableFooterView = footerView
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = searchViewModel.cells[indexPath.row]
        tabBarDelegate?.maximizeTrackDetailController(viewModel: cellViewModel)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Plaese enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchViewModel.cells.count > 0 ? 0 : 250
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseId, for: indexPath) as! TrackCell
        let cellViewModel = searchViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.interactor?.makeRequest(request: .getTracks(searchTerm: searchText))
        })
    }
}

extension SearchViewController: SearchDisplayLogic {
    public func displayData(viewModel: Search.Model.ViewModel) {
        switch viewModel {
        case .displayTracks(let searchViewModel):
            self.searchViewModel = searchViewModel
            tracksTable.reloadData()
            footerView.hideLoader()
        case .displayFooterView:
            footerView.showLoader()
        }
    }
}

// MARK: - TrackMovingDelegate
extension SearchViewController: TrackMovingDelegate {
    
    private func getTrack(isForwardTrack: Bool) -> SearchViewModel.Cell? {
        guard let indexPath = tracksTable.indexPathForSelectedRow else { return nil }
        tracksTable.deselectRow(at: indexPath, animated: true)
        var nextIndexPath: IndexPath!
        if isForwardTrack {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if nextIndexPath.row == searchViewModel.cells.count {
                nextIndexPath.row = 0
            }
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if nextIndexPath.row == -1 {
                nextIndexPath.row = searchViewModel.cells.count - 1
            }
        }
        
        tracksTable.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        
        return searchViewModel.cells[nextIndexPath.row]
    }
    
    public func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        return getTrack(isForwardTrack: false)
    }
    
    public func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        return getTrack(isForwardTrack: true)
    }
}

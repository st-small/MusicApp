//
//  SearchRouter.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 17.01.2020.
//  Copyright (c) 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

@objc
public protocol SearchRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

public protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get }
}

public class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    public weak var viewController: SearchViewController?
    public var dataStore: SearchDataStore?
    
    // MARK: - Routing
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: - Passing data
    //func passDataToSomewhere(source: SearchDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}

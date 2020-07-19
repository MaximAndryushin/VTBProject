//
//  HistoryRouter.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

@objc protocol HistoryRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HistoryDataPassing {
    var dataStore: HistoryDataStore? { get }
}

final class HistoryRouter: NSObject, HistoryRoutingLogic, HistoryDataPassing {
    weak var viewController: HistoryViewController?
    var dataStore: HistoryDataStore?
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: HistoryViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: HistoryDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}

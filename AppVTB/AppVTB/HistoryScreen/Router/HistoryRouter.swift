//
//  HistoryRouter.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

protocol HistoryRoutingLogic {
    func showDetailedView(_ name: String)
}

final class HistoryRouter {
    
    weak var viewController: HistoryViewController?
    weak var dataStore: HistoryDataStore?
}


extension HistoryRouter: HistoryRoutingLogic {
    
    func showDetailedView(_ name: String) {
        DispatchQueue.main.async {
            let first = self.dataStore?.queries.first(where: { $0.getName() == name })
            self.viewController?.present(DetailedViewController(viewModel: first!), animated: true, completion: nil)
        }
    }
    
    
}

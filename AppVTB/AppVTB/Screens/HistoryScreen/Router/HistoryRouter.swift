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
    
    unowned let view: UIViewController
    weak var dataStore: HistoryDataStore?
    
    init(view: UIViewController) {
        self.view = view
    }
}


extension HistoryRouter: HistoryRoutingLogic {
    
    func showDetailedView(_ name: String) {
        DispatchQueue.main.async {
            if let first = self.dataStore?.queries.first(where: { $0.name == name }) {
                self.view.present(DetailedViewController(viewModel: first), animated: true, completion: nil)
            }
        }
    }
    
    
}

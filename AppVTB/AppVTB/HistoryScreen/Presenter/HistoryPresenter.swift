//
//  HistoryPresenter.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

protocol HistoryPresentationLogic {
    func presentQueries(response: History.ShowQueries.Response)
}

final class HistoryPresenter: HistoryPresentationLogic {
    
    weak var viewController: HistoryDisplayLogic?
    
    
    // MARK: - presentQueries
    
    func presentQueries(response: History.ShowQueries.Response) {
        let queries = response.queries
        viewController?.displayQueries(viewModel: queries)
    }
    
}

//
//  HistoryPresenter.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


protocol HistoryPresentationLogic {
    func presentQueries(response: History.ShowQueries.Response)
}

final class HistoryPresenter: HistoryPresentationLogic {
    
    //MARK: - Constants
    
    private enum Locals {
        static let labelsViewModel = ["valid", "isValid", "countryName", "breaches"]
    }
    
    weak var viewController: HistoryDisplayLogic?
    
    
    // MARK: - presentQueries
    
    func presentQueries(response: History.ShowQueries.Response) {
        var queries = response.queries
        queries = queries.map { query in
            var temp = query
            temp.filterDesription{ key in return Locals.labelsViewModel.contains(key) }
            return temp
        }
        viewController?.displayQueries(viewModel: queries)
    }
    
}

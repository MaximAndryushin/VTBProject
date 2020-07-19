//
//  HistoryInteractor.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

protocol HistoryBusinessLogic {
    func showQueries(request: History.ShowQueries.Request)
}

protocol HistoryDataStore {
// there can be buffer i think, but how can i check what type of request this buffer????????
}

final class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {
    var presenter: HistoryPresentationLogic?
    let worker: HistoryWorker = HistoryWorker()
    
    // MARK: - Show Queries
    
    func showQueries(request: History.ShowQueries.Request) {
        let queries = worker.getQueries(with: request.type, isAscending: request.isAscending)
        let response = History.ShowQueries.Response(queries: queries)
        presenter?.presentQueries(response: response)
    }
}

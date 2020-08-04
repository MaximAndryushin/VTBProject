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
    
}

protocol DataWorker {
    func getQueries(with type: TypeOfQuery?, isAscending: Bool) -> [Query]
}

final class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {
    var presenter: HistoryPresentationLogic?
    let worker: DataWorker
    
    init(worker: DataWorker) {
        self.worker = worker
    }
    
    // MARK: - Show Queries
    
    func showQueries(request: History.ShowQueries.Request) {
        let response: History.ShowQueries.Response
        let queries = worker.getQueries(with: request.type, isAscending: request.isAscending)
        response = History.ShowQueries.Response(queries: queries)
        presenter?.presentQueries(response: response)
    }
}

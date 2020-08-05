//
//  HistoryInteractor.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

// MARK: - CleanSwift protocols
protocol HistoryBusinessLogic {
    func showQueries(request: History.ShowQueries.Request)
}

protocol HistoryDataStore {
    
}

// MARK: - DataManager protocol
protocol DataWorker {
    func getNumbers() -> [NumberDTO]
    func getEmails() -> [EmailDTO]
}

// MARK: - Interactor
final class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {
    var presenter: HistoryPresentationLogic?
    private let worker: DataWorker
    private let numberConverter: NumberDTOQueryConverter
    private let emailConverter: EmailDTOQueryConverter
    
    init(worker: DataWorker, numberConverter: NumberDTOQueryConverter, emailConverter: EmailDTOQueryConverter) {
        self.worker = worker
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
    }
    
    
    // MARK: - Show Queries
    
    func showQueries(request: History.ShowQueries.Request) {
        var response = worker.getNumbers().map{ return numberConverter.convertToQuery(from: $0)}
        response.append(contentsOf: worker.getEmails().map{ return emailConverter.convertToQuery(from: $0)})
        presenter?.presentQueries(response: History.ShowQueries.Response(queries: response))
    }
}

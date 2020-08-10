//
//  HistoryInteractor.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

// MARK: - CleanSwift protocols
protocol HistoryBusinessLogic {
    func getQueries(request: History.ShowQueries.Request)
    func deleteQuery(query: Query)
}

protocol HistoryDataStore {
    var queries: [Query] { get }
}

// MARK: - DataManager protocol
protocol DataWorker {
    func getNumbers() -> [NumberDTO]
    func getEmails() -> [EmailDTO]
    func deleteEmail(_ name: String)
    func deleteNumber(_ name: String)
}

// MARK: - Interactor
final class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {
    
    
    //MARK: - Properties
    
    var presenter: HistoryPresentationLogic?
    internal var queries: [Query]
    private let worker: DataWorker
    private let numberConverter: NumberDTOQueryConverter
    private let emailConverter: EmailDTOQueryConverter
    
    
    //MARK: - Initailizer
    
    init(worker: DataWorker, numberConverter: NumberDTOQueryConverter, emailConverter: EmailDTOQueryConverter) {
        self.worker = worker
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
        self.queries = []
        initialSetup()
    }
    
    private func initialSetup() {
        queries = worker.getNumbers().map{ return numberConverter.convertToQuery(from: $0)}
        queries.append(contentsOf: worker.getEmails().map{ return emailConverter.convertToQuery(from: $0)})
    }
    
    
    // MARK: - Methods
    
    func getQueries(request: History.ShowQueries.Request) {
        let response = queries.filter { (query) -> Bool in
            if let type = request.type {
                return query.getType() == type
            }
            return true
        }.sorted { (first, second) -> Bool in
            return (request.isAscending != (first.getDate() > second.getDate()))
        }
        presenter?.presentQueries(response: History.ShowQueries.Response(queries: response))
    }
    
    func deleteQuery(query: Query) {
        queries.removeAll(where: { object in return query.getName() == object.getName() })
        if query.getType() == .email {
            worker.deleteEmail(query.getName())
        } else {
            worker.deleteNumber(query.getName())
        }
    }
    
}

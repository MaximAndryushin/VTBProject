//
//  HistoryInteractor.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.



// MARK: - CleanSwift protocols

protocol HistoryBusinessLogic {
    func getQueries(request: History.ShowQueries.Request)
    func deleteQuery(query: QueryViewModel)
    func updateInfo()
}

protocol HistoryDataStore: AnyObject {
    var queries: [QueryViewModel] { get }
}


// MARK: - DataManager protocol

protocol DataWorker {
    func getNumbers() -> [NumberDTO]
    func getEmails() -> [EmailDTO]
    func deleteEmail(_ name: String)
    func deleteNumber(_ name: String)
}


// MARK: - Interactor

final class HistoryInteractor: HistoryDataStore {
    
    
    //MARK: - Properties
    
    var presenter: HistoryPresentationLogic?
    internal var queries: [QueryViewModel]
    private let worker: DataWorker
    private let numberConverter: NumberDTOToViewModelConverterInput
    private let emailConverter: EmailDTOToViewModelConverterInput
    
    
    //MARK: - Initailizer
    
    init(worker: DataWorker, numberConverter: NumberDTOToViewModelConverterInput, emailConverter: EmailDTOToViewModelConverterInput) {
        self.worker = worker
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
        self.queries = []
        updateInfo()
    }
    
}

extension HistoryInteractor: HistoryBusinessLogic {
    
    func updateInfo() {
        queries = worker.getNumbers().map{ return numberConverter.convertToQuery(from: $0) }
        queries.append(contentsOf: worker.getEmails().map{ return emailConverter.convertToQuery(from: $0)} )
    }
    
    func getQueries(request: History.ShowQueries.Request) {
        let response = queries.filter { (query) -> Bool in
            if let type = request.type {
                return query.type == type
            }
            return true
        }.sorted { (first, second) -> Bool in
            return (request.isAscending != (first.date > second.date))
        }
        presenter?.presentQueries(response: History.ShowQueries.Response(queries: response))
    }
    
    func deleteQuery(query: QueryViewModel) {
        queries.removeAll(where: { object in return query.name == object.name })
        switch query.type {
        case .email:
            worker.deleteEmail(query.name)
        case .number:
            worker.deleteNumber(query.name)
        default:
            break
        }
    }
}

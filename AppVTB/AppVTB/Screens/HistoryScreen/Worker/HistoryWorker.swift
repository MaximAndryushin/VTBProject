//
//  HistoryWorker.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


final class HistoryWorker: DataWorker {
    
    //MARK: - Properties
    
    private let manager: NumberEmailDataManagerInput
    
    
    //MARK: - Initializer
    
    init(dataManager: NumberEmailDataManagerInput) {
        self.manager = dataManager
    }
    
    
    //MARK: - Methods
    
    func getNumbers() -> [NumberDTO] {
        if let models = manager.getPhoneNumbers() {
            return models
        } else {
            return []
        }
    }
    
    func getEmails() -> [EmailDTO] {
        if let models = manager.getEmails() {
            return models
        } else {
            return []
        }
    }
    
    func deleteEmail(_ name: String) {
        manager.deleteEmail(name)
    }
    
    func deleteNumber(_ name: String) {
        manager.deleteNumber(name)
    }
    
}

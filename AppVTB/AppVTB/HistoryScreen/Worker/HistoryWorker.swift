//
//  HistoryWorker.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

final class HistoryWorker: DataWorker {
    
    //MARK: - Properties
    
    private let manager: PhoneEmailDataManager
    private let numberConverter: NumberDTODAOConverter
    private let emailConverter: EmailDTODAOConverter
    
    
    //MARK: - Initializer
    
    init(dataManager: PhoneEmailDataManager, numberConverter: NumberDTODAOConverter, emailConverter: EmailDTODAOConverter) {
        self.manager = dataManager
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
    }
    
    
    //MARK: - Methods
    
    func getNumbers() -> [NumberDTO] {
        if let models = manager.getPhoneNumbers()?.map({ return numberConverter.phoneNumberToNumberDTO($0) }) {
            return models
        } else {
            return []
        }
    }
    
    func getEmails() -> [EmailDTO] {
        if let models = manager.getEmails()?.map({return emailConverter.emailToEmailDTO($0)}) {
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

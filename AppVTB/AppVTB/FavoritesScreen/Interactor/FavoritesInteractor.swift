//
//  FavoritesInteractor.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol FavoritesInteractorOutput: AnyObject {
    func infoLoaded(data: [Any])
    func showError(_ error: String)
    func appendToTable(object: Any)
}

class FavoritesInteractor {
    
    //MARK: - Constants
    enum Locals {
        static let errorMessage = "Wrong input format \n Enter number(+79102382390)/email"
    }
    
    //MARK: - Properties
    
    weak var presenter: FavoritesInteractorOutput?
    private let dataManager: PhoneEmailFavoritesDataManager
    private let numberConverter: NumberDTODAOConverter
    private let emailConverter: EmailDTODAOConverter
    private let networkManager: (EmailNetworkWorker & NumberNetworkWorker)
    
    //MARK: - Initializer
    
    init(dataManager: PhoneEmailFavoritesDataManager, numberConverter: NumberDTODAOConverter, emailConverter: EmailDTODAOConverter, networkManager: NetworkWorker) {
        self.dataManager = dataManager
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
        self.networkManager = networkManager
    }
}


//MARK: - InteractorOutput

extension FavoritesInteractor: FavoritesInteractorInput {
    
    func fetchData(_ name: String, type: TypeOfQuery) {
        switch type {
        case .email:
            networkManager.getEmail(name) { emailDTO, error in
                if let error = error {
                    self.presenter?.showError(error)
                }
                if let email = emailDTO {
                    self.dataManager.addToFavoritesEmail(email)
                    self.presenter?.appendToTable(object: email)
                }
            }
        case .number:
            networkManager.getNumber(name) { numberDTO, error in
                if let error = error {
                    self.presenter?.showError(error)
                }
                if let number = numberDTO {
                    self.dataManager.addToFavoritesNumber(number)
                    self.presenter?.appendToTable(object: number)
                }
            }
        default:
            presenter?.showError(Locals.errorMessage)
        }
    }
    
    
    func getData() {
        var queries: [Any] = dataManager.getFavoritesEmails()?.map{ return emailConverter.emailToEmailDTO($0) } ?? []
        queries.append(contentsOf: dataManager.getFavoritesNumbers()?.map{ return numberConverter.phoneNumberToNumberDTO($0) } ?? [])
        presenter?.infoLoaded(data: queries)
    }
    
    
    func delete(name: String, type: TypeOfQuery) {
        if type == .email {
            dataManager.deleteFromFavoritesEmail(name)
        } else {
            dataManager.deleteFromFavoritesNumber(name)
        }
    }
    
}

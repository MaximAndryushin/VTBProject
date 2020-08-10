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
    func showError()
    func appendToTable(object: Any)
}

class FavoritesInteractor {
    
    
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
            networkManager.getEmail(name) { emailDTO in
                self.dataManager.addToFavoritesEmail(emailDTO)
                self.presenter?.appendToTable(object: emailDTO)
            }
        case .number:
            networkManager.getNumber(name) { numberDTO in
                self.dataManager.addToFavoritesNumber(numberDTO)
                self.presenter?.appendToTable(object: numberDTO)
            }
        default:
            presenter?.showError()
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

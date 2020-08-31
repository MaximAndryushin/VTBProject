//
//  CheckInteractor.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 13.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol CheckInteractorOutput: AnyObject {
    func showError(_ name: String)
    func showInfo(object: Any)
}

final class CheckInteractor {
    
    //MARK: - Constants
    
    private enum Locals {
        static let badInput = "wrong input format \n enter email/number"
    }
    
    //MARK: - Properties
    
    weak var presenter: CheckInteractorOutput?
    private let dataManager: SaveDataManagerInput
    private let networkManager: (EmailNetworkWorkerInput & NumberNetworkWorkerInput)
    
    
    //MARK: - Initializer
    
    init(dataManager: SaveDataManagerInput, networkManager: (EmailNetworkWorkerInput & NumberNetworkWorkerInput)) {
        self.dataManager = dataManager
        self.networkManager = networkManager
    }
}


// MARK: - Check Interactor Input

extension CheckInteractor: CheckInteractorInput {
    
    func fetchData(name: String, type: TypeOfQuery) {
        switch type {
        case .email:
            networkManager.getEmail(name) { emailDTO, error in
                if let error = error {
                    self.presenter?.showError(error)
                }
                if let email = emailDTO {
                    self.dataManager.saveEmail(email)
                    self.presenter?.showInfo(object: email)
                }
            }
        case .number:
            networkManager.getNumber(name) { numberDTO, error in
                if let error = error {
                    self.presenter?.showError(error)
                }
                if let number = numberDTO {
                    self.dataManager.saveNumber(number)
                    self.presenter?.showInfo(object: number)
                }
            }
        default:
            presenter?.showError(Locals.badInput)
        }
    }
    
}

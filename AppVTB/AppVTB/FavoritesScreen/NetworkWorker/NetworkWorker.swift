//
//  NetworkWorker.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 07.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit


// MARK: - Email API

protocol EmailNetworkWorker {
    func getEmail(_ name: String, _ completion: @escaping (EmailDTO) -> ())
}


// MARK: - Phone Number API

protocol NumberNetworkWorker {
    func getNumber(_ name: String, _ completion: @escaping (NumberDTO) -> ())
}


// MARK: - Interactor Input Update Info

protocol InteractorInputNetworkResponse: AnyObject {
    func updateInfoAboutNumber(_ number: NumberDTO)
    func updateInfoAboutEmail(_ email: EmailDTO)
}


// MARK: - Network Manager

final class NetworkWorker {
    
    // MARK: - Properties
    
    private let emailInfoManager: EmailValidatorNetworkManager
    private let emailBreachManager: EmailBreachNetworkManager
    private let numberManager: PhoneNumberNetworkManager
    private let emailNetworkConverter: EmailNetworkModelToDTOConverter
    private let numberNetworkConverter: NumberNetworkModelToDTOConverter
    
    
    //MARK: - Initializer
    
    init(emailInfoManager: EmailValidatorNetworkManager, emailBreachManager: EmailBreachNetworkManager, numberManager: PhoneNumberNetworkManager, emailNetworkConverter: EmailNetworkModelToDTOConverter, numberNetworkConverter: NumberNetworkModelToDTOConverter) {
        self.emailInfoManager = emailInfoManager
        self.emailBreachManager = emailBreachManager
        self.numberManager = numberManager
        self.emailNetworkConverter = emailNetworkConverter
        self.numberNetworkConverter = numberNetworkConverter
    }
}

extension NetworkWorker: EmailNetworkWorker {
    
    func getEmail(_ name: String, _ completion: @escaping (EmailDTO) -> ()) {
        emailInfoManager.getInfo(about: name) { (email, error) in
            if let error = error {
                print(error)
            }
            
            if let email = email {
                self.emailBreachManager.getInfo(about: name) { (breaches, error) in
                    if let error = error {
                        print(error)
                    }
                    if let breaches = breaches {
                        let emailDTO = self.emailNetworkConverter.convert(email: email, breaches: breaches)
                        completion(emailDTO)
                    }
                }
            }
        }
    }
    
    
}

extension NetworkWorker: NumberNetworkWorker {
    
    func getNumber(_ name: String, _ completion: @escaping (NumberDTO) -> ()) {
        numberManager.getInfo(about: name) { (number, error) in
            if let error = error {
                print(error)
            }
            if let number = number {
                let numberDTO = self.numberNetworkConverter.convert(number: number)
                completion(numberDTO)
            }
        }
    }
    
    
}

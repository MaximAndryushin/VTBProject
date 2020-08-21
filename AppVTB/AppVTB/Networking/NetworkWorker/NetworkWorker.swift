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
    func getEmail(_ name: String, _ completion: @escaping (EmailDTO?, String?) -> ())
}


// MARK: - Phone Number API

protocol NumberNetworkWorker {
    func getNumber(_ name: String, _ completion: @escaping (NumberDTO?, String?) -> ())
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
    private let iconManager: ImageDownloadManagerInput
    private let emailNetworkConverter: EmailNetworkModelToDTOConverter
    private let numberNetworkConverter: NumberNetworkModelToDTOConverter
    
    
    // MARK: - Initializer
    
    init(emailInfoManager: EmailValidatorNetworkManager, emailBreachManager: EmailBreachNetworkManager, numberManager: PhoneNumberNetworkManager, emailNetworkConverter: EmailNetworkModelToDTOConverter, numberNetworkConverter: NumberNetworkModelToDTOConverter, iconManager: ImageDownloadManagerInput) {
        self.emailInfoManager = emailInfoManager
        self.emailBreachManager = emailBreachManager
        self.numberManager = numberManager
        self.emailNetworkConverter = emailNetworkConverter
        self.numberNetworkConverter = numberNetworkConverter
        self.iconManager = iconManager
    }
}


// MARK: - EmailNetworkWorker

extension NetworkWorker: EmailNetworkWorker {
    
    func getEmail(_ name: String, _ completion: @escaping (EmailDTO?, String?) -> ()) {
        emailInfoManager.getInfo(about: name) { (email, error) in
            if let error = error {
                completion(nil, error)
            }
            
            if let email = email {
                self.emailBreachManager.getInfo(about: name) { (breaches, error) in
                    if let error = error {
                        completion(nil, error)
                    }
                    if let breaches = breaches {
                        self.getIcons(email, breaches) { emailDTO, error in
                            completion(emailDTO, nil)
                        }
                    }
                }
            }
        }
    }
    
    private func getIcons(_ email: EmailValidationAPIModel, _ breaches: [BreachAPI], _ completion: @escaping (EmailDTO?, String?) -> ()) {
        var arrayOfBreachesAndIcons = [(BreachAPI, Data?)]()
        let group = DispatchGroup()
        for breach in breaches {
            group.enter()
            self.iconManager.getIcon(name: breach.logoPath, completion: { (logo, error) in
                if let _ = error {
                    arrayOfBreachesAndIcons.append((breach, nil))
                } else {
                    arrayOfBreachesAndIcons.append((breach, logo))
                }
                group.leave()
            })
        }
        group.notify(queue: .main) {
            let emailDTO = self.emailNetworkConverter.convert(email: email, breaches: arrayOfBreachesAndIcons)
            completion(emailDTO, nil)
        }
        
    }
}


// MARK: - NumberNetworkWorker

extension NetworkWorker: NumberNetworkWorker {
    
    func getNumber(_ name: String, _ completion: @escaping (NumberDTO?, String?) -> ()) {
        numberManager.getInfo(about: name) { (number, error) in
            if let error = error {
                completion(nil, error)
            }
            if let number = number {
                let numberDTO = self.numberNetworkConverter.convert(number: number)
                completion(numberDTO, nil)
            }
        }
    }
    
    
}

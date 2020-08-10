//
//  ViewController.swift
//  HomeWork10
//
//  Created by Maxim Andryushin on 12.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var current: UIViewController
    
    init() {
        self.current = HistoryViewController()//FavoritesAssembly.assembly()
//        let networkManager1 = EmailValidationNetworkManager()
//        let networkManager2 = EmailPasswordNetworkManager()
//        let emailNetworkConverter: EmailNetworkModelToDTOConverter = EmailNetworkModelConverter(breachConverter: BreachNetworkModelConverter())
//        let emailDTOToQueryConverter: EmailDTOQueryConverter = EmailToQueryConverter()
//        let emailDTOToCoreDataConverter: EmailDTODAOConverter = EmailConverter(converter: BreachConverter())
//
//        networkManager1.getInfo(about: "unlimimage@yandex.ru") { (email, error) in
//            if let error = error {
//                print(error)
//            }
//
//            if let email = email {
//                networkManager2.getInfo(about: "unlimimage@yandex.ru") { (breaches, error) in
//                    if let error = error {
//                        print(error)
//                    }
//                    if let breaches = breaches {
//                        let emailDTO = emailNetworkConverter.convert(email: email, breaches: breaches)
//                        let query = emailDTOToQueryConverter.convertToQuery(from: emailDTO)
//                        let _ = emailDTOToCoreDataConverter.emailDTOToEmail(emailDTO)
//                        DataManager.shared.saveContext()
//                        print(query)
//                    }
//                }
//            }
//        }

        
        
//        let networkManager3 = NumberNetworkManager()
//        let numberNetworkConverter: NumberNetworkModelToDTOConverter = NumberNetworkModelConverter()
//        let numberDTOToCoreDataConverter: NumberDTODAOConverter = NumberConverter()
//        let numberDTOToQueryConverter: NumberDTOQueryConverter = NumberToQueryConverter()
//        networkManager3.getInfo(about: "78005553535") { (number, error) in
//            if let error = error {
//                print(error)
//            }
//
//            if let number = number {
//                let numberDTO = numberNetworkConverter.convert(number: number)
//                let query = numberDTOToQueryConverter.convertToQuery(from: numberDTO)
//                let _ = numberDTOToCoreDataConverter.numberDTOToPhoneNumber(numberDTO)
//                DataManager.shared.saveContext()
//            }
//        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }

    //MARK: - Life Cycle
    
    func loadView(_ viewController: UIViewController) {
        let new = UINavigationController(rootViewController: viewController)
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }

}


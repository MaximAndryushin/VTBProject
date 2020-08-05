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
        self.current = HistoryViewController()
//        let networkManager1 = EmailValidationNetworkManager()
//        networkManager1.getInfo(about: "m.andryushin@mail.ru") { (email, error) in
//            if let error = error {
//                print(error)
//            }
//
//            if let email = email {
//                print(email.result)
//            }
//        }
//
//        let networkManager2 = EmailPasswordNetworkManager()
//        networkManager2.getInfo(about: "m.andryushin@mail.ru") { (email, error) in
//            if let error = error {
//                print(error)
//            }
//
//            if let email = email {
//                if email.count > 0 {
//                    print(email)
//                }
//                else {
//                    print("this email isn't found in any breaches")
//                }
//            }
//        }
//
//        let networkManager3 = NumberNetworkManager()
//        networkManager3.getInfo(about: "79102382390") { (number, error) in
//            if let error = error {
//                print(error)
//            }
//
//            if let number = number {
//                print(number.carrier)
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


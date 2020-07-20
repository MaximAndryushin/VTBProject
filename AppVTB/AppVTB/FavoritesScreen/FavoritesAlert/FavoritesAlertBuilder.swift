//
//  FavoritesAlertViewController.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class FavoritesAlertBuilder {
    
    //MARK: - Constants
    
    enum Locals {
        static let title = "Add new data"
        static let addTitle = "Add"
        static let cancelTitle = "Cancel"
        static let placeholder = "Enter email or phone number"
    }
    
    //MARK: - Initializers
    
    static func createAlert() -> UIAlertController {
        let view = UIAlertController(title: Locals.title, message: nil, preferredStyle: .alert)
        configureAddButton(view: view)
        configureCancelButton(view: view)
        configureTextField(view: view)
        return view
    }
    
    
    //MARK: - Setup
    
    private static func configureAddButton(view: UIAlertController) {
        let confirmAction = UIAlertAction(title: Locals.addTitle, style: .default) { (_) in
            if let txtField = view.textFields?.first, let text = txtField.text, !text.isEmpty {
                //do stuff
            }
        }
        view.addAction(confirmAction)
    }
    
    private static func configureCancelButton(view: UIAlertController) {
        let cancelAction = UIAlertAction(title: Locals.cancelTitle, style: .cancel) { (_) in }
        view.addAction(cancelAction)
    }
    
    private static func configureTextField(view: UIAlertController) {
        view.addTextField { (textField) in
            textField.placeholder = Locals.placeholder
        }
    }
    
}

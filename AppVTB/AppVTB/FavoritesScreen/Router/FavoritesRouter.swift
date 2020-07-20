//
//  FavoritesRouter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class FavoritesRouter {
    
    //MARK: - Constants
    
    enum Locals {
        static let title = "Add new data"
        static let addTitle = "Add"
        static let cancelTitle = "Cancel"
        static let placeholder = "Enter email or phone number"
    }
    
    // MARK: - Properties
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension FavoritesRouter: FavoritesRouterInput {
    func showAlert() {
        let alertController = UIAlertController(title: Locals.title, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Locals.addTitle, style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text, !text.isEmpty {
                //do stuff
            }
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: Locals.cancelTitle, style: .cancel) { (_) in }
        alertController.addAction(cancelAction)
        alertController.addTextField { (textField) in
            textField.placeholder = Locals.placeholder
        }
        view.present(alertController, animated: true, completion: nil)
    }
    
    
}

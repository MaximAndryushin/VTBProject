//
//  FavoritesRouter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class FavoritesRouter {
    
    // MARK: - Properties
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension FavoritesRouter: FavoritesRouterInput {
    func showAlert() {
        let alertController = FavoritesAlertBuilder.createAlert()
        view.present(alertController, animated: true, completion: nil)
    }
    

}

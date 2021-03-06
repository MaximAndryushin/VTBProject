//
//  FavoritesRouter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class FavoritesRouter {
    
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
}

extension FavoritesRouter: FavoritesRouterInput {
    func showDetailedView(viewModel: QueryViewModel) {
        DispatchQueue.main.async {
            self.view.present(DetailedViewController(viewModel: viewModel), animated: true, completion: nil)
        }
    }
    
}

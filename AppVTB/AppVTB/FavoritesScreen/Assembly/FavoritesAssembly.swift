//
//  FavoritesAssembly.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class FavoritesAssembly {
    
    static func assembly() -> UIViewController {
        let view = FavoritesViewController()
        let dataStore = FavoritesDataStore()
        let presenter = FavoritesPresenter(dataStore: dataStore)
        
        view.presenter = presenter
        presenter.view = view
        
        let interactor = FavoritesInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = FavoritesRouter(view: view)
        presenter.router = router
        
        return view
    }
}

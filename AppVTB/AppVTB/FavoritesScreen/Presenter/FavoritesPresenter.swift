//
//  FavoritesPresenter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol FavoritesInteractorInput {
    func loadData()
}

protocol FavoritesRouterInput {
    func showAlert()
}

final class FavoritesPresenter {
    
    //MARK: - Properties
    
    weak var view: FavoritesViewInput?
    var interactor: FavoritesInteractorInput?
    var router: FavoritesRouterInput?
    let dataStore: FavoritesDataStore
    
    
    // MARK: - Initializer
    
    init(dataStore: FavoritesDataStore) {
        self.dataStore = dataStore
    }
    
}


// MARK: - FavoritesViewOutput

extension FavoritesPresenter: FavoritesViewOutput {
    func loadData() {
        interactor?.loadData()
    }
    func addButtonClicked() {
        router?.showAlert()
    }
}

// MARK: - FavoritesInteractorOutput

extension FavoritesPresenter: FavoritesInteractorOutput {
    func infoLoaded(data: [Query]) {
        view?.updateView(viewModels: data)
    }
}

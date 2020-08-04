//
//  FavoritesInteractor.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol FavoritesInteractorOutput: AnyObject {
    func infoLoaded(data: [Query])
}

class FavoritesInteractor {
    
    //MARK: - Properties
    weak var presenter: FavoritesInteractorOutput?
    
}

extension FavoritesInteractor: FavoritesInteractorInput {
    func loadData() {
        let dataManager = HistoryWorker()
        let queries = dataManager.getQueries(with: nil, isAscending: true)
        presenter?.infoLoaded(data: queries)
    }
}

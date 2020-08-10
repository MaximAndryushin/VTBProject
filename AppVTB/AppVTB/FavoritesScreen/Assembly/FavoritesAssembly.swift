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
        let presenterConverter = FavoritesDataConverter(numberConverter: NumberToQueryConverter(), emailConverter: EmailToQueryConverter())
        let presenter = FavoritesPresenter(converter: presenterConverter, parser: EmailNumberParser())
        
        view.presenter = presenter
        presenter.view = view
        let emailConverter = EmailConverter(converter: BreachConverter())
        let networkManager = NetworkWorker(emailInfoManager: EmailValidationNetworkManager(), emailBreachManager: EmailPasswordNetworkManager(), numberManager: NumberNetworkManager(), emailNetworkConverter: EmailNetworkModelConverter(breachConverter: BreachNetworkModelConverter()), numberNetworkConverter: NumberNetworkModelConverter())
        let interactor = FavoritesInteractor(dataManager: DataManager.shared, numberConverter: NumberConverter(), emailConverter: emailConverter, networkManager: networkManager)
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = FavoritesRouter()
        presenter.router = router
        
        return view
    }
}

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
        let presenterConverter = DataToViewModelConverter(numberConverter: NumberToQueryConverter(), emailConverter: EmailToQueryConverter())
        let presenter = FavoritesPresenter(converter: presenterConverter, parser: EmailNumberParser())
        
        view.presenter = presenter
        presenter.view = view
        let networkManager = NetworkWorker(emailInfoManager: EmailValidationNetworkManager(), emailBreachManager: EmailPasswordNetworkManager(), numberManager: NumberNetworkManager(), emailNetworkConverter: EmailNetworkModelConverter(breachConverter: BreachNetworkModelConverter()), numberNetworkConverter: NumberNetworkModelConverter(), iconManager: ImageDownloadManager())
        let interactor = FavoritesInteractor(dataManager: DataManager.shared, networkManager: networkManager)
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = FavoritesRouter(view: view)
        presenter.router = router
        return view
    }
}

//
//  CheckAssembly.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 12.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit


final class CheckAssembly {
    
    static func assembly() -> UIViewController {
        let view = CheckViewController()
        let presenterConverter = DataToViewModelConverter(numberConverter: NumberToQueryConverter(), emailConverter: EmailToQueryConverter())
        let presenter = CheckPresenter(parser: EmailNumberParser(), converter: presenterConverter)

        view.presenter = presenter
        presenter.view = view
        let networkManager = NetworkWorker(emailInfoManager: EmailValidationNetworkManager(), emailBreachManager: EmailPasswordNetworkManager(), numberManager: NumberNetworkManager(), emailNetworkConverter: EmailNetworkModelConverter(breachConverter: BreachNetworkModelConverter()), numberNetworkConverter: NumberNetworkModelConverter(), iconManager: ImageDownloadManager())
        let interactor = CheckInteractor(dataManager: DataManager.shared, networkManager: networkManager)
        interactor.presenter = presenter
        presenter.interactor = interactor

        let router = CheckRouter(view: view)
        
        presenter.router = router
        
        return view
    }
}

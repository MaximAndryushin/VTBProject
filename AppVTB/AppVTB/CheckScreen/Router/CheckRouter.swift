//
//  CheckRouter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 13.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class CheckRouter {
    
    weak var view: UIViewController?
    
}

extension CheckRouter: CheckRouterInput {
    
    func showDetails(_ viewModel: QueryViewModel) {
        DispatchQueue.main.async {
            self.view?.present(DetailedViewController(viewModel: viewModel), animated: true, completion: nil)
        }
    }
}

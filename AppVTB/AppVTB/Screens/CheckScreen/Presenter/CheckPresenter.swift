//
//  CheckPresenter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 13.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol CheckViewInput: AnyObject {
    func showError(_ error: String)
}

protocol CheckInteractorInput {
    func fetchData(name: String, type: TypeOfQuery)
}

protocol CheckRouterInput {
    func showDetails(_ viewModel: QueryViewModel)
}

final class CheckPresenter {
    
    
    //MARK: - Constants
    
    private enum Locals {
        static let nothingError = "nothing to check\n please, enter email/number"
        static let strangeError = "NU ETO KONEC YA HZ CHO SLUCHILOS'"
    }
        
    //MARK: - Properties
    
    weak var view: CheckViewInput?
    var interactor: CheckInteractorInput?
    var router: CheckRouterInput?
    private var parser: ParserInput
    private var converter: DataConverterInput
    
    
    //MARK: - Initializers
    
    init(parser: ParserInput, converter: DataConverterInput) {
        self.parser = parser
        self.converter = converter
    }
}


//MARK: - CheckViewOutput

extension CheckPresenter: CheckViewOutput {
    
    func check(_ name: String?) {
        if let name = name {
            interactor?.fetchData(name: name, type: parser.getType(from: name))
        } else {
            view?.showError(Locals.nothingError)
        }
    }
    
}


//MARK: - CheckInteractorOutput

extension CheckPresenter: CheckInteractorOutput {
    
    func showError(_ name: String) {
        view?.showError(name)
    }
    
    func showInfo(object: Any) {
        if let email = object as? EmailDTO {
            router?.showDetails(converter.createViewModelFrom(email: email))
        } else if let number = object as? NumberDTO {
            router?.showDetails(converter.createViewModelFrom(number: number))
        } else {
            view?.showError(Locals.strangeError)
        }
    }
    
}

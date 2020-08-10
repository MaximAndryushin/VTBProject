//
//  FavoritesPresenter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol FavoritesInteractorInput {
    func getData()
    func fetchData(_ name: String, type: TypeOfQuery)
    func delete(name: String, type: TypeOfQuery)
}

protocol FavoritesRouterInput {

}

final class FavoritesPresenter {
    
    //MARK: - Properties
    
    weak var view: FavoritesViewInput?
    var interactor: FavoritesInteractorInput?
    var router: FavoritesRouterInput?
    private let converter: FavoritesDataConverterInput
    private let parser: Parser

    
    // MARK: - Initializer
    
    init(converter: FavoritesDataConverterInput, parser: Parser) {
        self.converter = converter
        self.parser = parser
    }
    
}


// MARK: - FavoritesViewOutput

extension FavoritesPresenter: FavoritesViewOutput {
    
    func loadData() {
        interactor?.getData()
    }
    
    func addButtonClicked() {
        view?.showAlert()
    }
    
    func delete(query: Query) {
        interactor?.delete(name: query.getName(), type: query.getType())
    }
    
    func addNewData(_ name: String) {
        interactor?.fetchData(name, type: parser.getType(from: name))
    }
    
}


// MARK: - FavoritesInteractorOutput

extension FavoritesPresenter: FavoritesInteractorOutput {
    
    func appendToTable(object: Any) {
        var viewModel: Query?
        if let email = object as? EmailDTO {
            viewModel = converter.createViewModelFrom(email: email)
        }
        if let number = object as? NumberDTO {
            viewModel = converter.createViewModelFrom(number: number)
        }
        view?.appendViewModel(viewModel: viewModel!)
    }
    
    
    func showError() {
        
    }
    
    func infoLoaded(data: [Any]) {
        let queries = data.map { object -> Query in
            if let email = object as? EmailDTO {
                return converter.createViewModelFrom(email: email)
            }
            if let number = object as? NumberDTO {
                return converter.createViewModelFrom(number: number)
            }
            fatalError()
        }
        view?.updateView(viewModels: queries)
    }
}

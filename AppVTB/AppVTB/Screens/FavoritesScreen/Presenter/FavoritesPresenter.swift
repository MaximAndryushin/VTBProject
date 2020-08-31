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
    func showDetailedView(viewModel: QueryViewModel)
}

protocol FavoritesPresenterUpdateLogic {
    var current: [QueryViewModel] { get }
    func update()
}

final class FavoritesPresenter {
    
    
    //MARK: - Properties
    
    weak var view: FavoritesViewInput?
    var interactor: FavoritesInteractorInput?
    var router: FavoritesRouterInput?
    private let converter: DataConverterInput
    private let parser: ParserInput
    
    
    // MARK: - Initializer
    
    init(converter: DataConverterInput, parser: ParserInput) {
        self.converter = converter
        self.parser = parser
    }
    
}


// MARK: - FavoritesViewOutput

extension FavoritesPresenter: FavoritesViewOutput {
    
    func showDetailedView(viewModel: QueryViewModel) {
        router?.showDetailedView(viewModel: viewModel)
    }
    
    
    func loadData() {
        interactor?.getData()
    }
    
    func addButtonClicked() {
        view?.showAlert()
    }
    
    func delete(query: QueryViewModel) {
        interactor?.delete(name: query.name, type: query.type)
    }
    
    func addNewData(_ name: String) {
        interactor?.fetchData(name, type: parser.getType(from: name))
    }
    
}


// MARK: - FavoritesInteractorOutput

extension FavoritesPresenter: FavoritesInteractorOutput {
    
    func appendToTable(object: Any) {
        var viewModel: QueryViewModel?
        if let email = object as? EmailDTO {
            viewModel = converter.createViewModelFrom(email: email)
        }
        if let number = object as? NumberDTO {
            viewModel = converter.createViewModelFrom(number: number)
        }
        view?.appendViewModel(viewModel: viewModel ?? QueryViewModel())
    }
    
    
    func showError(_ error: String) {
        // Check if presented View Controller is FavoritesVC
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let tabBarVC = appDelegate.window?.rootViewController as? TabBarController, let _ = tabBarVC.selectedViewController as? FavoritesViewController {
                self.view?.showError(error)
            }
        }
    }
    
    
    func infoLoaded(data: [Any]) {
        var queries = data.map { object -> QueryViewModel in
            if let email = object as? EmailDTO {
                return converter.createViewModelFrom(email: email)
            } else if let number = object as? NumberDTO {
                return converter.createViewModelFrom(number: number)
            } else {
                self.view?.showError("STRANGE SHIT")
                return QueryViewModel()
            }
        }
        queries.sort{ $0.date < $1.date }
        self.view?.updateView(viewModels: queries)
        self.update()
    }
}


//MARK: - Update logic

extension FavoritesPresenter: FavoritesPresenterUpdateLogic {
    
    //MARK: - Constants
    
    private enum Locals {
        static let tenSec: Double = 10
        static let oneMin: Double = 60
        static let threeMin: Double = 3 * 60
        static let fiveMin: Double = 5 * 60
        static let tenMin: Double = 10 * 60
        static let tolerance: Double = 2
    }
    
    //MARK: - Properties
    
    var current: [QueryViewModel] {
        return view?.getModels() ?? []
    }
    
    //MARK: - Methods
    
    func update() {
        let timer = Timer.scheduledTimer(withTimeInterval: Locals.tenSec, repeats: true ) { timer in
            let date = Date()
            for model in self.current {
                if date.timeIntervalSince(model.date) > Locals.tenSec {
                    self.interactor?.fetchData(model.name, type: model.type)
                }
            }
        }
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = Locals.tolerance
    }
    
}

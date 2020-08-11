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

protocol FavoritesPresenterUpdateLogic {
    var current: Query? { get }
    func update()
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
    
    
    func showError(_ error: String) {
        view?.showError(error)
    }
    
    
    func infoLoaded(data: [Any]) {
        var queries = data.map { object -> Query in
            if let email = object as? EmailDTO {
                return converter.createViewModelFrom(email: email)
            }
            if let number = object as? NumberDTO {
                return converter.createViewModelFrom(number: number)
            }
            fatalError()
        }
        queries.sort{ $0.getDate() < $1.getDate() }
        self.view?.updateView(viewModels: queries)
        self.update()
    }
}


//MARK: - Update logic

extension FavoritesPresenter: FavoritesPresenterUpdateLogic {
    
    //MARK: - Constants
    
    enum Locals {
        static let tenSec: Double = 10
        static let oneMin: Double = 60
        static let threeMin: Double = 3 * 60
        static let fiveMin: Double = 5 * 60
        static let tenMin: Double = 10 * 60
    }
    
    //MARK: - Properties
    
    var current: Query? {
        return view?.getFirst()
    }
    
    //MARK: - Methods
    
    func update() {
//        if let model = current {
//            let queue = DispatchQueue.global(qos: .utility)
//            let interval = max(model.getRawDate().addingTimeInterval(Locals.threeMin).timeIntervalSinceNow, TimeInterval(0))
//            queue.asyncAfter(deadline: DispatchTime.now() + interval) {
//                if let cur = self.current, cur == model {
//                    self.interactor?.fetchData(cur.getName(), type: cur.getType())
//                }
//            }
//        }
    }
    
}

//
//  HistoryViewController.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

protocol HistoryDisplayLogic: class {
    func displayQueries(viewModel: [Query])
}

final class HistoryViewController: UIViewController {
    
    var interactor: HistoryBusinessLogic?
    var router: (NSObjectProtocol & HistoryRoutingLogic & HistoryDataPassing)?
    
    // MARK: - Constants
    
    private enum Locals {
        static let cellID = "cell"
        static let titleHeader = "History"
        static let fontTitle: CGFloat = 34
        static let cellHeight: CGFloat = 50
        static let offset: CGFloat = 5
        static let positionOfTableX: CGFloat = 0
        static let positionOfTableY: CGFloat = 0
        static let dropDownHeight: CGFloat = 40.0
        static let filterOptions = ["All", "Emails", "Phone Numbers"]
        static let sortingOptions = ["Newest", "Oldest"]

    }
    
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    private var filterSegmentedControl: UISegmentedControl!
    private var sortingSegmentedControl: UISegmentedControl!
    private var cellModels: [Query] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = HistoryInteractor()
        let presenter = HistoryPresenter()
        let router = HistoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableCell.self, forCellReuseIdentifier: Locals.cellID)
        tableView.estimatedRowHeight = Locals.cellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: sortingSegmentedControl.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.offset),
            tableView.bottomAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Locals.offset)
        ])
        
    }
    
    private func configureSegmentedControl(items: [Any]?, action: Selector) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: action, for: .valueChanged)
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        return segmentedControl
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        filterSegmentedControl = configureSegmentedControl(items: Locals.filterOptions, action: #selector(indexOfFilterChanged(_:)))
        sortingSegmentedControl = configureSegmentedControl(items: Locals.sortingOptions, action: #selector(indexOfSortingChanged(_:)))
        NSLayoutConstraint.activate([
            filterSegmentedControl.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor),
            sortingSegmentedControl.topAnchor.constraint(equalTo: filterSegmentedControl.bottomAnchor)
        ])
        configureTableView()
        loadData()
    }
    
    
    // MARK: - loadData
    
    func loadData() {
        let isAscending = (sortingSegmentedControl.selectedSegmentIndex == 0 ? false : true)
        let request = History.ShowQueries.Request(type: nil, isAscending: isAscending)
        interactor?.showQueries(request: request)
    }
    
    //MARK: - FilterReaction
    
    @objc private func indexOfFilterChanged(_ sender: UISegmentedControl) {
        let isAscending = (sortingSegmentedControl.selectedSegmentIndex == 0 ? false : true)
        switch sender.selectedSegmentIndex {
        case 0:
            loadData()
        case 1:
            let request = History.ShowQueries.Request(type: .email, isAscending: isAscending)
            interactor?.showQueries(request: request)
        case 2:
            let request = History.ShowQueries.Request(type: .number, isAscending: isAscending)
            interactor?.showQueries(request: request)
        default:
            break
        }
    }
    
    
    //MARK: - SortReaction
    
    @objc private func indexOfSortingChanged(_ sender: UISegmentedControl) {
        var type: TypeOfQuery? = nil
        if filterSegmentedControl.selectedSegmentIndex > 0 {
            type = (filterSegmentedControl.selectedSegmentIndex == 1 ? .email : .number)
        }
        switch sender.selectedSegmentIndex{
        case 0:
            let request = History.ShowQueries.Request(type: type, isAscending: false)
            interactor?.showQueries(request: request)
        case 1:
            let request = History.ShowQueries.Request(type: type, isAscending: true)
            interactor?.showQueries(request: request)
        default:
            break
        }
    }
    
}


//MARK: - HistoryDisplayLogic

extension HistoryViewController: HistoryDisplayLogic {
    
    func displayQueries(viewModel: [Query]) {
        cellModels = viewModel
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellID, for: indexPath) as? HistoryTableCell {
            cell.viewModel = cellModels[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            cellModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

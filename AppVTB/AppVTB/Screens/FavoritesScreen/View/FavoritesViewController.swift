//
//  FavoritesViewController.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol FavoritesViewInput: AnyObject {
    func updateView(viewModels: [QueryViewModel])
    func showAlert();
    func appendViewModel(viewModel: QueryViewModel)
    func showError(_ errorMessage: String)
    func getModels() -> [QueryViewModel]
}

protocol FavoritesViewOutput {
    func loadData()
    func addButtonClicked()
    func delete(query: QueryViewModel)
    func addNewData(_ name: String)
    func showDetailedView(viewModel: QueryViewModel)
}

final class FavoritesViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Locals {
        static let title = "Current state of tracked data"
        static let buttonTitle = "Add new data to track"
        static let offset: CGFloat = 5
        static let cornerRadiusButton: CGFloat = 15
        static let cellID = HistoryViewController.Locals.cellID
        static let cellHeight: CGFloat = HistoryViewController.Locals.cellHeight
        static let alertTitle = "Add new data"
        static let addTitle = "Add"
        static let cancelTitle = "Cancel"
        static let placeholder = "Enter email or phone number"
        static let errorTitle = "ERROR"
    }
    
    //MARK: - Properties
    
    var presenter: FavoritesViewOutput?
    private lazy var favoritesLabel: UILabel = {
        return UILabel(text: NSAttributedString(string: Locals.title), font: Constants.titleFont, alignment: .center)
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryTableCell.self, forCellReuseIdentifier: Locals.cellID)
        tableView.estimatedRowHeight = Locals.cellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setTitle(Locals.buttonTitle, for: .normal)
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white , for: .normal)
        addButton.contentHorizontalAlignment = .center
        addButton.layer.cornerRadius = Locals.cornerRadiusButton
        addButton.addTarget(self, action: #selector(addNewData), for: .touchUpInside)
        return addButton
    }()
    
    private lazy var cellModels: [QueryViewModel] = []
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureLabel()
        configureButton()
        configureTableView()
        presenter?.loadData()
    }
    
    
    //MARK: - Configure SubViews
    
    private func configureLabel() {
        view.addSubview(favoritesLabel)
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
         
        NSLayoutConstraint.activate([
            favoritesLabel.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor),
            favoritesLabel.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor),
            favoritesLabel.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureButton() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: Locals.offset),
            addButton.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor, constant: Locals.offset),
            addButton.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor, constant: -Locals.offset),
        ])
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Locals.offset),
            tableView.bottomAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Locals.offset)
        ])
        
    }
    
    @objc private func addNewData() {
        presenter?.addButtonClicked()
    }
}


// MARK: - FavoritesViewInput

extension FavoritesViewController: FavoritesViewInput {
    
    func getModels() -> [QueryViewModel] {
        return cellModels
    }
    
    
    func showError(_ errorMessage: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Locals.errorTitle, message: errorMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { (_) in })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func deleteViewModel(_ name: String) {
        let id = cellModels.firstIndex{ return $0.name == name }
        if let index = id {
            cellModels.remove(at: index)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    func appendViewModel(viewModel: QueryViewModel) {
        DispatchQueue.main.async {
            self.deleteViewModel(viewModel.name)
            self.cellModels.append(viewModel)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.cellModels.count - 1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    
    func updateView(viewModels: [QueryViewModel]) {
        self.cellModels = viewModels
        self.tableView.reloadData()
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: Locals.alertTitle, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Locals.addTitle, style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text, !text.isEmpty {
                self.presenter?.addNewData(text)
            }
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: Locals.cancelTitle, style: .cancel) { (_) in }
        alertController.addAction(cancelAction)
        alertController.addTextField { (textField) in
            textField.placeholder = Locals.placeholder
        }
        present(alertController, animated: true, completion: nil)
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        presenter?.showDetailedView(viewModel: cellModels[indexPath.row])
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
            presenter?.delete(query: cellModels[indexPath.row])
            cellModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

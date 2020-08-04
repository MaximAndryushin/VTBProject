//
//  FavoritesViewController.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 20.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol FavoritesViewInput: AnyObject {
    func updateView(viewModels: [Query])
}

protocol FavoritesViewOutput {
    func loadData()
    func addButtonClicked()
}

final class FavoritesViewController: UIViewController {
    
    //MARK: - Constants
    
    enum Locals {
        static let title = "Current state of tracked data"
        static let buttonTitle = "Add new data to track"
        static let titleSize: CGFloat = 26
        static let offset: CGFloat = 5
        static let cornerRadiusButton: CGFloat = 15
        static let cellID = "favoritesCell"
        static let cellHeight: CGFloat = 40
    }
    
    //MARK: - Properties
    
    var presenter: FavoritesViewOutput?
    private var favoritesLabel: UILabel!
    private var tableView: UITableView!
    private var addButton: UIButton!
    private var cellModels: [Query] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        FavoritesAssembly.assembly(view: self)
        configureLabel()
        configureButton()
        configureTableView()
        presenter?.loadData()
    }
    
    
    //MARK: - Setup
    
    private func configureLabel() {
        favoritesLabel = UILabel()
        favoritesLabel.text = Locals.title
        favoritesLabel.font = .boldSystemFont(ofSize: Locals.titleSize)
        favoritesLabel.textAlignment = .center
        view.addSubview(favoritesLabel)
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesLabel.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor),
            favoritesLabel.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor),
            favoritesLabel.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureButton() {
        addButton = UIButton()
        addButton.setTitle(Locals.buttonTitle, for: .normal)
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white , for: .normal)
        addButton.contentHorizontalAlignment = .center
        addButton.layer.cornerRadius = Locals.cornerRadiusButton
        addButton.addTarget(self, action: #selector(addNewData), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: Locals.offset),
            addButton.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor, constant: Locals.offset),
            addButton.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor, constant: -Locals.offset),
        ])
    }
    
    private func configureTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesTableCell.self, forCellReuseIdentifier: Locals.cellID)
        tableView.estimatedRowHeight = Locals.cellHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
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
    func updateView(viewModels: [Query]) {
        cellModels = viewModels
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Locals.cellID, for: indexPath) as? FavoritesTableCell {
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
            //Add deletion from database
            cellModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

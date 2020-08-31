//
//  DetailedViewController.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 13.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol ViewModelPresentInput {
    init(viewModel: QueryViewModel)
}

final class DetailedViewController: UIViewController {
    
    
    //MARK: - Constants
    
    private enum Locals {
        static let labelOffset: CGFloat = 10
        static let stackSpacing: CGFloat = 10
    }
    
    
    //MARK: - Properties
    
    private var viewModel: QueryViewModel = QueryViewModel()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = Locals.stackSpacing
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //button.setImage(UIImage(named: "close"), for: .normal)
        button.layer.cornerRadius = min(button.intrinsicContentSize.height, button.intrinsicContentSize.width) / 2
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        configureLabels()
    }
    
    private func configure() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor, constant: Locals.labelOffset),
            closeButton.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor, constant: -Locals.labelOffset),
            scrollView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
    
    private func configureLabels() {
        for label in viewModel.toLabels() {
            stackView.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Locals.labelOffset),
                label.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Locals.labelOffset),
            ])
        }
    }
    
    @objc private func clickButton() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - ViewModelPresent

extension DetailedViewController: ViewModelPresentInput {
    
    convenience init(viewModel: QueryViewModel) {
        self.init()
        
        self.viewModel = viewModel
    }
    
}

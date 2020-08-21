//
//  DetailedViewController.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 13.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol ViewModelPresent {
    init(viewModel: QueryViewModel)
}

final class DetailedViewController: UIViewController {
    
    //MARK: - Constants
    private enum Locals {
        static let labelOffset: CGFloat = 10
        static let stackSpacing: CGFloat = 10
    }
    
    
    //MARK: - Properties
    
    private var labels: [UILabel]!
    private var stackView: UIStackView!
    private var scrollView: UIScrollView!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        configureLabels()
    }
    
    private func configure() {
        stackView = UIStackView()
        scrollView = UIScrollView()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor)
        ])

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = Locals.stackSpacing

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
        for label in labels {
            stackView.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Locals.labelOffset),
                label.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Locals.labelOffset),
            ])
        }
    }
}

//MARK: - ViewModelPresent

extension DetailedViewController: ViewModelPresent {
    
    convenience init(viewModel: QueryViewModel) {
        self.init()
        
        labels = viewModel.toLabels()
    }
    
}

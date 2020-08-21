//
//  SplashScreen.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 19.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let logo = UIImage(named: "logo")
    }
    
    
    // MARK: - Properties
    
    var logoIsHidden = false
    var logoImageView: UIImageView!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLogo()
    }
    
    
    private func configureLogo() {
        logoImageView = UIImageView(image: Locals.logo)
        logoImageView.isHidden = logoIsHidden
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.bottomAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

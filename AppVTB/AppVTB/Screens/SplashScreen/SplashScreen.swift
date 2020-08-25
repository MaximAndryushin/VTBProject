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
        static let logoWidth: CGFloat = 280
        static let logoHeight: CGFloat = 320
    }
    
    
    // MARK: - Properties
    
    var logoIsHidden = false
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: Locals.logo)
        logoImageView.isHidden = logoIsHidden
        return logoImageView
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLogo()
    }
    
    
    private func configureLogo() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: Locals.logoWidth),
            logoImageView.heightAnchor.constraint(equalToConstant: Locals.logoHeight),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}

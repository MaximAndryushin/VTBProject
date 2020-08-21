//
//  Presenter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 19.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol SplashPresenterDescription: class {
    func present()
    func dismiss(completion: @escaping () -> Void)
}

final class SplashPresenter {
    
    // MARK: - Properties
    
    private lazy var foregroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(logoIsHidden: false)
        let splashWindow = self.splashWindow(windowLevel: .normal + 1, rootViewController: splashViewController)
        
        return splashWindow
    }()
    
    private lazy var backgroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(logoIsHidden: true)
        let splashWindow = self.splashWindow(windowLevel: .normal - 1, rootViewController: splashViewController)
        
        return splashWindow
    }()
    
    private lazy var animator: SplashAnimatorDescription = SplashAnimator(foregroundSplashWindow: foregroundSplashWindow, backgroundSplashWindow: backgroundSplashWindow)
    
    
    // MARK: - Methods
    
    private func splashWindow(windowLevel: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
        let splashWindow = UIWindow(frame: UIScreen.main.bounds)
        
        splashWindow.windowLevel = windowLevel
        splashWindow.rootViewController = rootViewController
        
        return splashWindow
    }
    
    private func splashViewController(logoIsHidden: Bool) -> SplashViewController? {
        let splashViewController = SplashViewController()
        
        splashViewController.logoIsHidden = logoIsHidden
        
        return splashViewController
    }
}


// MARK: - SplashPresenterDescription

extension SplashPresenter: SplashPresenterDescription {
    func present() {
        animator.animateAppearance()
    }
    
    func dismiss(completion: @escaping () -> Void) {
        animator.animateDisappearance(completion: completion)
    }
}

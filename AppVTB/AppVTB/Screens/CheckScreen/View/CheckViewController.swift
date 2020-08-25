//
//  CheckViewController.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 12.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol CheckViewOutput {
    func check(_ name: String?)
}

final class CheckViewController: UIViewController {
    
    //MARK: - Constants
    
    private enum Locals {
        static let title = "Check Email/Phone Number"
        static let offset: CGFloat = 20
        static let placeholder = "example@mail.ru/(+)79102382390"
        static let sizeOfButton = 50
        static let heightTextField: CGFloat = 60
        static let minFontSize: CGFloat = 16
        static let font = UIFont.systemFont(ofSize: 20)
        static let errorTitle = "ERROR"
        
    }
    
    
    //MARK: - Properties
    
    var presenter: CheckViewOutput?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var checkButton: UIButton = {
        let checkButton = UIButton()
        checkButton.setImage(UIImage(named: "approved"), for: .normal)
        checkButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return checkButton
    }()
    
    private lazy var checkLabel: UILabel = {
        return UILabel(text: NSAttributedString(string: Locals.title), font: Constants.titleFont, alignment: .center)
    }()
    
    private lazy var checkTextField: UITextField = {
        let checkTextField = UITextField()
        checkTextField.placeholder = Locals.placeholder
        checkTextField.borderStyle = .roundedRect
        checkTextField.returnKeyType = .done
        checkTextField.enablesReturnKeyAutomatically = true
        checkTextField.autocorrectionType = .no
        checkTextField.clearButtonMode = .unlessEditing
        checkTextField.autocapitalizationType = .none
        checkTextField.spellCheckingType = .no
        checkTextField.delegate = self
        checkTextField.adjustsFontSizeToFitWidth = true
        checkTextField.minimumFontSize = Locals.minFontSize
        checkTextField.font = Locals.font
        checkTextField.translatesAutoresizingMaskIntoConstraints = false
        checkTextField.heightAnchor.constraint(equalToConstant: Locals.heightTextField).isActive = true
        return checkTextField
    }()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureStackView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pulsate()
        flash()
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(checkLabel)
        stackView.addArrangedSubview(checkTextField)
        stackView.addArrangedSubview(checkButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor, constant: Locals.offset),
            stackView.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.bottomAnchor, constant: -Locals.offset)
        ])
    }
    
    @objc private func clickButton() {
        presenter?.check(checkTextField.text)
        checkTextField.text = nil
    }
    
    
    // MARK: - Button Animations
    
    private func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.94
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulse.damping = 1.0
        checkButton.layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.5
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        checkButton.layer.add(flash, forKey: nil)
    }
}


//MARK: - TextFieldDelegate

extension CheckViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

//MARK: - CheckViewInput

extension CheckViewController: CheckViewInput {
    
    func showError(_ errorMessage: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Locals.errorTitle, message: errorMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { (_) in })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

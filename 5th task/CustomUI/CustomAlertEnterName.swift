//
//  CustomAlert.swift
//  5th task
//
//  Created by Владимир Курганов on 02.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let O: CGFloat = 0
    static let cornerRadius: CGFloat = 16
    static let lableTextFontSize: CGFloat = 16
    static let textFieldAlertFontSize: CGFloat = 18
    static let alertViewPositionX: CGFloat = 40
    static let alertViewPositionY: CGFloat = -300
    static let alertViewHeight: CGFloat = 200
    static let alertViewWidth: CGFloat = 300
    static let duration: CGFloat = 0.25
    static let dispatchDelay: CGFloat = 0.4
    static let backgroundViewAlpha: CGFloat = 0.4
    static let titleLableTopAnchor: CGFloat = 20
    static let titleLableBottomAnchor: CGFloat = -156
    static let titleLableHeight: CGFloat = 24
    static let titleLableWidth: CGFloat = 177
    static let textFieldAlertTopAnchor: CGFloat = 64
    static let textFieldAlertBottomAnchor: CGFloat = -88
    static let textFieldAlertHeight: CGFloat = 48
    static let textFieldAlertWidth: CGFloat = 260
    static let buttonTopAnchor: CGFloat = 132
    static let buttonBottomAnchor: CGFloat = -20
    static let buttonHeightAnchor: CGFloat = 48
    static let buttonWidthAnchor : CGFloat = 260
    static let textLable: String = "ВВЕДИТЕ ВАШЕ ИМЯ"
    static let fontRubik: String = "Rubik-Medium"
    static let buttontitle: String = "ГОТОВО"
    static let customAlertShadowDeactive = UIColor(red: 0.808, green: 0.831, blue: 0.855, alpha: 1)
    static let customAlertBorderDeactive = UIColor(red: 0.808, green: 0.831, blue: 0.855, alpha: 1)
    static let customAlertBackGroundDeactive = UIColor(red: 0.808, green: 0.831, blue: 0.855, alpha: 1)
    static let customAlertShadowActive = UIColor(red: 0.133, green: 0.545, blue: 0.902, alpha: 1)
    static let customAlertBorderActive = UIColor(red: 0.133, green: 0.545, blue: 0.902, alpha: 1)
    static let customAlertBackGroundActive = UIColor(red: 0.302, green: 0.671, blue: 0.969, alpha: 1)
    static let alertViewTopAnchor: CGFloat = 160
}

//MARK: - CustomAlertEnterNameProtocol
protocol CustomAlertEnterNameProtocol {
    var textFieldAlert: UITextField { get set }
    func showNameAlert(on viewController: UIViewController)
    func editingChanged(_ textField: UITextField)
    func dismissAlert()
}

//MARK: - CustomAlertEnterName
final class CustomAlertEnterName: UIView, CustomAlertEnterNameProtocol {
    
    //MARK: - Properties
    private let backgroundView: UIView = {
        var backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = Constants.O
        return backgroundView
    }()
    
    private let backgroundNavBar: UIView = {
        var backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = Constants.O
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = UIColor.white
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = Constants.cornerRadius
        return alertView
    }()
    
    private let titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.text = Constants.textLable
        titleLable.font = UIFont(name: Constants.fontRubik, size: Constants.lableTextFontSize)
        titleLable.textAlignment = .center
        return titleLable
    }()
    
    var textFieldAlert: UITextField = {
        let textFieldAlert = UITextField()
        textFieldAlert.textColor = .black
        textFieldAlert.placeholder = ""
        textFieldAlert.font = UIFont.systemFont(ofSize: Constants.textFieldAlertFontSize)
        textFieldAlert.clearButtonMode = .whileEditing
        textFieldAlert.backgroundColor = .systemGray6
        textFieldAlert.layer.cornerRadius = Constants.cornerRadius
        textFieldAlert.addTarget(
            nil,
            action: #selector(CustomAlertEnterName.editingChanged(_:)),
            for: .editingChanged
        )
        return textFieldAlert
    }()
    
    private let button: CustomButton = {
        let button = CustomButton(setupButton: .ready)
        button.isEnabled = false
        button.addTarget(
            nil,
            action: #selector(dismissAlert),
            for: .touchUpInside
        )
        return button
    }()
    
    //MARK: - Methods
    func showNameAlert(on viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        guard let targetNavBar = viewController.navigationController?.navigationBar else { return }
        
        backgroundNavBar.frame = targetNavBar.bounds
        backgroundView.frame = targetView.bounds
        targetNavBar.addSubview(backgroundNavBar)
        targetView.addSubview(backgroundView)
        setupView()
        
        UIView.animate(withDuration: Constants.duration, animations: {
            self.backgroundView.alpha = Constants.backgroundViewAlpha
            self.backgroundNavBar.alpha = Constants.backgroundViewAlpha
            
        }, completion: { _ in
            UIView.animate(withDuration: Constants.duration, animations: { [self] in
                targetView.addSubview(self.alertView)
                self.alertView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    self.alertView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                    self.alertView.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: Constants.alertViewTopAnchor),
                    self.alertView.widthAnchor.constraint(equalToConstant: Constants.alertViewWidth),
                    self.alertView.heightAnchor.constraint(equalToConstant: Constants.alertViewHeight)
                ])
            })
        })
    }
    
    private func setupView() {
        setupButton()
        setupLabel()
        setupTextField()
    }
    
    private func setupLabel() {
        alertView.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Constants.titleLableTopAnchor),
            titleLable.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            titleLable.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: Constants.titleLableBottomAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: Constants.titleLableHeight),
            titleLable.widthAnchor.constraint(equalToConstant: Constants.titleLableWidth)
        ])
    }
    
    private func setupTextField() {
        alertView.addSubview(textFieldAlert)
        textFieldAlert.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldAlert.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Constants.textFieldAlertTopAnchor),
            textFieldAlert.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            textFieldAlert.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: Constants.textFieldAlertBottomAnchor),
            textFieldAlert.heightAnchor.constraint(equalToConstant: Constants.textFieldAlertHeight),
            textFieldAlert.widthAnchor.constraint(equalToConstant: Constants.textFieldAlertWidth)
        ])
    }
    private func setupButton() {
        alertView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Constants.buttonTopAnchor),
            button.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: Constants.buttonBottomAnchor),
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeightAnchor),
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidthAnchor)
        ])
    }
    
    //MARK: - @objc Methods
    @objc
    func editingChanged(_ textField: UITextField) {
        guard let text = textField.text?.isEmpty else { return }
        if text == false {
            button.isEnabled = true
            button.layer.backgroundColor = Constants.customAlertBackGroundActive.cgColor
            button.layer.shadowColor = Constants.customAlertShadowActive.cgColor
            button.layer.borderColor = Constants.customAlertBorderActive.cgColor
            button.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc
    func dismissAlert() {
        UIView.animate(withDuration: Constants.duration, animations: {
            self.alertView.removeFromSuperview()
        }, completion: { _ in
            UIView.animate(withDuration: Constants.duration, animations: {
                self.backgroundView.alpha = Constants.O
                self.backgroundNavBar.alpha = Constants.O
                
            }) { _ in
                
                self.backgroundView.removeFromSuperview()
                self.textFieldAlert.text?.removeAll()
                self.button.isEnabled = false
                self.button.layer.backgroundColor = Constants.customAlertBackGroundDeactive.cgColor
                self.button.layer.shadowColor = Constants.customAlertShadowDeactive.cgColor
                self.button.layer.borderColor = Constants.customAlertBorderDeactive.cgColor
            }
        })
    }
}

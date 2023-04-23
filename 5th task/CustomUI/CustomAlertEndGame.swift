//
//  CustomAlertEndGame.swift
//  5th task
//
//  Created by Владимир Курганов on 14.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let O: CGFloat = 0
    static let alertViewBackgroundColorc = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let cornerRadius: CGFloat = 16
    static let titleTextSize: CGFloat = 16
    static let subtitleLableTextColor = UIColor(red: 0.525, green: 0.557, blue: 0.588, alpha: 1)
    static let titleLableText: String = "ЗАКОНЧИТЬ ИГРУ?"
    static let RubikMediumFont: String = "Rubik-Medium"
    static let subtitleLableText: String = "БАЛЛЫ НЕ БУДУТ СОХРАНЕНЫ"
    static let RubikRegularFont: String = "Rubik-Regular"
    static let animateDuration: CGFloat = 0.3
    static let backgroundViewAlpha: CGFloat = 0.4
    static let alertViewWidth: CGFloat = 300
    static let alertViewHeight: CGFloat = 170
    static let buttonTopAnchor: CGFloat = 24
    static let buttonRightAnchor: CGFloat = -20
    static let buttonLeftAnchor: CGFloat = 20
    static let buttonHeight: CGFloat = 48
    static let buttonWidth: CGFloat = 120
    static let subtitleLableTopAnchor: CGFloat = 8
    static let subtitleLableHeight: CGFloat = 24
    static let subtitleLableWidth: CGFloat = 253
    static let titleLableTopAnchor: CGFloat = 20
    static let titleLableHeight: CGFloat = 24
    static let titleLableWidth: CGFloat = 162
}

//MARK: - CustomAlertEndGameProtocol
protocol CustomAlertEndGameProtocol {
    func showEndGameAlert(on viewController: UIViewController)
    func dismissAlert()
}

//MARK: - CustomAlertEndGame
final class CustomAlertEndGame: UIView, CustomAlertEndGameProtocol {
    
    //MARK: - Properties
    private let backgroundView: UIView = {
        var backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = Constants.O
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = Constants.alertViewBackgroundColorc
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = Constants.cornerRadius
        return alertView
    }()
    
    private let titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.text = Constants.titleLableText
        titleLable.font = UIFont(name: Constants.RubikMediumFont, size: Constants.titleTextSize)
        titleLable.textAlignment = .center
        return titleLable
    }()
    
    private let subtitleLable: UILabel = {
        let subtitleLable = UILabel()
        subtitleLable.text = Constants.subtitleLableText
        subtitleLable.font = UIFont(name: Constants.RubikRegularFont, size: Constants.titleTextSize)
        subtitleLable.textColor = Constants.subtitleLableTextColor
        subtitleLable.textAlignment = .center
        return subtitleLable
    }()
    
    private lazy var noButton: CustomButton = {
        let noButton = CustomButton(setupButton: .no)
        noButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        return noButton
    }()
    private lazy var yesButton: CustomButton = {
        let yesButton = CustomButton(setupButton: .yes)
        yesButton.addTarget(nil, action: #selector(endGameButtonTapped), for: .touchUpInside)
        return yesButton
    }()
    
    //MARK: - Methods
    func showEndGameAlert(on viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        setupView()
        
        UIView.animate(withDuration: Constants.animateDuration, animations: {
            self.backgroundView.alpha = Constants.backgroundViewAlpha
        }, completion: { _ in
            UIView.animate(withDuration: Constants.animateDuration, animations: { [self] in
                targetView.addSubview(self.alertView)
                self.alertView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    self.alertView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
                    self.alertView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
                    self.alertView.widthAnchor.constraint(equalToConstant: Constants.alertViewWidth),
                    self.alertView.heightAnchor.constraint(equalToConstant: Constants.alertViewHeight)
                ])
            })
        })
    }
    
    private func setupView() {
        setupTitleLable()
        setupSubTitleLable()
        setupNoButton()
        setupYesButton()
    }
    
    private func setupYesButton() {
        alertView.addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yesButton.topAnchor.constraint(equalTo: subtitleLable.bottomAnchor, constant: Constants.buttonTopAnchor),
            yesButton.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: Constants.buttonRightAnchor),
            yesButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            yesButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ])
    }
    
    private func setupNoButton() {
        alertView.addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noButton.topAnchor.constraint(equalTo: subtitleLable.bottomAnchor, constant: Constants.buttonTopAnchor),
            noButton.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: Constants.buttonLeftAnchor),
            noButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            noButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ])
    }
    
    private func setupSubTitleLable() {
        alertView.addSubview(subtitleLable)
        subtitleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: Constants.subtitleLableTopAnchor),
            subtitleLable.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            subtitleLable.heightAnchor.constraint(equalToConstant: Constants.subtitleLableHeight),
            subtitleLable.widthAnchor.constraint(equalToConstant: Constants.subtitleLableWidth)
        ])
    }
    
    private func setupTitleLable() {
        alertView.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Constants.titleLableTopAnchor),
            titleLable.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: Constants.titleLableHeight),
            titleLable.widthAnchor.constraint(equalToConstant: Constants.titleLableWidth)
        ])
    }
    
    //MARK: - @objc Methods
    @objc
    func dismissAlert() {
        UIView.animate(withDuration: Constants.animateDuration, animations: {
            self.alertView.removeFromSuperview()
        }, completion: { _ in
            UIView.animate(withDuration: Constants.animateDuration, animations: {
                self.backgroundView.alpha = Constants.O
            }) { _ in
                self.backgroundView.removeFromSuperview()
            }
        })
    }
    
    @objc
    func endGameButtonTapped() { }
}

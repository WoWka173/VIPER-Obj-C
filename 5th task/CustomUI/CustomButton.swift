//
//  CustomButton.swift
//  5th task
//
//  Created by Владимир Курганов on 02.11.2022.
//

import UIKit
import ObjectiveC

//MARK: - Constants
fileprivate enum Constants {
    static let O: CGFloat = 0
    static let sublayerIndex: UInt32 = 0
    static let cornerRadius: CGFloat = 16
    static let textSize: CGFloat = 16
    static let shadowRadius: CGFloat = 0
    static let shadowOpacity: Float = 1
    static let shadowChange: Float = 0
    static let shadowOffsetHeight: CGFloat = 2
    static let gradientEndPointX: CGFloat = 1
    static let gradientEndPointY: CGFloat = 0.5
    static let gradientStartPointY: CGFloat = 0.5
    static let borderWidth: CGFloat = 2
    static let duration: CGFloat = 0.05
    static let frameY: CGFloat = 2
    static let fontRubikMedium: String = "Rubik-Medium"
    static let fontRubikRegular: String = "Rubik-Regular"
    static let backGroundDeactive = UIColor(red: 0.808, green: 0.831, blue: 0.855, alpha: 1)
    static let backgroundFill = UIColor(red: 0.302, green: 0.671, blue: 0.969, alpha: 1)
    static let backgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let shadowBorderFill = UIColor(red: 0.133, green: 0.545, blue: 0.902, alpha: 1)
    static let shadowBorderColor = UIColor(red: 0.78, green: 0.843, blue: 0.608, alpha: 1)
    static let titleIsEmpty: String = ""
    static let blackColor = UIColor.black
    static let whiteColor = UIColor.white
    static let grayColor = UIColor.gray
    static let titleRedyButton: String = "ГОТОВО"
    static let titleOfflineButton: String = "ОФФЛАЙН"
    static let titleOnlineButton: String = "ОНЛАЙН"
    static let titleNextStepButton: String = "ПРОДОЛЖИТЬ"
    static let titleStartAgainButton: String = "НАЧАТЬ СНОВА"
    static let titleEndGameButton: String = "ЗАКОНЧИТЬ"
    static let titleYesButton: String = "ДА"
    static let titleNoButton: String = "НЕТ"
}

//MARK: - CustomButton
@objc(CustomButton)
final class CustomButton: UIButton {
    
    enum ButtonType {
        
        case ready
        
        case offLine
        case online
        
        case firstButton
        case secondButton
        case thirdButton
        case fourthButton
        case fifthButton
        
        case nextStep
        case startAgain
        case endGame
        
        case yes
        case no
        
        var backgroundColor: UIColor {
            switch self {
            case .ready:
                return Constants.backGroundDeactive
            case .offLine:
                return Constants.backgroundFill
            case .online:
                return Constants.backgroundColor
            case .firstButton:
                return Constants.backgroundColor
            case .secondButton:
                return Constants.backgroundColor
            case .thirdButton:
                return Constants.backgroundColor
            case .fourthButton:
                return Constants.backgroundColor
            case .fifthButton:
                return Constants.backgroundColor
            case .nextStep:
                return Constants.backgroundFill
            case .startAgain:
                return Constants.backgroundFill
            case .endGame:
                return Constants.backgroundColor
            case .yes:
                return Constants.backgroundColor
            case .no:
                return Constants.backgroundFill
            }
        }
        
        var shadowBorderColor: UIColor {
            switch self {
            case .ready:
                return Constants.backGroundDeactive
            case .offLine:
                return Constants.shadowBorderFill
            case .online:
                return Constants.shadowBorderColor
            case .firstButton:
                return Constants.shadowBorderColor
            case .secondButton:
                return Constants.shadowBorderColor
            case .thirdButton:
                return Constants.shadowBorderColor
            case .fourthButton:
                return Constants.shadowBorderColor
            case .fifthButton:
                return Constants.shadowBorderColor
            case .nextStep:
                return Constants.shadowBorderFill
            case .startAgain:
                return Constants.shadowBorderFill
            case .endGame:
                return Constants.shadowBorderColor
            case .yes:
                return Constants.shadowBorderColor
            case .no:
                return Constants.shadowBorderFill
            }
        }
        
        var title: String {
            switch self {
            case .ready:
                return Constants.titleRedyButton
            case.offLine:
                return Constants.titleOfflineButton
            case .online:
                return Constants.titleOnlineButton
            case .firstButton:
                return  Constants.titleIsEmpty
            case .secondButton:
                return  Constants.titleIsEmpty
            case .thirdButton:
                return Constants.titleIsEmpty
            case .fourthButton:
                return Constants.titleIsEmpty
            case .fifthButton:
                return Constants.titleIsEmpty
            case .nextStep:
                return Constants.titleNextStepButton
            case .startAgain:
                return Constants.titleStartAgainButton
            case .endGame:
                return Constants.titleEndGameButton
            case .yes:
                return Constants.titleYesButton
            case .no:
                return Constants.titleNoButton
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .ready:
                return Constants.grayColor
            case .offLine:
                return Constants.whiteColor
            case .online:
                return Constants.blackColor
            case .firstButton:
                return Constants.blackColor
            case .secondButton:
                return Constants.blackColor
            case .thirdButton:
                return Constants.blackColor
            case .fourthButton:
                return Constants.blackColor
            case .fifthButton:
                return Constants.blackColor
            case .nextStep:
                return Constants.whiteColor
            case .startAgain:
                return Constants.whiteColor
            case .endGame:
                return Constants.blackColor
            case .yes:
                return Constants.blackColor
            case .no:
                return Constants.whiteColor
            }
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(setupButton: ButtonType) {
        super.init(frame: .zero)
        titleLabel?.font = UIFont(name: Constants.fontRubikMedium, size: Constants.textSize)
        layer.shadowOffset = CGSize(width: Constants.O, height: Constants.shadowOffsetHeight)
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowColor = setupButton.shadowBorderColor.cgColor
        layer.borderColor = setupButton.shadowBorderColor.cgColor
        backgroundColor = setupButton.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        setTitle(setupButton.title, for: .normal)
        setTitleColor(setupButton.titleColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIButton.animate(withDuration: Constants.duration, animations: {
            self.frame.origin.y += Constants.frameY
            self.layer.shadowOpacity = Constants.shadowChange
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIButton.animate(withDuration: Constants.duration, animations: {
            self.frame.origin.y -= Constants.frameY
            self.layer.shadowOpacity = Constants.shadowOpacity
        })
    }
}

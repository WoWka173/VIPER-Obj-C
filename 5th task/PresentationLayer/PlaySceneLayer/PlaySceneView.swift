//
//  EventViewController.swift
//  5th task
//
//  Created by Владимир Курганов on 03.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let fontRubikRegular: String = "Rubik-Regular"
    static let fontSizeRubikRegular: CGFloat = 20
    static let fontRubikMedium: String = "Rubik-Medium"
    static let fontSizeRubikMedium: CGFloat = 20
    static let buttonCloseSize: CGFloat = 26
    static let imageSystemName: String = "xmark"
    static let buttonCloseRightAnchor: CGFloat = -44.75
    static let labelCounterText: String = "0/10"
    static let titleLabelText = ""
    static let backgroundViewBackgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let  backgroundViewAlpha: CGFloat = 0
    static let viewBackgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let numberOfLines: Int = 2
    static let resetBackgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let resetBorderColor = UIColor(red: 0.78, green: 0.843, blue: 0.608, alpha: 1).cgColor
    static let resetShadowColor = UIColor(red: 0.78, green: 0.843, blue: 0.608, alpha: 1).cgColor
    static let indexFour: Int = 4
    static let indexThree: Int = 3
    static let indexTwo: Int = 2
    static let indexOne: Int = 1
    static let indexZero: Int = 0
    static let buttonWidth: CGFloat = 335
    static let buttonHeight: CGFloat = 78
    static let continueButtonHeight: CGFloat = 48
    static let continueButtonTopAnchor: CGFloat = 32
    static let distanceBetweenButtons: CGFloat = 8
    static let firstButtonTopAnchor: CGFloat = 49
    static let labelQuestionTopAnchor: CGFloat = 61
    static let labelCounterLeftAnchor: CGFloat = 34
    static let plainProgressBarTopAnchor: CGFloat = 39
    static let plainProgressBarHeight: CGFloat = 10
    static let plainProgressBarWidth: CGFloat = 200
    static let backgroundViewTopAnchor: CGFloat = 10
    static let correctBackgroundColor = UIColor(red: 0.318, green: 0.812, blue: 0.4, alpha: 1)
    static let correctBorderColor = UIColor(red: 0.216, green: 0.698, blue: 0.302, alpha: 1).cgColor
    static let correctShadowColor = UIColor(red: 0.216, green: 0.698, blue: 0.302, alpha: 1).cgColor
    static let wrongBackgroundColor = UIColor(red: 1, green: 0.42, blue: 0.428, alpha: 1)
    static let wrongBorderColor = UIColor(red: 0.824, green: 0.31, blue: 0.318, alpha: 1).cgColor
    static let wrongShadowColor = UIColor(red: 0.824, green: 0.31, blue: 0.318, alpha: 1).cgColor
    static let animateDuration: CGFloat = 0.25
    static let FullAlpha: CGFloat = 1
}

//MARK: - PlaySceneViewProtocol
protocol PlaySceneViewProtocol: AnyObject {
    func presentEndGameAlert()
    func setQuestion(text: String)
}

//MARK: - PlaySceneViewController
final class PlaySceneViewController: UIViewController {
    
    //MARK: - Properties
    private var presenter: PlayScenePresenterProtocol
    private var plainProgressBar = PlainProgressBar()
    
    private var round: Int?
    
    private var labelCounter: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(
            name: Constants.fontRubikRegular,
            size: Constants.fontSizeRubikRegular
        )
        label.text = Constants.labelCounterText
        return label
    }()
    
    private var buttonClose: UIButton = {
        let buttonClose = UIButton(type: .custom)
        let imageSize = UIImage.SymbolConfiguration(
            pointSize: Constants.buttonCloseSize,
            weight: .semibold
        )
        buttonClose.tintColor = .black
        buttonClose.setImage(
            UIImage(
                systemName: Constants.imageSystemName,
                withConfiguration: imageSize),
            for: .normal
        )
        buttonClose.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        return buttonClose
    }()
    
    private var labelQuestion: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont(
            name: Constants.fontRubikMedium,
            size: Constants.fontSizeRubikMedium
        )
        titleLabel.text = Constants.titleLabelText
        return titleLabel
    }()
    
    private lazy var continueButton: CustomButton = {
        let continueButton = CustomButton(setupButton: .nextStep)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        continueButton.isHidden = true
        return continueButton
    }()
    
    private let backgroundView: UIView = {
        var backgroundView = UIView()
        backgroundView.backgroundColor = Constants.backgroundViewBackgroundColor
        backgroundView.alpha = Constants.backgroundViewAlpha
        return backgroundView
    }()
    
    var arrayButton: [CustomButton] = {
        let arrayButton =  [CustomButton(setupButton: .firstButton), CustomButton(setupButton: .secondButton), CustomButton(setupButton: .thirdButton), CustomButton(setupButton: .fourthButton), CustomButton(setupButton: .fifthButton)]
        
        for (index, button) in arrayButton.enumerated() {
            button.tag = index
            button.addTarget(nil, action: #selector(eventButtonTapped(_ :)), for: .touchUpInside)
        }
        return arrayButton
    }()
    
    //MARK: - Init
    init(presenter: PlayScenePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        presenter.view = self
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
        resetButton()
        setTitleButton()
        plainProgressBar.resetProgress()
        continueButton.isHidden = true
        labelCounter.text = Constants.labelCounterText
    }
    
    //MARK: - Methods
    private func setupView() {
        setupPlainProgressBar()
        setupLabelCounter()
        setupButtonClose()
        setupLabelQuestion()
        setupFirstButton()
        setupSecondButton()
        setupThirdButton()
        setupFourthButton()
        setupFifthButton()
        setupContinueButton()
    }
    
    private func setSubTitleButton() {
        let arraySubTitle = presenter.setupSubTitleButton()
        
        if arraySubTitle.count == arrayButton.count {
            arrayButton.forEach { button in
                button.titleLabel?.numberOfLines = Constants.numberOfLines
                button.titleLabel?.textAlignment = .center
                button.setAttributedTitle(arraySubTitle[button.tag], for: .normal)
            }
        }
    }
    
    private func setTitleButton() {
        let arrayTitle = presenter.setupTitleButton()
        
        if arrayTitle.count == arrayButton.count {
            arrayButton.forEach { button in
                button.setAttributedTitle(arrayTitle[button.tag], for: .normal)
            }
        }
    }
    
    private func buttonDisable() {
        arrayButton.forEach { button in
            button.isEnabled = false
        }
        continueButton.isHidden = false
    }
    
    private func resetButton() {
        arrayButton.forEach  { button in
            button.backgroundColor = Constants.resetBackgroundColor
            button.layer.borderColor = Constants.resetBorderColor
            button.layer.shadowColor = Constants.resetShadowColor
            button.isEnabled = true
        }
    }
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: arrayButton[Constants.indexFour].bottomAnchor, constant: Constants.continueButtonTopAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            continueButton.heightAnchor.constraint(equalToConstant: Constants.continueButtonHeight)
        ])
    }
    
    private func setupFifthButton() {
        view.addSubview(arrayButton[Constants.indexFour])
        arrayButton[Constants.indexFour].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrayButton[Constants.indexFour].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrayButton[Constants.indexFour].topAnchor.constraint(equalTo: arrayButton[Constants.indexThree].bottomAnchor, constant: Constants.distanceBetweenButtons),
            arrayButton[Constants.indexFour].widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            arrayButton[Constants.indexFour].heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupFourthButton() {
        view.addSubview(arrayButton[Constants.indexThree])
        arrayButton[Constants.indexThree].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrayButton[Constants.indexThree].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrayButton[Constants.indexThree].topAnchor.constraint(equalTo: arrayButton[Constants.indexTwo].bottomAnchor, constant: Constants.distanceBetweenButtons),
            arrayButton[Constants.indexThree].widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            arrayButton[Constants.indexThree].heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupThirdButton() {
        view.addSubview(arrayButton[Constants.indexTwo])
        arrayButton[Constants.indexTwo].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrayButton[Constants.indexTwo].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrayButton[Constants.indexTwo].topAnchor.constraint(equalTo: arrayButton[Constants.indexOne].bottomAnchor, constant: Constants.distanceBetweenButtons),
            arrayButton[Constants.indexTwo].widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            arrayButton[Constants.indexTwo].heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupSecondButton() {
        view.addSubview(arrayButton[Constants.indexOne])
        arrayButton[Constants.indexOne].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrayButton[Constants.indexOne].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrayButton[Constants.indexOne].topAnchor.constraint(equalTo: arrayButton[Constants.indexZero].bottomAnchor, constant: Constants.distanceBetweenButtons),
            arrayButton[Constants.indexOne].widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            arrayButton[Constants.indexOne].heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupFirstButton() {
        view.addSubview(arrayButton[Constants.indexZero])
        arrayButton[Constants.indexZero].translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrayButton[Constants.indexZero].centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrayButton[Constants.indexZero].topAnchor.constraint(equalTo: labelQuestion.bottomAnchor, constant: Constants.firstButtonTopAnchor),
            arrayButton[Constants.indexZero].widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            arrayButton[Constants.indexZero].heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func setupLabelQuestion() {
        view.addSubview(labelQuestion)
        labelQuestion.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelQuestion.topAnchor.constraint(equalTo: plainProgressBar.bottomAnchor, constant: Constants.labelQuestionTopAnchor),
            labelQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupButtonClose() {
        view.addSubview(buttonClose)
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonClose.centerYAnchor.constraint(equalTo: plainProgressBar.centerYAnchor),
            buttonClose.rightAnchor.constraint(equalTo: plainProgressBar.leftAnchor, constant: Constants.buttonCloseRightAnchor),
        ])
    }
    
    private func setupLabelCounter() {
        view.addSubview(labelCounter)
        labelCounter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelCounter.centerYAnchor.constraint(equalTo: plainProgressBar.centerYAnchor),
            labelCounter.leftAnchor.constraint(equalTo: plainProgressBar.rightAnchor, constant: Constants.labelCounterLeftAnchor),
            
        ])
    }
    
    private func setupPlainProgressBar() {
        view.addSubview(plainProgressBar)
        plainProgressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plainProgressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.plainProgressBarTopAnchor),
            plainProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plainProgressBar.heightAnchor.constraint(equalToConstant: Constants.plainProgressBarHeight),
            plainProgressBar.widthAnchor.constraint(equalToConstant: Constants.plainProgressBarWidth)
        ])
    }
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: plainProgressBar.bottomAnchor, constant: Constants.backgroundViewTopAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - @objc Methods
    @objc
    private func eventButtonTapped(_ sender: CustomButton) {
        let arrResult = presenter.checkAnswer(buttonTag: sender.tag)
        
        for (index, button) in arrResult.enumerated() {
            switch button {
            case .correct:
                arrayButton[index].backgroundColor = Constants.correctBackgroundColor
                arrayButton[index].layer.borderColor = Constants.correctBorderColor
                arrayButton[index].layer.shadowColor = Constants.correctShadowColor
                
                if sender.tag == presenter.getTrueIndex() {
                    presenter.appendScore()
                    let score = presenter.getScore()
                    labelCounter.text = "\(score)/10"
                }
                
            case .wrong:
                arrayButton[index].backgroundColor = Constants.wrongBackgroundColor
                arrayButton[index].layer.borderColor = Constants.wrongBorderColor
                arrayButton[index].layer.shadowColor = Constants.wrongShadowColor
                
            case .classic:
                break
            }
        }
        setSubTitleButton()
        buttonDisable()
    }
    
    @objc
    private func continueButtonTapped() {
        presenter.nextRound()
        plainProgressBar.setProgress()
        setupBackgroundView()
        resetButton()
        UIView.animate(withDuration: Constants.animateDuration, animations: {
            self.backgroundView.alpha = Constants.FullAlpha
        }, completion: { _ in
            UIView.animate(withDuration: Constants.animateDuration, animations: { [self] in
                continueButton.isHidden = true
                setTitleButton()
                presenter.setupQuestion()
                backgroundView.alpha = Constants.backgroundViewAlpha
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.backgroundView.removeFromSuperview()
            }
        })
    }
    
    @objc
    private func endGameButtonTapped() {
        presenter.popToRoot()
    }
    
    @objc
    private func closeButtonTapped() {
        presenter.endGameAlert()
    }
    
    @objc
    private func showResultViewCotroller() {
        presenter.popToRoot()
    }
}

//MARK: - Extension
extension PlaySceneViewController: PlaySceneViewProtocol {
    
    //MARK: - Methods
    func presentEndGameAlert() {
        presenter.customAlert?.showEndGameAlert(on: self)
    }
    
    func setQuestion(text: String) {
        labelQuestion.text = text
    }
}

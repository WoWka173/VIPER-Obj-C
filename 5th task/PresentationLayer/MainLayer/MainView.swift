//
//  ViewController.swift
//  5th task
//
//  Created by Владимир Курганов on 31.10.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let fontRubik: String = "Rubik-Medium"
    static let fontSizeRubik: CGFloat = 20
    static let navigationTitleSize: CGFloat = 16
}

//MARK: - ViewControllerProtocol
protocol MainViewProtocol: AnyObject {
    func presentAlert()
    func setupProgressBar(scoreProgress: Int)
    func setupScoreLabel(scoreOfDay: Int)
    func setupColorProgressBar(scoreOfDay: Int)
}

final class MainView: UIViewController {
    
    //MARK: - Properties
    private var presenter: MainPresenterProtocol
    private var circularProgressBar = CircularProgressBar()
    
    private lazy var leftBarbutton: UIButton = {
        let leftBarbutton = UIButton(type: .custom)
        leftBarbutton.setImage(UIImage(named: "Cup"), for: .normal)
        leftBarbutton.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        return leftBarbutton
    }()
    
    private lazy var rightBarbutton: UIButton = {
        let rightBarbutton = UIButton(type: .custom)
        rightBarbutton.setImage(UIImage(named: "Setup"), for: .normal)
        return rightBarbutton
    }()
    
    private var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .systemGray
        return lineView
    }()
    
    private lazy var questionButton: UIButton = {
        let questionButton = UIButton(type: .custom)
        questionButton.setImage(UIImage(named: "question mark"), for: .normal)
        return questionButton
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "ПРАВИЛЬНЫХ ОТВЕТОВ"
        label.font = UIFont(name: Constants.fontRubik, size: 16)
        return label
    }()
    
    private lazy var buttonDE: UIButton = {
        let buttonDE = UIButton(type: .custom)
        buttonDE.setImage(UIImage(named: "DE"), for: .normal)
        return buttonDE
    }()
    
    private lazy var buttonUK: UIButton = {
        let buttonUK = UIButton(type: .custom)
        buttonUK.setImage(UIImage(named: "UK"), for: .normal)
        return buttonUK
    }()
    
    private lazy var buttonFR: UIButton = {
        let buttonFR = UIButton(type: .custom)
        buttonFR.setImage(UIImage(named: "FR"), for: .normal)
        return buttonFR
    }()
    
    private lazy var buttonES: UIButton = {
        let buttonES = UIButton(type: .custom)
        buttonES.setImage(UIImage(named: "ES"), for: .normal)
        return buttonES
    }()
    
    private lazy var buttonOffline: CustomButton = {
        let buttonOffline = CustomButton(setupButton: .offLine)
        buttonOffline.addTarget(self, action: #selector(offlineButtonTapped), for: .touchUpInside)
        return buttonOffline
    }()
    
    private lazy var buttonOnLine: CustomButton = {
        let buttonOnLine = CustomButton(setupButton: .online)
        return buttonOnLine
    }()
    
    //MARK: - Init
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
        presenter.view = self
        presenter.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
  
    //MARK: - Methods
    func setupUserDefaults() {
        if presenter.interactor?.getData() != nil {
        } else {
            showEnterNameAlert()
        }
    }
    
    private func setupView() {
        setupUserDefaults()
        setupNavigationBar()
        setupLineView()
        setupQuestionButton()
        setupLabel()
        setupProgressBar()
        setupButtonDE()
        setupButtonUK()
        setupButtonFR()
        setupButtonES()
        setupButtonOffLine()
        setupButtonOnLine()
    }
    
    private func showEnterNameAlert() {
        presenter.enterNameAlert()
    }
    
    private func setupButtonOnLine() {
        view.addSubview(buttonOnLine)
        buttonOnLine.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonOnLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOnLine.topAnchor.constraint(equalTo: buttonOffline.bottomAnchor, constant: 20),
            buttonOnLine.widthAnchor.constraint(equalToConstant: 335),
            buttonOnLine.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupButtonOffLine() {
        view.addSubview(buttonOffline)
        buttonOffline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonOffline.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOffline.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            buttonOffline.widthAnchor.constraint(equalToConstant: 335),
            buttonOffline.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupButtonES() {
        view.addSubview(buttonES)
        buttonES.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonES.topAnchor.constraint(equalTo: buttonUK.bottomAnchor, constant: 18),
            buttonES.centerXAnchor.constraint(equalTo: buttonUK.centerXAnchor),
            buttonES.widthAnchor.constraint(equalToConstant: 72),
            buttonES.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupButtonFR() {
        view.addSubview(buttonFR)
        buttonFR.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonFR.topAnchor.constraint(equalTo: buttonDE.bottomAnchor, constant: 18),
            buttonFR.centerXAnchor.constraint(equalTo: buttonDE.centerXAnchor),
            buttonFR.widthAnchor.constraint(equalToConstant: 72),
            buttonFR.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupButtonUK() {
        view.addSubview(buttonUK)
        buttonUK.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonUK.leftAnchor.constraint(equalTo: buttonDE.rightAnchor, constant: 18),
            buttonUK.centerYAnchor.constraint(equalTo: buttonDE.centerYAnchor),
            buttonUK.widthAnchor.constraint(equalToConstant: 72),
            buttonUK.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupButtonDE() {
        view.addSubview(buttonDE)
        buttonDE.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonDE.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonDE.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 125),
            buttonDE.widthAnchor.constraint(equalToConstant: 72),
            buttonDE.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupProgressBar() {
        view.addSubview(circularProgressBar)
        circularProgressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularProgressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularProgressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 77),
            circularProgressBar.heightAnchor.constraint(equalToConstant: 150),
            circularProgressBar.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupNavigationBar() {
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: Constants.fontRubik, size: Constants.navigationTitleSize) as Any
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = "LANGUAGE QUIZZES"
        navigationController?.navigationBar.backgroundColor =  UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
        let leftBarItem = UIBarButtonItem(customView: leftBarbutton)
        navigationItem.leftBarButtonItem = leftBarItem
        let rightBarItem = UIBarButtonItem(customView: rightBarbutton)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    private func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26)
        ])
    }
    
    private func setupQuestionButton() {
        view.addSubview(questionButton)
        questionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            questionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 23.11),
        ])
    }
    
    private func setupLineView() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo:navigationController.navigationBar.bottomAnchor),
            lineView.widthAnchor.constraint(equalTo: navigationController.navigationBar.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerXAnchor.constraint(equalTo: navigationController.navigationBar.centerXAnchor)
        ])
    }
    
    //MARK: - @objc Methods
    @objc
    func editingChanged(_ textField: UITextField) {
        presenter.customAlert?.editingChanged(textField)
    }
    
    @objc
    func dismissAlert()  {
        presenter.customAlert?.dismissAlert()
        let text =  presenter.customAlert?.textFieldAlert.text ?? ""
        presenter.interactor?.setData(text: text)
        presenter.interactor?.addPlayerToDB(name: text)
    }
    
    @objc
    func offlineButtonTapped() {
        presenter.showPlaytView()
    }
    
    @objc
    func ratingButtonTapped() {
        presenter.showRatingTable()
    }
}

//MARK: - Extension MainViewController
extension MainView: MainViewProtocol {
    func presentAlert() {
        presenter.customAlert?.showNameAlert(on: self)
    }
    
    func setupProgressBar(scoreProgress: Int) {
        circularProgressBar.setProgress(scoreOfDay: scoreProgress)
    }
    
    func setupScoreLabel(scoreOfDay: Int) {
        circularProgressBar.setScoreLabel(scoreOfDay: scoreOfDay)
    }
    
    func setupColorProgressBar(scoreOfDay: Int) {
        circularProgressBar.setColorProgress(scoreOfDay: scoreOfDay)
    }
}


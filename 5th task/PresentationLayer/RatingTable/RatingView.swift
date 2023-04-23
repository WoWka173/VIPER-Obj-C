//
//  TableViewController.swift
//  5th task
//
//  Created by Владимир Курганов on 22.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let O: CGFloat = 0
    static let height: CGFloat = 40
    static let fontRubik: String = "Rubik-Medium"
    static let fontSizeRubik: CGFloat = 20
    static let navigationTitleSize: CGFloat = 16
    static let tableViewBackgroundColor =  UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let imageRightBarbutton: String = "pencil"
    static let viewBackgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let imageBackButton: String = "arrow"
    static let backButtoTitle: String = ""
    static let navigationBarBackgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let navigationItemTitle = "РЕЙТИНГ"
}

//MARK: - RatingViewProtocol
protocol RatingViewProtocol: AnyObject {
    func setupTableView()
    var tableViewBuilder: RatingTableBuilder { get set }
    func checkOut()
    func presentAlert()
}

//MARK: - RatingView
final class RatingView: UIViewController {
    
    //MARK: - Properties
    var presenter: RatingPresenterProtocol
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = CustomFooter(frame: CGRect(x: Constants.O, y: Constants.O, width: view.frame.width, height: Constants.height))
        tableView.backgroundColor = Constants.tableViewBackgroundColor
        return tableView
    }()
    
    lazy var tableViewBuilder = RatingTableBuilder(tableView: tableView, presenter: presenter)
    let indicator = UIActivityIndicatorView(style: .medium)
    
    private lazy var rightBarbutton: UIButton = {
        let rightBarbutton = UIButton(type: .custom)
        rightBarbutton.setImage(UIImage(named: Constants.imageRightBarbutton), for: .normal)
        rightBarbutton.addTarget(self, action: #selector(rightBarbuttonTapped), for: .touchUpInside)
        return rightBarbutton
    }()
    
    //MARK: - Init
    init(presenter: RatingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.viewBackgroundColor
        setupTableView()
        indicatorSetup()
        setupNavigationBar()
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    //MARK: - Methods
    func presentAlert() {
        presenter.customAlert?.showNameAlert(on: self)
    }
    
    private func setupNavigationBar() {
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: Constants.fontRubik, size: Constants.navigationTitleSize) as Any
        ]
        
        let imgBackArrow = UIImage(named: Constants.imageBackButton)
        navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        
        let backButton = UIBarButtonItem()
        backButton.title = Constants.backButtoTitle
        backButton.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.title = Constants.navigationItemTitle
        navigationController?.navigationBar.backgroundColor =  Constants.navigationBarBackgroundColor
        
        let rightBarItem = UIBarButtonItem(customView: rightBarbutton)
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    private func indicatorSetup() {
        tableView.addSubview(indicator)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
        ])
    }
    
    //MARK: - @objc Methods
    @objc
    private func rightBarbuttonTapped() {
        presenter.editNameAlert()
    }
    
    @objc
    private func editingChanged(_ textField: UITextField) {
        presenter.customAlert?.editingChanged(textField)
    }
    
    @objc
    private func dismissAlert()  {
        presenter.customAlert?.dismissAlert()
        let text =  presenter.customAlert?.textFieldAlert.text ?? ""
        presenter.interactor?.renameDocument(newName: text)
        presenter.interactor?.setData(newName: text)
        self.tableView.reloadData()
    }
}

//MARK: - Extension TableView
extension RatingView: RatingViewProtocol {
    func checkOut() {
        indicator.stopAnimating()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


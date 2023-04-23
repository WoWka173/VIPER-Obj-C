//
//  MainPresenter.swift
//  5th task
//
//  Created by Владимир Курганов on 02.11.2022.
//

import Foundation

//MARK: - MainPresenterProtocol
protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    var interactor: MainInteractorProtocol? { get set }
    var customAlert: CustomAlertEnterNameProtocol? { get set }
    func showPlaytView()
    func viewDidLoad()
    func enterNameAlert()
    func showRatingTable()
    func setScore(scoreOfDay: Int)
}

//MARK: - MainPresenter
final class MainPresenter {
    
    //MARK: - Properties
    weak var view: MainViewProtocol?
    var router: MainRouterProtocol?
    var interactor: MainInteractorProtocol?
    var customAlert: CustomAlertEnterNameProtocol?
    
    //MARK: - Init
    init(router: MainRouterProtocol,interactor: MainInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
extension MainPresenter: MainPresenterProtocol {
    
    //MARK: - Methods
    func enterNameAlert() {
        self.customAlert = CustomAlertEnterName()
        view?.presentAlert()
        customAlert?.textFieldAlert.becomeFirstResponder()
    }
    
    func showRatingTable() {
        router?.showRatingView()
    }
    
    func showPlaytView() {
        router?.showPlayView()
    }
    
    func viewDidLoad() {
        interactor?.loadData()
    }
    
    func setScore(scoreOfDay: Int) {
        view?.setupColorProgressBar(scoreOfDay: scoreOfDay)
        view?.setupProgressBar(scoreProgress: scoreOfDay)
        view?.setupScoreLabel(scoreOfDay: scoreOfDay)
    }
}

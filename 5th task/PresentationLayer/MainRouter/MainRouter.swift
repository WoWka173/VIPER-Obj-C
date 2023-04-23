//
//  Router.swift
//  5th task
//
//  Created by Владимир Курганов on 02.11.2022.
//

import Foundation
import UIKit

//MARK: - RouterProtocol
@objc
protocol MainRouterProtocol: AnyObject {
    func initialView() -> UINavigationController?
    func showPlayView()
    func showRatingView()
    func showResultView()
    func popToRoot()
    func popToBack()
}

//MARK: - Router
@objc(MainRouter)
final class MainRouter: NSObject, MainRouterProtocol {
    
    //MARK: - Properties
    var navigationController : UINavigationController?
    let mainBuilder: MainBuilderProtocol?
    var eventBuilder: PlaySceneBuilder?
    var ratingBuilder: RatingBuilderProtocol?
    
    var resultBuilder: ResultBuilderProtocol?
    
    //MARK: - Init
    override init() {
        self.mainBuilder = MainBuilder()
    }
    
    //MARK: - Methods
    func initialView() -> UINavigationController?  {
        let apiManager: APIManagerProtocol = APIManager()
        let interactor = MainInteractor(apiManager: apiManager)
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        guard let mainViewController = mainBuilder?.createMainModule(router: self, interactor: interactor) else { return UINavigationController() }
        navigationController.viewControllers = [mainViewController]
        return navigationController
    }
    
    func showPlayView() {
        self.eventBuilder = PlaySceneBuilder()
        let gameService: GameServiceProtocol = GameService()
        let interactor = PlaySceneInteractor(gameService: gameService)
        guard let eventView = eventBuilder?.createPlaySceneModule(router: self, interactor: interactor) else { return }
        navigationController?.pushViewController(eventView, animated: true)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    func showRatingView() {
        self.ratingBuilder = RatingBuilder()
        let apiManager: APIManagerProtocol = APIManager()
        let interactor = RatingInteractor(apiManager: apiManager)
        guard let tableView = ratingBuilder?.createRatingModule(router: self, interactor: interactor) else { return }
        navigationController?.pushViewController(tableView, animated: true)
    }
    
    @objc
    func showResultView() {
        resultBuilder = ResultBuilder()
        let interactor = ResultInteractor()
        guard let resultView = resultBuilder?.createResultModule(self, interactor) else { return }
        navigationController?.pushViewController(resultView, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
    }
  
    @objc
    func popToBack() {
        navigationController?.popViewController(animated: true)
    }
}

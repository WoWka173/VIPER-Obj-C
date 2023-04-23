//
//  EventBuilder.swift
//  5th task
//
//  Created by Владимир Курганов on 14.11.2022.
//

import UIKit

//MARK: - PlaySceneBuilderProtocol
protocol PlaySceneBuilderProtocol {
    func createPlaySceneModule(router: MainRouterProtocol, interactor: PlaySceneInteractorProtocol) -> UIViewController
}

//MARK: - PlaySceneBuilder
final class PlaySceneBuilder: PlaySceneBuilderProtocol {
    
    //MARK: - Methods
    func createPlaySceneModule(router: MainRouterProtocol, interactor: PlaySceneInteractorProtocol) -> UIViewController {
        let presenter = PlayScenePresenter(router: router, interactor: interactor)
        let view = PlaySceneViewController(presenter: presenter)
        interactor.presenter = presenter
        return view
    }
    
 
}

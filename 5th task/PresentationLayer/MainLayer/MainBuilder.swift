//
//  ViewControllerBuilder.swift
//  5th task
//
//  Created by Владимир Курганов on 02.11.2022.
//

import UIKit
//MARK: - ModuleViewControllerBuilderProtocol
protocol MainBuilderProtocol {
    func createMainModule(router: MainRouterProtocol, interactor: MainInteractorProtocol) -> UIViewController
}

//MARK: - ModuleViewControllerBuilder
final class MainBuilder: MainBuilderProtocol {
    
    //MARK: - Methods
    func createMainModule(router: MainRouterProtocol, interactor: MainInteractorProtocol) -> UIViewController {
        let presenter = MainPresenter(router: router, interactor: interactor)
        let view = MainView(presenter: presenter)
        interactor.presenter = presenter
        return view
    }
}


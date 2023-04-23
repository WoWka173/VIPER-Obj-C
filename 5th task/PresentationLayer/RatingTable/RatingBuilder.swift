//
//  TableViewControllerBuilder.swift
//  5th task
//
//  Created by Владимир Курганов on 22.11.2022.
//

import UIKit
//MARK: - RatingBuilderProtocol
protocol RatingBuilderProtocol {
    func createRatingModule(router: MainRouterProtocol, interactor: RatingInteractorProtocol) -> UIViewController
}

//MARK: - RatingBuilder
final class RatingBuilder: RatingBuilderProtocol {
    
    //MARK: - Methods
    func createRatingModule(router: MainRouterProtocol, interactor: RatingInteractorProtocol) -> UIViewController {
        let presenter = RatingPresenter(router: router, interactor: interactor)
        let view = RatingView(presenter: presenter)
        interactor.presenter = presenter
        return view
    }
}

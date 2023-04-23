//
//  MockRouter.swift
//  5th taskTests
//
//  Created by Владимир Курганов on 14.12.2022.
//

import XCTest
@testable import _th_task

final class MocKRouter: MainRouterProtocol {
    
    func initialView() -> UINavigationController? {
        var navController: UINavigationController?
        return navController
    }
    
    var showPlayViewCounter = 0
    func showPlayView() {
        showPlayViewCounter += 1
    }
    
    var showRatingViewCounter = 0
    func showRatingView() {
        showRatingViewCounter += 1
    }
    
    var showResultViewCounter = 0
    func showResultView() {
        showResultViewCounter += 1
    }
    
    var popToRootCounter = 0
    func popToRoot() {
        popToRootCounter += 1
    }
    
    var popToBackCounter = 0
    func popToBack() {
        popToBackCounter += 1
    }
}

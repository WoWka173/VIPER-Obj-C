//
//  MainPresenterTest.swift
//  5th taskTests
//
//  Created by Владимир Курганов on 14.12.2022.
//

import XCTest
@testable import _th_task

final class MockMainView: MainViewProtocol {
    
    
    
    var label: String = ""
    
    func presentAlert() {
        //
    }
    
    func setupProgressBar(scoreProgress: Int) {
        //
    }
    
    func setupScoreLabel(scoreOfDay: Int) {
        label = "\(scoreOfDay)"
    }
    
    func setupColorProgressBar(scoreOfDay: Int) {
        //
    }
    
    
}

final class MainPresenterTest: XCTestCase {
    
    var presenter: MainPresenterProtocol!
    var router: MocKRouter!
    var interactor: MainInteractorProtocol!
    var apiManager: APIManagerProtocol!
   
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiManager = APIManager()
        router = MocKRouter()
        interactor = MainInteractor(apiManager: apiManager)
        presenter = MainPresenter(router: router, interactor: interactor)
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        apiManager = nil
        router = nil
        interactor = nil
        presenter = nil
       
    }
    
    func testEnterNameAlert() throws {
        //When
        presenter.enterNameAlert()
        
        //Then
        XCTAssertNotNil(presenter.customAlert)
    }
    
    func testShowRatingTable() {
        //When
        presenter.showRatingTable()
        
        //Then
        XCTAssertEqual(router.showRatingViewCounter, 1, "error showRatingTable")
    }
    
    func testShowEventView() throws {
        //When
        presenter.showPlaytView()
        
        //Then
        XCTAssertEqual(router.showPlayViewCounter, 1, "error showPlaytView")
    }
    
    func testSetScore() throws {
        // Give
        let mockView = MockMainView()
        presenter.view = mockView
        let score = 5
        
        //When
        presenter.setScore(scoreOfDay: score)
        
        //Then
        XCTAssertEqual(mockView.label, "\(score)", "error setScore")
    }
    
    func testViewDidLoad() throws {
        // Give
        var circularProgressBar = CircularProgressBar()
        let scoreOfDay = UserService.shared.getUserScore(forKey: "scoreOfDay")
        
        //When
        presenter.viewDidLoad()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertEqual(circularProgressBar.scoreLabel.text, "\(scoreOfDay)/50", "error scoreLabel")
        }
    }
}

//
//  RatingPresenterTest.swift
//  5th taskTests
//
//  Created by Владимир Курганов on 14.12.2022.
//

import XCTest
@testable import _th_task

final class RatingPresenterTest: XCTestCase {
    
    var presenter: RatingPresenterProtocol!
    var router: MainRouterProtocol!
    var interactor: RatingInteractorProtocol!
    var apiManager: APIManagerProtocol!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiManager = APIManager()
        router = MocKRouter()
        interactor = RatingInteractor(apiManager: apiManager)
        presenter = RatingPresenter(router: router, interactor: interactor)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        presenter = nil
        interactor = nil
        router = nil
        apiManager = nil
    }
    
    func testEditNameAlert() throws {
        //When
        presenter.editNameAlert()
        
        //Then
        XCTAssertNotNil(presenter.customAlert)
    }
    
    func testDidGetData() throws {
        //Give
        let testName = "test"
        let testScore = 10
        
        //When
        presenter.didGetData(name: testName, score: testScore)
        
        //Then
        XCTAssertEqual(presenter.name, testName)
        XCTAssertEqual(presenter.score, testScore)
    }
    
    func testDidLoadData() throws {
        //Give
        let testModel: [MWUserModel] = [MWUserModel(name: "test", score: 0, id: "test")]
        //When
        presenter.didLoadData(data: testModel)
        
        //Then
        XCTAssertEqual(presenter.mainModel[0].name, testModel[0].name)
        XCTAssertEqual(presenter.mainModel[0].score, testModel[0].score)
        XCTAssertEqual(presenter.mainModel[0].id, testModel[0].id)
    }
    
    func testSetupData() throws {
        //Give
        presenter.mainModel = [MWUserModel(name: "test", score: 0, id: "test"), MWUserModel(name: "test1", score: 1, id: "test1")]
        
        //When
        presenter.setupData()
        
        //Then
        let modelSection = presenter.sections[0].cellsModels.count
        XCTAssertEqual(modelSection, 2, "error section.cellsModels count")
    }
    
    func testReloadTable() throws {
        //Give
        presenter.mainModel = [MWUserModel(name: "test", score: 0, id: "test")]
        
        //When
        presenter.reloadTable()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let modelSection = self.presenter.sections[0].cellsModels.count
            XCTAssertEqual(modelSection, 1, "error section.cellsModels count")
        }
    }
}

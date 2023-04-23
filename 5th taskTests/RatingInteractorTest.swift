//
//  RatingInteractorTest.swift
//  5th taskTests
//
//  Created by Владимир Курганов on 14.12.2022.
//

import XCTest
@testable import _th_task

final class RatingInteractorTest: XCTestCase {
    
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
        interactor.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        presenter = nil
        interactor = nil
        router = nil
        apiManager = nil
    }
    
    func testGetData() throws {
        //Give
        UserService.shared.setData(value: "testName", forKey: "Name")
        UserService.shared.setData(value: 10, forKey: "allScore")
        
        //When
        interactor.getData()
        
        //Then
        let saveName = UserService.shared.getUserName(forKey: "Name")
        XCTAssertEqual(presenter.name, saveName)
    }
    
    func testSetData() throws {
        //Give
        let testName = "test"
        
        //When
        interactor.setData(newName: testName)
        
        //Then
        XCTAssertEqual(presenter.name, "test")
    }
    
    func testRenameDocument() throws {
        //Give
        let testNewName = "testNewName"
        
        //When
        interactor.renameDocument(newName: testNewName)
        
        //Then
        apiManager.getDocument(docName: "testNewName") { document in
            XCTAssertEqual(document?.name, "testNewName")
        }
    }
    
    func testLoadData() throws {
        //When
        interactor.loadData()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let arrayModels = self.presenter.mainModel.isEmpty
            XCTAssertFalse(arrayModels)
        }
    }
}

//
//  MainInteractorTest.swift
//  5th taskTests
//
//  Created by Владимир Курганов on 14.12.2022.
//

import XCTest
@testable import _th_task

final class MainInteractorTest: XCTestCase {
    
    var interactor: MainInteractorProtocol!
    var apiManager: APIManagerProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiManager = APIManager()
        interactor = MainInteractor(apiManager: apiManager)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        apiManager = nil
        interactor = nil
    }
    
    func testGetData() throws {
        // Give
        UserService.shared.setData(value: "test", forKey: "Name")
        
        //When
        let data = interactor.getData()
        
        //Then
        XCTAssertNotNil(data, "data is nil")
    }
    
    func testSetData() throws {
        //Give
        let text = "test"
        
        // When
        interactor.setData(text: text)
        
        //Then
        let getData = UserService.shared.getUserName(forKey: "Name")
        XCTAssertEqual(getData, text, "error set data")
    }
    
    func testAddPlayerToDB() throws {
        //Give
        let name = "test"
        //When
        interactor.addPlayerToDB(name: name)
        
        //Then
        apiManager.getDocument(docName: "test") { document in
            
            XCTAssertEqual(document?.name ?? "", "test", "error name document")
        }
    }
}

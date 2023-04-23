//
//  Test.swift
//  5th taskTests
//
//  Created by Владимир Курганов on 13.12.2022.
//

import XCTest
@testable import _th_task

final class MockView: PlaySceneViewProtocol {
    
    var label: String = ""
    
    func presentEndGameAlert() {
        //
    }
    
    func setQuestion(text: String) {
        self.label = text
    }
}

final class PlayScenePresenterTest: XCTestCase {
    
    var presenter: PlayScenePresenterProtocol!
    var router: MocKRouter!
    var interactor: PlaySceneInteractorProtocol!
    var gameService: GameServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        router = MocKRouter()
        gameService = GameService()
        interactor = PlaySceneInteractor(gameService: gameService)
        presenter = PlayScenePresenter(router: router, interactor: interactor)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        router = nil
        interactor = nil
        presenter = nil
        gameService = nil
    }
    
    func testGetScore() throws {
        //Given
        gameService.score = 5
        
        //When
        let getScore = presenter.getScore()
        
        //Then
        XCTAssertEqual(getScore, 5, "getScore is wrong")
    }
    
    func testGetTrueIndex() throws {
        //Given
        gameService.trueIndex = 5
        
        //When
        let getTrueIndex = presenter.getTrueIndex()
        
        //Then
        XCTAssertEqual(getTrueIndex, 5, "getTrueIndex is wrong")
    }
    
    func testSetupTitleButton() throws {
        //Given
        gameService.startGame()
        let arrayKeys = [String](gameService.model[0].dict.keys)
        let arrayOfAtributed = presenter.setupTitleButton()
        var arrayString: [String] = []
        
        //When
        arrayOfAtributed.map { mutString in
            arrayString.append(mutString.string)
        }
        
        //Then
        XCTAssertEqual(arrayKeys, arrayString, "title is wrong")
    }
    
    func testSetupQuestion() throws {
        //Given
        let dict = ["Baz": "Bar", "Foo": "Gor", "Gen": "Sem", "Rom": "Kal", "Red": "Blu"]
        let roundModel = RoundModel(dict: dict)
        let mockView = MockView()
        gameService.model.append(roundModel)
        presenter.view = mockView
        gameService.trueIndex = 1
        
        //When
        presenter.setupQuestion()
        
        //Then
        XCTAssertEqual(mockView.label, dict["Foo"], "question is wrong")
    }
    
    func testSetupSubTitleButton() throws {
        //Given
        let dict = ["Baz": "Bar", "Foo": "Gor", "Gen": "Sem", "Rom": "Kal", "Red": "Blu"]
        let roundModel = RoundModel(dict: dict)
        gameService.model.append(roundModel)
        var arraySubstring: [String.SubSequence] = []
        var arrayTest: [String] = []
        var arrayString: [String] = []
        
        //When
        let arraySubTitle = presenter.setupSubTitleButton()
        
        //Then
        dict.map { key, value in
            arrayString.append(key)
            arrayString.append(value)
        }
        
        arraySubTitle.map { mutString in
            let subString = mutString.string.split(separator: "\n")
            arraySubstring.append(contentsOf: subString)
        }
        
        for i in arraySubstring {
            arrayString.append(String(i))
        }
        
        XCTAssertEqual(arrayTest, arrayString, "subTitles is wrong")
    }
    
    func testViewDidLoad() throws {
        //When
        presenter.viewDidLoad()
        
        //Then
        XCTAssertEqual(gameService.round, 1, "error call")
    }
    
    func testAppendScore() throws {
        //When
        presenter.appendScore()
        
        //Then
        XCTAssertEqual(gameService.score, 1, "error call")
    }
    
    func testCheckAnswer() throws {
        //Given
        gameService.trueIndex = 4
        let buttonTag = 4
        let testTrueArray: [TrueArray] = [.classic, .classic, .classic, .classic, .correct]
        
        //When
        let trueArray = presenter.checkAnswer(buttonTag: buttonTag)
        
        //Then
        XCTAssertEqual(trueArray, testTrueArray, "error checkAnswer")
    }
    
    func testEndGameAlert() throws {
        //When
        presenter.endGameAlert()
        
        //Then
        XCTAssertNotNil(presenter.customAlert, "customAlert is nil")
    }
    
    func testPoptoRoot() throws {
        //When
        presenter.popToRoot()

        //Then
        XCTAssertEqual(router.popToRootCounter, 1, "error pop to root")
    }
}

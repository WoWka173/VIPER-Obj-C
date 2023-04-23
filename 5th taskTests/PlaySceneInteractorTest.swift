//
//  EventInteractorTest.swift
//  5th taskTests
//
//  Created by Владимир Курганов on 06.12.2022.
//

import XCTest
@testable import _th_task

final class PlaySceneInteractorTest: XCTestCase {
    
    var interactor: PlaySceneInteractorProtocol!
    var gameService: GameServiceProtocol!
    
    override func setUpWithError() throws {
      try super.setUpWithError()
        gameService = GameService()
        interactor = PlaySceneInteractor(gameService: gameService)
    }

    override func tearDownWithError() throws {
       try super.tearDownWithError()
        interactor = nil
        gameService = nil
    }

    func testLoadData() throws {
        //When
        interactor.loadData()
        
        //Then
        XCTAssertEqual(gameService.round, 0, "error start game")
    }
    
    func testNextRound() throws {
        //When
        interactor.nextRound()
        
        //Then
        XCTAssertEqual(gameService.round, 1, "error next round")
    }
    
    func testGetScore() throws {
        //Given
        gameService.score = 10
        
        //When
        let score = interactor.getScore()
        
        //Then
        XCTAssertEqual(score, 10, "error get score")
    }
    
    func testAppendScore() throws {
        //Given
        gameService.score = 10
        
        //When
        interactor.appendScore()
        
        //Then
        let score = interactor.getScore()
        XCTAssertEqual(score, 11, "error append score")
    }
    
    func testGetTrueIndex() throws {
        //Given
        gameService.trueIndex = 4
        
        //When
        let trueIndex = interactor.getTrueIndex()
        
        //Then
        XCTAssertEqual(trueIndex, 4, "error trueIndex")
    }
    
    func testCheckAnswer() throws {
        //Given
        gameService.trueIndex = 3
        let index = 3
        let testTrueArray: [TrueArray] = [.classic, .classic, .classic, .correct, .classic]
        
        //When
        let trueArray = interactor.checkAnswer(index: index)
        
        //Then
        XCTAssertEqual(testTrueArray, trueArray, "error checkAnswer")
    }
    
    func testGetRoundModel() throws {
        //Given
        gameService.startGame()
        let testModel = gameService.model[5]
        let round = 5
        
        //When
        let roundModel = interactor.getRoundModel(round: round) 
        
        //Then
        XCTAssertEqual(roundModel.dict, testModel.dict, "error getRoundModel")
    }
    
    func testSetTrueIndex() throws {
        //When
        interactor.setTrueIndex()
        
        //Then
        XCTAssertLessThan(gameService.trueIndex, 5, "trueIndex is out in range")
    }
    
    func testGetRound() throws {
        //Given
        gameService.round = 5
        
        //When
        let round = interactor.getRound()
        
        //Then
        XCTAssertEqual(round, 5, "error get round")
    }
    
    func testSaveScore() throws {
        //Given
        gameService.score = 2
        
        //When
        interactor.saveScore()
        
        //Then
       let getScore = UserService.shared.getUserScore(forKey: "Score")
        XCTAssertEqual(getScore, 2, "error save score")
    }
    
    func testScoreOfDay() throws {
        //Given
        gameService.score = 2
        let score = gameService.score
        let scoreOfDay = UserService.shared.getUserScore(forKey: "scoreOfDay")
        
        //When
        interactor.saveScoreOfDay()
        
        //Then
        let saveScoreOfDay = UserService.shared.getUserScore(forKey: "scoreOfDay")
        XCTAssertEqual(saveScoreOfDay, score + scoreOfDay)
    }
    
    func testSaveAllScore() throws {
        //Given
        gameService.score = 1
        let score = gameService.score
        let allScore = UserService.shared.getUserScore(forKey: "allScore")
        
        //When
        interactor.saveAllScore()
        
        //Then
        let saveAllScore = UserService.shared.getUserScore(forKey: "allScore")
        XCTAssertEqual(saveAllScore, allScore + score)
    }
}

//
//  EventInteractor.swift
//  5th task
//
//  Created by Владимир Курганов on 13.11.2022.
//

import Foundation

//MARK: - Constants
fileprivate enum Constants {
    static let O: Int = 0
    static let score: String = "Score"
    static let scoreOfDay: String = "scoreOfDay"
    static let allScore: String = "allScore"
}

//MARK: - PlaySceneInteractorProtocol
protocol PlaySceneInteractorProtocol: AnyObject {
    var presenter: PlayScenePresenterProtocol? { get set }
    var gameService: GameServiceProtocol? { get set }
    func loadData()
    func saveScore()
    func saveScoreOfDay()
    func saveAllScore()
    func getRound() -> Int
    func setTrueIndex() -> Int
    func getRoundModel(round: Int) -> RoundModel
    func checkAnswer(index: Int) -> [TrueArray]
    func getTrueIndex() -> Int
    func appendScore()
    func getScore() -> Int
    func nextRound()
    
}

//MARK: - PlaySceneInteractor
final class PlaySceneInteractor  {
    
    //MARK: - Properties
    weak var presenter: PlayScenePresenterProtocol?
    var gameService: GameServiceProtocol?
    private var userService: UserServiceProtocol = UserService.shared
    
    init(gameService: GameServiceProtocol) {
        self.gameService = gameService
    }
}

//MARK: - Extension
extension PlaySceneInteractor: PlaySceneInteractorProtocol {
    
    //MARK: - Methods
    func loadData() {
        gameService?.startGame()
    }
    
    func nextRound() {
        gameService?.nextRound()
    }
    
    func getScore() -> Int {
        guard let score = gameService?.score else { return Constants.O }
        return score
    }
    
    func appendScore() {
        gameService?.appendScore()
    }
    
    func getTrueIndex() -> Int {
        guard let trueIndex = gameService?.trueIndex else { return Constants.O }
        return trueIndex
    }
    
    func checkAnswer(index: Int) -> [TrueArray] {
        guard let trueArray = gameService?.checkAnswer(index: index) else { return [] }
        return trueArray
    }
    
    func getRoundModel(round: Int) -> RoundModel {
        gameService?.model[round] ?? RoundModel.init(dict: [:])
    }
    
    func setTrueIndex() -> Int {
        gameService?.random()
        guard  let trueIndex = gameService?.trueIndex else { return Constants.O }
        return trueIndex
    }
    
    func getRound() -> Int {
        guard let round = gameService?.round else { return Constants.O }
         return round 
    }
    
    func saveScore() {
        guard let score = gameService?.score else { return }
        userService.setData(value: score, forKey: Constants.score)
    }
    
    func saveScoreOfDay() {
        guard let score = gameService?.score else { return }
        let scoreOfDay = userService.getUserScore(forKey: Constants.scoreOfDay)
        userService.setData(value: scoreOfDay + score, forKey: Constants.scoreOfDay)
    }

    func saveAllScore() {
        guard let score = gameService?.score else { return }
        let allScore = UserService.shared.getUserScore(forKey: Constants.allScore)
        userService.setData(value: allScore + score, forKey: Constants.allScore)
    }
}



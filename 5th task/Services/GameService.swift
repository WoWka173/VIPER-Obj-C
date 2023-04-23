//
//  ServiceGame.swift
//  5th task
//
//  Created by Владимир Курганов on 07.12.2022.
//

import Foundation

// MARK: - EnumTrueArray
enum TrueArray: String {
    case correct = "CorrectButton"
    case wrong = "FalseAnswer"
    case classic = "WordButton"
}

// MARK: - GameServiceProtocol
protocol GameServiceProtocol {
    var model: [RoundModel] { get set }
    var round: Int { get set }
    var score: Int { get set }
    var dictionary: [String: String] { get set }
    var trueIndex: Int { get set }
    func startGame()
    func checkAnswer(index: Int) -> [TrueArray]
    func nextRound()
    func random()
    func appendScore()
}

// MARK: - GameService
final class GameService: GameServiceProtocol {
    // MARK: - Properties
    var dictionary: [String: String] = [
        "EVENT": "СОБЫТИЕ",
        "FOLDER": "ПАПКА",
        "BOARD": "ПЛАТА",
        "ACCESS": "ДОСТУП",
        "PEOPLE": "ЛЮДИ",
        "FAMILY": "СЕМЬЯ",
        "WOMAN": "ЖЕНЩИНА",
        "MAN": "МУЖЧИНА",
        "GIRL": "ДЕВОЧКА",
        "BOY": "МАЛЬЧИК",
        "CHILD": "РЕБЁНОК",
        "FRIEND": "ДРУГ",
        "HUSBAND": "МУЖ",
        "WIFE": "ЖЕНА",
        "NAME": "ИМЯ",
        "HEAD": "ГОЛОВА",
        "FACE": "ЛИЦО",
        "HAND": "РУКА",
        "LIFE": "ЖИЗНЬ",
        "HOUR": "ЧАС",
        "WEEK": "НЕДЕЛЯ",
        "DAY":"ДЕНЬ",
        "NIGHT": "НОЧЬ",
        "MONTH": "МЕСЯЦ",
        "YEAR": "ГОД",
        "TIME": "ВРЕМЯ",
        "WORLD": "МИР",
        "SUN" : "СОЛНЦЕ",
        "ANIMAL": "ЖИВОТНОЕ",
        "TREE": "ДЕРЕВО",
        "WATER": " ВОДА",
        "FOOD": "ЕДА",
        "FIRE": "ОГОНЬ",
        "COUNTRY": "СТРАНА",
        "CITY": "ГОРОД",
        "STREET": "УЛИЦА",
        "WORK": "РАБОТА",
        "SCHOOL": "ШКОЛА",
        "SHOP": "МАГАЗИН",
        "HOUSE": "ДОМ",
        "ROOM": "КОМНАТА",
        "CAR": "МАШИНА",
        "PAPER": "БУМАГА",
        "PEN ": "РУЧКА",
        "DOOR": "ДВЕРЬ",
        "CHAIR": "СТУЛ",
        "TABLE": "СТОЛ",
        "MONEY":"ДЕНЬГИ",
        "WAY": "ПУТЬ",
        "END": "КОНЕЦ",
        "YES": "ДА",
        "NO": "НЕТ",
        "MAYBE": "МОЖЕТ БЫТЬ",
    ]
    
    var model: [RoundModel] = []
    
    var score = 0
    var round = 0
    var trueIndex = 0
    
    // MARK: - Methods
    func startGame() {
        score = 0
        round = 0
        
        var model: [RoundModel] = []
        
        var keys = dictionary.keys.shuffled()
        
        for _ in 0 ... 9 {
            var dict: [String: String] = [:]
            for _ in 0 ... 4 {
                let key = keys.removeLast()
                dict[key] = dictionary[key]
            }
            model.append(RoundModel(dict: dict))
        }
        self.model = model
    }
    
    func random() {
        let number: Int = .random(in: 0...4)
        trueIndex = number
    }
    
    func  checkAnswer(index: Int) -> [TrueArray]  {
        var statusArr: [TrueArray] = []
        
        for i in 0...4 {
            if i == index && index == trueIndex {
                statusArr.append(.correct)
                continue
            }
            if index != trueIndex {
                statusArr = trueArray(correct: trueIndex, wrong: index)
                break
            }
            statusArr.append(.classic)
        }
        return statusArr
    }
    
    private func trueArray(correct: Int , wrong: Int) -> [TrueArray] {
        var statusArr: [TrueArray] = Array(repeating: .classic, count: 5)
        statusArr[correct] = .correct
        statusArr[wrong] = .wrong
        return statusArr
    }
    
    func nextRound() {
        round += 1
    }
    
    func appendScore() {
        score += 1
    }
}


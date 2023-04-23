//
//  EventPresenter.swift
//  5th task
//
//  Created by Владимир Курганов on 08.11.2022.
//

import Foundation
import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let O: Int = 0
    static let maxRound: Int = 10
    static let subTitleColor = UIColor(red: 0.525, green: 0.557, blue: 0.588, alpha: 1)
    static let RubikRegularFont: String = "Rubik-Regular"
    static let RubikFontSize: CGFloat = 16
}

//MARK: - PlayScenePresenterProtocol
protocol PlayScenePresenterProtocol: AnyObject {
    var view: PlaySceneViewProtocol? { get set }
    var router: MainRouterProtocol? { get set }
    var interactor: PlaySceneInteractorProtocol? { get set }
    var customAlert: CustomAlertEndGameProtocol? { get set }
    func viewDidLoad()
    func endGameAlert()
    func popToRoot()
    func setupTitleButton() -> [NSAttributedString]
    func setupSubTitleButton() -> [NSMutableAttributedString]
    func setupQuestion()
    func nextRound()
    func checkAnswer(buttonTag: Int) -> [TrueArray]
    func getTrueIndex() -> Int
    func appendScore()
    func getScore() -> Int
}

//MARK: - PlayScenePresenter
final class PlayScenePresenter {
    
    //MARK: - Properties
    weak var view: PlaySceneViewProtocol?
    var router: MainRouterProtocol?
    var interactor: PlaySceneInteractorProtocol?
    var customAlert: CustomAlertEndGameProtocol?
    private var round: Int = Constants.O
    
    //MARK: - Init
    init(router: MainRouterProtocol, interactor: PlaySceneInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    //MARK: - Methods
    private func getRoundModel() -> RoundModel {
        let roundModel = interactor?.getRoundModel(round: round) ?? RoundModel.init(dict: [:])
        return roundModel
    }
}

extension PlayScenePresenter: PlayScenePresenterProtocol {
    
    //MARK: - Methods
    func viewDidLoad() {
        interactor?.loadData()
        nextRound()
        setupQuestion()
    }
    
    func getScore() -> Int {
        guard let score = interactor?.getScore() else { return Constants.O }
        return score
    }
    
    func appendScore() {
        interactor?.appendScore()
    }
    
    func getTrueIndex() -> Int {
        guard let trueIndex = interactor?.getTrueIndex() else { return  Constants.O }
        return trueIndex
    }
    
    func checkAnswer(buttonTag: Int) -> [TrueArray] {
        guard let trueArray = interactor?.checkAnswer(index: buttonTag) else { return [] }
        return trueArray
    }
    
    func nextRound() {
        guard let round = interactor?.getRound() else { return }
        interactor?.nextRound()
        if round < 10 {
            self.round = round
        } else {
            interactor?.saveScore()
            interactor?.saveScoreOfDay()
            interactor?.saveAllScore()
            router?.showResultView()
        }
    }
    func setupQuestion() {
        let question = [String](getRoundModel().dict.values)
        guard let trueIndex = interactor?.setTrueIndex() else { return }
        let text = question[trueIndex]
        view?.setQuestion(text: text)
    }
    
    func setupTitleButton() -> [NSAttributedString] {
        let title = [String](getRoundModel().dict.keys)
        var arrayAttributedString: [NSAttributedString] = []
        
        title.forEach { title in
            arrayAttributedString.append(NSAttributedString(string: title))
        }
        return arrayAttributedString
    }
    
    func  setupSubTitleButton() -> [NSMutableAttributedString] {
        var arraySubTitle: [NSMutableAttributedString] = []
        let title = [String](getRoundModel().dict.keys)
        let subTitle = [String](getRoundModel().dict.values)
        
        for i in 0 ..< title.count {
            let resultTitle = "\(title[i])\n\(subTitle[i])"
            let attributedString = NSMutableAttributedString(string: resultTitle, attributes: nil)
            let subTitleRange = (attributedString.string as NSString).range(of: "\(subTitle[i])")
            
            attributedString.setAttributes([
                NSAttributedString.Key.foregroundColor: Constants.subTitleColor,
                NSAttributedString.Key.font: UIFont( name: Constants.RubikRegularFont,
                                                     size: Constants.RubikFontSize) as Any
            ], range: subTitleRange)
            arraySubTitle.append(attributedString)
        }
        return arraySubTitle
    }
    
    func endGameAlert() {
        self.customAlert = CustomAlertEndGame()
        view?.presentEndGameAlert()
    }
    
    func popToRoot() {
        router?.popToRoot()
    }
}

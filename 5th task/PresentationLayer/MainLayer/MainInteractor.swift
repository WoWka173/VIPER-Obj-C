//
//  Interactor.swift
//  5th task
//
//  Created by Владимир Курганов on 08.11.2022.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func loadData()
    func getData() -> String?
    func setData(text: String)
    func addPlayerToDB(name: String)
}

final class MainInteractor {
    weak var presenter: MainPresenterProtocol?
    private var apiManager: APIManagerProtocol?
    private var userService: UserServiceProtocol = UserService.shared
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
}

extension MainInteractor: MainInteractorProtocol {
    func loadData() {
        guard let saveDate = userService.getUserName(forKey: "saveDate") else { return }
        
        if saveDate == curretDate() {
            let scoreOfDay = userService.getUserScore(forKey: "scoreOfDay")
            presenter?.setScore(scoreOfDay: scoreOfDay)
        } else {
            userService.setData(value: curretDate(), forKey: "saveDate")
            userService.setData(value: 0, forKey: "scoreOfDay")
        }
    }
    
    private func curretDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let currentDate = dateFormatter.string(from: date)
        return currentDate
    }
    
    func getData() -> String? {
        userService.getUserName(forKey: "Name")
    }
    
    func setData(text: String) {
        userService.setData(value: text, forKey: "Name")
    }
    
    func addPlayerToDB(name: String) {
        let uuid = UUID().uuidString
        let mwUser = MWUserModel(name: name, score: 0, id: uuid )
        apiManager?.setData(user: mwUser) { user in
            print("create new player = \(user)")
        }
    }
}



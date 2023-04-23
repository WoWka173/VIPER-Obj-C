//
//  TableViewInteractor.swift
//  5th task
//
//  Created by Владимир Курганов on 23.11.2022.
//

import Foundation

//MARK: - RatingInteractorProtocol
protocol RatingInteractorProtocol: AnyObject {
    var presenter: RatingPresenterProtocol? { get set }
    func loadData()
    func getData()
    func setData(newName: String)
    func renameDocument(newName: String)
    
}

//MARK: - RatingInteractor
final class RatingInteractor {
    
    //MARK: - Properties
    weak var presenter: RatingPresenterProtocol?
    private var apiManager: APIManagerProtocol?
    private var userService: UserServiceProtocol = UserService.shared
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
}

//MARK: - Extension
extension RatingInteractor: RatingInteractorProtocol {
    
    //MARK: - Methods
    func loadData() {
        let myName = userService.getUserName(forKey: "Name")
        
        apiManager?.getData(collection: "Players") { [weak self] profile in
            guard let player = profile else { return }
            
            var players: [MWUserModel] = []
            player.map { document in
                let documents: MWUserModel = MWUserModel(name: document.get("name") as? String ?? "", score: document.get("score") as? Int ?? 0, id: document.get("id") as? String ?? "")
                
                if myName != documents.name {
                    players.append(documents)
                }
            }
            self?.presenter?.didLoadData(data: players)
        }
    }
    
    func getData() {
        let name = userService.getUserName(forKey: "Name")
        let score = userService.getUserScore(forKey: "allScore")
        self.presenter?.didGetData(name: name ?? "", score: score)
    }
    
    func setData(newName: String) {
        userService.setData(value: newName, forKey: "Name")
        presenter?.name = newName
    }
    
    func renameDocument(newName: String) {
        let curretName = userService.getUserName(forKey: "Name")
        guard let oldName = curretName else { return }
        
        apiManager?.getDocument(docName: oldName, completion: { doc in
            
            let mwUser = MWUserModel(name: newName, score:  doc?.score ?? 0, id: doc?.id ?? "" )
            
            self.apiManager?.setData(user: mwUser, completion: { _ in
                print("set new value", mwUser)
                
                self.apiManager?.deleteDocument(docName: oldName)
                print("old name delete", oldName)
            })
        })
    }
}

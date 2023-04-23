//
//  TableViewPresenter.swift
//  5th task
//
//  Created by Владимир Курганов on 22.11.2022.
//

import Foundation

// MARK: - CustomSection
struct CustomSection {
    var cellsModels: [CellModel]
    var headerOnFill: ((CustomHeader) -> Void)?
    let headerIndetifaer: String = "modelHeader"
}

//MARK: - RatingPresenterProtocol
protocol RatingPresenterProtocol: AnyObject {
    var router: MainRouterProtocol?  { get set }
    var mainModel: [MWUserModel] { get set }
    var view: RatingViewProtocol? { get set }
    var sections: [CustomSection]  { get set }
    var interactor: RatingInteractorProtocol? { get set }
    var customAlert: CustomAlertEnterNameProtocol? { get set }
    var name: String? { get set }
    var score: Int? { get set }
    func viewDidLoad()
    func setupData() -> [CustomSection]
    func didLoadData(data: [MWUserModel])
    func editNameAlert()
    func didGetData(name: String, score: Int)
    func reloadTable()
}

//MARK: - RatingPresenter
final class RatingPresenter {
    
    //MARK: - Properties
    var router: MainRouterProtocol?
    var interactor: RatingInteractorProtocol?
    weak var view: RatingViewProtocol?
    var sections: [CustomSection] = []
    var mainModel: [MWUserModel] = []
    var customAlert: CustomAlertEnterNameProtocol?
    var name: String?
    var score: Int?
    
    //MARK: - Init
    init(router: MainRouterProtocol, interactor: RatingInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension RatingPresenter: RatingPresenterProtocol {
    
    //MARK: - Methods
    func viewDidLoad() {
        interactor?.loadData()
        interactor?.getData()
    }
    
    func editNameAlert() {
        self.customAlert = CustomAlertEnterName()
        customAlert?.textFieldAlert.becomeFirstResponder()
        view?.presentAlert()
    }
    
    func didGetData(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    func didLoadData(data: [MWUserModel]) {
        self.mainModel = data
        self.reloadTable()
        DispatchQueue.main.async {
            self.view?.checkOut()
        }
    }
    
    func reloadTable() {
        var arrayIndexPath: [IndexPath] = []
        
        for numberOfRows in 0...mainModel.count - 1 {
            arrayIndexPath.append(IndexPath(row: numberOfRows, section: 0))
        }
        self.view?.tableViewBuilder.presenter?.sections = self.setupData()
        DispatchQueue.main.async {
            self.view?.tableViewBuilder.tableView?.beginUpdates()
            self.view?.tableViewBuilder.tableView?.insertRows(at: arrayIndexPath, with: .bottom)
            self.view?.tableViewBuilder.tableView?.endUpdates()
        }
    }
    
    func setupData() -> [CustomSection]  {
        
        let headerOnFill: (CustomHeader) -> Void = { header in
            header.namelabel.text = self.name
            header.scoreLabel.text = "\(self.score ?? 0)"
        }
        sections = [CustomSection(cellsModels: [], headerOnFill: headerOnFill)]
        
        self.mainModel.forEach { player in
                
                let onFill: (CustomCell) -> Void = { cell in
                    cell.nameLabel.text = "  \(player.name)"
                    cell.scoreLabel.text = "\(player.score)"
                }
            
                let cellModel = CellModel(onFill: onFill)
                sections[0].cellsModels.append(cellModel)
        }
        return sections
    }
}

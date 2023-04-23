//
//  TableViewBuilder.swift
//  5th task
//
//  Created by Владимир Курганов on 22.11.2022.
//

import UIKit

//MARK: - Constatns
fileprivate enum Constants {
    static let rowHeight: CGFloat = 50
    static let heightForHeader: CGFloat = 50.0
}

//MARK: - Models
struct CellModel {
    var onFill: ((CustomCell) -> Void)?
    let indefication: String = "modelCell"
}

//MARK: - RatingTableBuilder
final class RatingTableBuilder: NSObject {
    
    //MARK: - Properties
    weak var tableView: UITableView?
    weak var presenter: RatingPresenterProtocol?
    var sections: [CustomSection] {
        guard let section = presenter?.sections else { return [] }
        return section
    }
    
    //MARK: - Init
    init(tableView: UITableView, presenter: RatingPresenterProtocol) {
        super.init()
        self.presenter = presenter
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "modelCell")
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "modelHeader")
    }
    
}

//MARK: - Extension
extension RatingTableBuilder: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cellsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].cellsModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.indefication  , for: indexPath) as? CustomCell else { return UITableViewCell() }
        model.onFill?(cell)
        cell.textLabel?.text = "\(indexPath.row + 1)."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = sections[section]
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: model.headerIndetifaer) as? CustomHeader else { return UIView() }
        model.headerOnFill?(header)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.heightForHeader
    }
}

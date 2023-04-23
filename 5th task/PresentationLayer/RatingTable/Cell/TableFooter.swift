//
//  TableViewFooter.swift
//  5th task
//
//  Created by Владимир Курганов on 22.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constatns {
    static let  backgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
}

//MARK: - CustomFooter
final class CustomFooter: UIView {
    
    //MARK: - Properties
    let indicator = UIActivityIndicatorView(style: .medium)
    
    //MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = Constatns.backgroundColor
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setupIndicator() {
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

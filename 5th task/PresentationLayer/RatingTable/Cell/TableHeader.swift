//
//  TableViewHeader.swift
//  5th task
//
//  Created by Владимир Курганов on 22.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let labelConstraits: CGFloat = 20.0
    static let labelFontSize: CGFloat = 20.0
    static let labelNumberOfLines = 0
    static let backgroundColor = UIColor(red: 0.302, green: 0.671, blue: 0.969, alpha: 1)
    static let namelabelText: String = ""
    static let scoreLabelText: String = "0"
    static let scoreLabelRightAnchor: CGFloat = -20.0
}

//MARK: - CustomHeader
final class CustomHeader: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.numberOfLines = Constants.labelNumberOfLines
        namelabel.font = .systemFont(ofSize: Constants.labelFontSize)
        namelabel.textColor = .white
        namelabel.text = Constants.namelabelText
        return namelabel
    }()
    
    var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.numberOfLines = Constants.labelNumberOfLines
        scoreLabel.font = .systemFont(ofSize: Constants.labelFontSize)
        scoreLabel.textColor = .white
        scoreLabel.text = Constants.scoreLabelText
        return scoreLabel
    }()
    
    //MARK: - Init
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Constants.backgroundColor
        setupNameLabel()
        setupScoreLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupNameLabel() {
        addSubview(namelabel)
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namelabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            namelabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.labelConstraits)
        ])
    }
    
    private func setupScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            scoreLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Constants.scoreLabelRightAnchor)
        ])
    }
}



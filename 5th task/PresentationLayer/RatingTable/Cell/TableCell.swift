//
//  TableViewCell.swift
//  5th task
//
//  Created by Владимир Курганов on 22.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let labelFontSize: CGFloat = 20.0
    static let labelNumberOfLines = 0
    static let labelTopAnchor: CGFloat = 30.0
    static let constraint: CGFloat = 100.0
    static let backgroundColor = UIColor(red: 0.973, green: 1, blue: 0.894, alpha: 1)
    static let nameLabelLeftAnchor: CGFloat = 30
    static let scoreLabelRightAnchor: CGFloat = -20
}

//MARK: - CustomCell
final class CustomCell: UITableViewCell {
    
    //MARK: - Properties
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = Constants.labelNumberOfLines
        nameLabel.font = .systemFont(ofSize: Constants.labelFontSize)
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    lazy var scoreLabel: UILabel = {
        let secondNameLabel = UILabel()
        secondNameLabel.numberOfLines = Constants.labelNumberOfLines
        secondNameLabel.font = .systemFont(ofSize: Constants.labelFontSize)
        secondNameLabel.textColor = .black
        return secondNameLabel
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        selectionStyle = .none
        backgroundColor = Constants.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        scoreLabel.text = nil
    }
    
    private func setupCell() {
        setupNameLabel()
        setupScoreLabel()
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.nameLabelLeftAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
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

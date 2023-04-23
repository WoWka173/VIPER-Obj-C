//
//  CustomProgressBar.swift
//  5th task
//
//  Created by Владимир Курганов on 02.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let scoreLabelFontSize: CGFloat = 26
    static let O: CGFloat = 0
    static let backgroundMaskLineWidth: CGFloat = 20
    static let minusOne: CGFloat = -1
    static let rectInsetBy: CGFloat = 5
    static let progressCoefficient: CGFloat = 0.02
    static let transformCoefficient: CGFloat = 90
    static let pi: CGFloat = 180
    static let lowProgressColor = UIColor(red: 1, green: 0.15, blue: 0.15, alpha: 1).cgColor
    static let mediumProgressColor = UIColor(red: 1, green: 0.902, blue: 0.65, alpha: 1).cgColor
    static let highProgressColor = UIColor(red: 0.863, green: 1, blue: 0.576, alpha: 1).cgColor
    static let scoreLabelText = "0/50"
    static let scoreLabelFont = "Rubik-Medium"
}

//MARK: - CustomProgressBar
final class CircularProgressBar: UIView {
    
    //MARK: - Properties
    private let progressLayer = CAShapeLayer()
    private let backgroundMask = CAShapeLayer()
    
    var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.text = Constants.scoreLabelText
        scoreLabel.font = UIFont(name: Constants.scoreLabelFont, size: Constants.scoreLabelFontSize)
        scoreLabel.textAlignment = .center
        return scoreLabel
    }()
    
    private var progress: CGFloat = Constants.O {
        didSet { setNeedsDisplay() }
    }
    
    //MARK: - Init
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        setupScoreLable()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    //MARK: - Methods
    private func setupLayers() {
        backgroundMask.lineWidth = Constants.backgroundMaskLineWidth
        backgroundMask.fillColor = UIColor.white.cgColor
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask
        
        progressLayer.lineWidth = Constants.backgroundMaskLineWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(Constants.transformCoefficient * Double.pi / Constants.pi), Constants.O, Constants.O, Constants.minusOne)
    }
    
    override func draw(_ rect: CGRect) {
        
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: Constants.rectInsetBy , dy: Constants.rectInsetBy))
        backgroundMask.path = circlePath.cgPath
        
        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = Constants.O
        progressLayer.strokeEnd = progress
        
    }
    
    func setProgress(scoreOfDay: Int) {
        var progress: CGFloat = CGFloat(scoreOfDay) * Constants.progressCoefficient {
            didSet { setNeedsDisplay() }
        }
        self.progress = progress
    }
    
    func setScoreLabel(scoreOfDay: Int) {
        scoreLabel.text = "\(scoreOfDay)/50"
    }
    
    func setColorProgress(scoreOfDay: Int) {
        switch scoreOfDay {
        case 0...20:
            progressLayer.strokeColor = Constants.lowProgressColor
        case 20...35:
            progressLayer.strokeColor = Constants.mediumProgressColor
        case 35...50:
            progressLayer.strokeColor = Constants.highProgressColor
        default:
            break
        }
    }
    
    private func setupScoreLable() {
        addSubview(scoreLabel)
        scoreLabel.layer.transform = CATransform3DMakeRotation(CGFloat(-Constants.transformCoefficient * Double.pi / Constants.pi ), Constants.O, Constants.O, Constants.minusOne)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}


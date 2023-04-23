//
//  PlainProgressBar.swift
//  5th task
//
//  Created by Владимир Курганов on 03.11.2022.
//

import UIKit

//MARK: - Constants
fileprivate enum Constants {
    static let cornerRarius: CGFloat = 16
    static let O: CGFloat = 0
    static let increaseprogress: CGFloat = 0.1
    static let backgroundMaskColor = UIColor(red: 0.808, green: 0.831, blue: 0.855, alpha: 1).cgColor
    static let progressLayerColor = UIColor(red: 0.302, green: 0.671, blue: 0.969, alpha: 1).cgColor
}

//MARK: - CustomProgressBar
final class PlainProgressBar: UIView {
    
    //MARK: - Properties
    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()
    
    var progress: CGFloat = Constants.O {
        didSet { setNeedsDisplay() }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    //MARK: - Methods
    private func setupLayers() {
        layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.cornerRarius).cgPath
        layer.mask = backgroundMask
        layer.backgroundColor = Constants.backgroundMaskColor
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = Constants.progressLayerColor
    }
    
    func setProgress() {
        self.progress += Constants.increaseprogress
    }
    
    func resetProgress() {
        self.progress = Constants.O
    }
}

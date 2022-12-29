//
//  Extensions.swift
//  HomeWork12
//
//  Created by Игорь Николаев on 29.12.2022.
//

import UIKit

//MARK: - CALayer

extension CALayer {

    func pauseAnimation() {
        if isPaused() == false {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }

    func resumeAnimation() {
        if isPaused() {
            let pausedTime = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            beginTime = timeSincePause
        }
    }

    func isPaused() -> Bool {
        return speed == 0
    }
}

//MARK: - UIButton

extension UIButton {

    func shadowButton() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.42).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
}

//MARK: - UILabel

extension UILabel {

    func shadowLabel() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.42).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
}

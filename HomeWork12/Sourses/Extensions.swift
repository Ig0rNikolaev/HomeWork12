//
//  Extensions.swift
//  HomeWork12
//
//  Created by Игорь Николаев on 29.12.2022.
//

import UIKit

//MARK: - UIButton

extension UIButton {

    func shadowButton() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 5).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
}

//MARK: - UILabel

extension UILabel {

    func shadowLabel() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 5).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 10.0
        self.layer.masksToBounds = false
    }
}

extension Int {
    var degreesToRadians:CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

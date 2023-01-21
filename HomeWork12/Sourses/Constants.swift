//
//  Constants.swift
//  HomeWork12
//
//  Created by Игорь Николаев on 29.12.2022.
//

import UIKit

    enum Constant {

    // Strings
    static let labelTimerText = "00:10"
    static let labelWork = "WORK TIME"
    static let labelRest = "REST TIME"

    // Colors

    static let colorWhite = UIColor.white
    static let colorBlue = UIColor.systemCyan
    static let colorGreen = UIColor.systemTeal
    static let colorGrey6 = UIColor.systemGray6

    //Image
    static let backgroundImageCircle = UIImage(named: "circle")
    static let buttonPlay = UIImage(systemName: "play.fill")
    static let buttonPause = UIImage(systemName: "pause.fill")
    static let buttonImageSize = CATransform3DMakeScale(3, 3, 3)
    static let  backgroundImageCircleSize = CATransform3DMakeScale(0.2, 0.2, 0.2)

    // Others
    static let labelTimerFont = UIFont(name: "Futura", size: 65.0)
    static let labelPomodoroFont = UIFont(name: "Futura", size: 55.0)
}

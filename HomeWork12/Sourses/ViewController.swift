//
//  ViewController.swift
//  HomeWork12
//
//  Created by Игорь Николаев on 26.12.2022.
//

import UIKit

fileprivate enum Constant {

    // Strings
    static let labelTimerText = "00:00"
    static let labelPomodoroText = "POMODORO"

    // Colors
    static let colorBlack = UIColor.black

    //Image
    static let background = UIImage(named: "circle")
    static let play = UIImage(named: "play")
    static let pause = UIImage(named: "pause")
    static let buttonImageSize = CATransform3DMakeScale(3, 3, 3)

    // Others
    static let labelTimerFont = UIFont(name: "Futura", size: 65.0)
    static let labelPomodoroFont = UIFont(name: "Times New Roman", size: 55.0)
}

class ViewController: UIViewController {


    //MARK: - UI Elements

    private lazy var labelPomodoro: UILabel = {
        let labelPomodoro = UILabel()
        labelPomodoro.text = Constant.labelPomodoroText
        labelPomodoro.textColor = Constant.colorBlack
        labelPomodoro.font = Constant.labelPomodoroFont
        labelPomodoro.textAlignment = .center
        labelPomodoro.translatesAutoresizingMaskIntoConstraints = false
        return labelPomodoro
    }()

    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: Constant.background)
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()

    private lazy var labelTimer: UILabel = {
        let labelTimer = UILabel()
        labelTimer.text = Constant.labelTimerText
        labelTimer.textColor = Constant.colorBlack
        labelTimer.font = Constant.labelTimerFont
        labelTimer.textAlignment = .center
        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        return labelTimer
    }()

    private lazy var buttonLogin: UIButton = {
        let buttonLogin = UIButton(configuration: .plain(), primaryAction: nil)
        buttonLogin.configuration?.image = Constant.play
        buttonLogin.imageView?.layer.transform = Constant.buttonImageSize
        buttonLogin.imageView?.contentMode = .scaleAspectFit
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        // buttonLogin.configuration?.baseBackgroundColor = .yellow
        //buttonLogin.shadowButton()
        return buttonLogin
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

//MARK: - Setups


    private func setupView() {
        view.backgroundColor = .white

    }

    private func setupHierarchy() {
        view.addSubview(labelPomodoro)
        view.addSubview(labelTimer)
        view.addSubview(backgroundImage)
        view.addSubview(buttonLogin)

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            labelPomodoro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPomodoro.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),

            labelTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTimer.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),

            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22),

            buttonLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonLogin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150),
            buttonLogin.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            buttonLogin.heightAnchor.constraint(equalToConstant: 100)

            ])
    }

//MARK: - Actions

}


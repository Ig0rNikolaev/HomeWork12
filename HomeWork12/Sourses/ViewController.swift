//
//  ViewController.swift
//  HomeWork12
//
//  Created by Игорь Николаев on 26.12.2022.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Timer

    var timer = Timer()
    var isWorkTime = true
    var isStarted = false
    var timeWork = 10
    var timeRest = 6
    
    
    //MARK: - UI Elements
    
    private lazy var labelPomodoro: UILabel = {
        let labelPomodoro = UILabel()
        labelPomodoro.shadowLabel()
        labelPomodoro.text = Constant.labelPomodoroText
        labelPomodoro.textColor = Constant.colorWhite
        labelPomodoro.font = Constant.labelPomodoroFont
        labelPomodoro.textAlignment = .center
        labelPomodoro.translatesAutoresizingMaskIntoConstraints = false
        return labelPomodoro
    }()
    
    private lazy var backgroundImageCircle: UIImageView = {
        let backgroundImageCircle = UIImageView(image: Constant.backgroundImageCircle)
        backgroundImageCircle.contentMode = .center
        backgroundImageCircle.transform3D = Constant.backgroundImageCircleSize
        backgroundImageCircle.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageCircle
    }()
    
    private lazy var labelTimer: UILabel = {
        let labelTimer = UILabel()
        labelTimer.shadowLabel()
        labelTimer.text = Constant.labelTimerText
        labelTimer.textColor = Constant.colorWhite
        labelTimer.font = Constant.labelTimerFont
        labelTimer.textAlignment = .center
        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        return labelTimer
    }()
    
    private lazy var buttonPlay: UIButton = {
        let buttonPlay = UIButton(configuration: .plain(), primaryAction: nil)
        buttonPlay.shadowButton()
        buttonPlay.configuration?.image = Constant.buttonPlay
        buttonPlay.tintColor = Constant.colorWhite
        buttonPlay.imageView?.layer.transform = Constant.buttonImageSize
        buttonPlay.imageView?.contentMode = .scaleAspectFit
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.addTarget(self, action: #selector(startButton), for: .touchUpInside)
        return buttonPlay
    }()

    //MARK: - LifeCycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    //MARK: - Actions
    
    @objc func startTimer() {
        if isWorkTime {
            timeWork -= 1
            labelPomodoro.text = Constant.labelWork
            labelTimer.textColor = Constant.colorBlue
            labelPomodoro.textColor = Constant.colorBlue
            buttonPlay.tintColor = Constant.colorBlue
            labelTimer.text = timeFormat(timeWork)
            if timeWork == 0 {
                timeWork += 11
                isWorkTime = false
            }
        } else {
            timeRest -= 1
            labelPomodoro.text = Constant.labelRest
            labelTimer.textColor = Constant.colorGreen
            labelPomodoro.textColor = Constant.colorGreen
            buttonPlay.tintColor = Constant.colorGreen
            labelTimer.text = timeFormat(timeRest)
            if timeRest == 0 {
                timeRest += 6
                isWorkTime = true
            }
        }
    }

    @objc func startButton() {
        if !isStarted {
            settingTimer()
            isStarted = true
            buttonPlay.setImage(Constant.buttonPause, for: .normal)
            labelPomodoro.text = Constant.labelWork
            labelTimer.textColor = Constant.colorBlue
            labelPomodoro.textColor = Constant.colorBlue
            buttonPlay.tintColor = Constant.colorBlue
        } else {
            timer.invalidate()
            isStarted = false
            buttonPlay.setImage(Constant.buttonPlay, for: .normal)
            labelPomodoro.text = Constant.labelWork
            labelTimer.textColor = Constant.colorBlue
            labelPomodoro.textColor = Constant.colorBlue
            buttonPlay.tintColor = Constant.colorBlue
        }
    }
    
    //MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = Constant.colorGrey6
    }

    func settingTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }

    func timeFormat(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundImageCircle)
        view.addSubview(labelPomodoro)
        view.addSubview(labelTimer)
        view.addSubview(buttonPlay)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            labelPomodoro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPomodoro.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            labelTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTimer.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            
            backgroundImageCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            buttonPlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonPlay.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150),
            buttonPlay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            buttonPlay.topAnchor.constraint(equalTo: backgroundImageCircle.bottomAnchor, constant: 170),
            buttonPlay.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}















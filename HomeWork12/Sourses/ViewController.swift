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
    var isAnimationStarted = false
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

    private lazy var backProgressLayer: CAShapeLayer = {
        let backProgressLayer = CAShapeLayer()
        backProgressLayer.path = UIBezierPath(arcCenter: CGPointMake(view.frame.midX, view.frame.midY),
                                              radius: 130,
                                              startAngle: -90.degreesToRadians,
                                              endAngle: 270.degreesToRadians,
                                              clockwise: true).cgPath
        backProgressLayer.strokeColor = UIColor.white.cgColor
        backProgressLayer.fillColor = UIColor.clear.cgColor
        backProgressLayer.lineWidth = 15
        return backProgressLayer
    }()

    private lazy var frontProgressLayer: CAShapeLayer = {
        let frontProgressLayer = CAShapeLayer()
        frontProgressLayer.path = UIBezierPath(arcCenter: CGPointMake(view.frame.midX, view.frame.midY),
                                              radius: 130,
                                              startAngle: -90.degreesToRadians,
                                              endAngle: 270.degreesToRadians,
                                              clockwise: true).cgPath
        frontProgressLayer.fillColor = UIColor.clear.cgColor
        frontProgressLayer.strokeColor = UIColor.white.cgColor
        frontProgressLayer.lineWidth = 15
        return frontProgressLayer
    }()

    //MARK: - LifeCycle

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
            frontProgressLayer.strokeColor = UIColor.systemCyan.cgColor
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
            frontProgressLayer.strokeColor = UIColor.systemTeal.cgColor
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
        } else {
            timer.invalidate()
            isStarted = false
            buttonPlay.setImage(Constant.buttonPlay, for: .normal)
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
        view.addSubview(labelPomodoro)
        view.addSubview(labelTimer)
        view.addSubview(buttonPlay)
        view.layer.addSublayer(backProgressLayer)
        view.layer.addSublayer(frontProgressLayer)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            labelPomodoro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPomodoro.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            labelTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTimer.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),

            buttonPlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonPlay.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150),
            buttonPlay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            buttonPlay.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}















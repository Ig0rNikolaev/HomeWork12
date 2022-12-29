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
    static let labelWork = "WORK TIME"
    static let labelRest = "REST TIME"

    // Colors
    static let labelPomodoroColor = UIColor.white
    static let colorWhite = UIColor.white
    static let colorBlue = UIColor.systemCyan
    static let colorGreen = UIColor.systemTeal
    static let colorGrey6 = UIColor.systemGray6

    //Image
    static let background = UIImage(named: "circle")
    static let play = UIImage(systemName: "play.fill")
    static let pause = UIImage(systemName: "pause.fill")
    static let buttonImageSize = CATransform3DMakeScale(3, 3, 3)

    // Others
    static let labelTimerFont = UIFont(name: "Futura", size: 65.0)
    static let labelPomodoroFont = UIFont(name: "Futura", size: 55.0)
}

class ViewController: UIViewController {

    //MARK: - UI Elements

    private lazy var labelPomodoro: UILabel = {
        let labelPomodoro = UILabel()
        labelPomodoro.shadowLabel()
        labelPomodoro.text = Constant.labelPomodoroText
        labelPomodoro.textColor = Constant.labelPomodoroColor
        labelPomodoro.font = Constant.labelPomodoroFont
        labelPomodoro.textAlignment = .center
        labelPomodoro.translatesAutoresizingMaskIntoConstraints = false
        return labelPomodoro
    }()

    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: Constant.background)
        backgroundImage.contentMode = .center
        backgroundImage.transform3D = CATransform3DMakeScale(0.2, 0.2, 0.2)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
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
        buttonPlay.configuration?.image = Constant.play
        buttonPlay.tintColor = Constant.colorWhite
        buttonPlay.imageView?.layer.transform = Constant.buttonImageSize
        buttonPlay.imageView?.contentMode = .scaleAspectFit
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.addTarget(self, action: #selector(startButton), for: .touchUpInside)
        return buttonPlay
    }()

    private lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        let center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        let endAngle = (CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circle = UIBezierPath(arcCenter: center,
                                  radius: 128,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: false)
        shapeLayer.path = circle.cgPath
        shapeLayer.lineWidth = 17
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = UIColor.systemGray3.cgColor
        return shapeLayer
    }()

    //MARK: - Timer

    var timer = Timer()
    var isWorkTime = true
    var isStarted = false
    var timerDurationWork = 11
    var timerDurationvarRest = 6

    //MARK: - LifeCycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.addSublayer(shapeLayer)
        animation()
        animationTwo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    //MARK: - Setups

    private func setupView() {
        view.backgroundColor = Constant.colorGrey6
}

    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(labelPomodoro)
        view.addSubview(labelTimer)
        view.layer.addSublayer(shapeLayer)
        view.addSubview(buttonPlay)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            labelPomodoro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPomodoro.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),

            labelTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTimer.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),

            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),


            buttonPlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonPlay.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150),
            buttonPlay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            buttonPlay.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 170),
            buttonPlay.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    //MARK: - Actions

    @objc func startTimer() {
        workTimer()
        restTimer()
    }

    @objc func startButton() {
        if isStarted == false {
            shapeLayer.resumeAnimation()
            buttonPlay.configuration?.image = Constant.pause
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(startTimer),
                                         userInfo: nil,
                                         repeats: true)
            isStarted = true
        } else {
            shapeLayer.pauseAnimation()
            buttonPlay.configuration?.image = Constant.play
            timer.invalidate()
            isStarted = false
        }
    }

    private func workTimer() {
        if isWorkTime == true {
            timerDurationWork -= 1
            labelPomodoro.text = Constant.labelWork
            labelTimer.textColor = Constant.colorBlue
            labelPomodoro.textColor = Constant.colorBlue
            buttonPlay.tintColor = Constant.colorBlue
            let minutes = timerDurationWork / 60
            let seconds = timerDurationWork % 60
            labelTimer.text = String(format: "%02d:%02d", minutes, seconds)
            if timerDurationWork == 0 {
                timerDurationWork += 11
                isWorkTime = false
            }
        }
    }

    private func restTimer() {
        if isWorkTime == false {
            timerDurationvarRest -= 1
            labelPomodoro.text = Constant.labelRest
            labelTimer.textColor = Constant.colorGreen
            labelPomodoro.textColor = Constant.colorGreen
            buttonPlay.tintColor = Constant.colorGreen
            let minutes = timerDurationvarRest / 60
            let seconds = timerDurationvarRest % 60
            labelTimer.text = String(format: "%02d:%02d", minutes, seconds)
            if timerDurationvarRest == 0 {
                timerDurationvarRest += 6
                isWorkTime = true
            }
        }
    }

    func baseAnimation() {
        let baseAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.toValue = 0
        baseAnimation.duration = CFTimeInterval(timerDurationWork)
        baseAnimation.speed = 1
        baseAnimation.fillMode = CAMediaTimingFillMode.forwards
        baseAnimation.isRemovedOnCompletion = true
        shapeLayer.add(baseAnimation, forKey: "baseAnimation")
    }

    func baseAnimationTwo() {
        let baseAnimationTwo  = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimationTwo.toValue = 0
        baseAnimationTwo.duration = CFTimeInterval(timerDurationvarRest)
        baseAnimationTwo.speed = 1
        baseAnimationTwo.fillMode = CAMediaTimingFillMode.forwards
        baseAnimationTwo.isRemovedOnCompletion = true
        shapeLayer.add(baseAnimationTwo, forKey: "baseAnimationTwo")
    }

    func animation() {
        if timerDurationWork == 10 {
            baseAnimation()
        }
    }

    func animationTwo() {
        if timerDurationvarRest == 5 {
            baseAnimationTwo()
        }
    }
}















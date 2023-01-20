//
//  ViewController.swift
//  HomeWork12
//
//  Created by Игорь Николаев on 26.12.2022.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    //MARK: - Timer

    private let shapeLayer = CAShapeLayer()
    private let backProgressLayer = CAShapeLayer()
    private var frontProgressLayer = CAShapeLayer()
    private var timer = Timer()
    private var timeWork = 10
    private var timeRest = 5
    private var time = 10
    private var duration = 1000
    private var isWorkTime = false
    private var isStarted = false
    private var isAnimationStarted = true

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
        buttonPlay.tintColor = .green
        buttonPlay.imageView?.layer.transform = Constant.buttonImageSize
        buttonPlay.imageView?.contentMode = .scaleAspectFit
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.addTarget(self, action: #selector(startButton), for: .touchUpInside)
        return buttonPlay
    }()

    private lazy var progressBarContainer: UIView = {
        let progressContainer = UIView()
        progressContainer.backgroundColor = .clear
        progressContainer.translatesAutoresizingMaskIntoConstraints = false
        return progressContainer
    }()

    private lazy var shapeView: UIView = {
        let ellipse = UIView(frame: CGRect(x: 0, y: 0, width: 305, height: 305))
        return ellipse
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        creatingCircularPath()
        setupColors()
    }

    //MARK: - Actions

    @objc func startTimer() {
        if duration > 0 {
            duration -= 1
            return
        }
        duration = 1000
        time -= 1
        labelTimer.text = timeFormat()
        if time < 1 && isAnimationStarted == true {
            time = timeRest
            labelTimer.text = "\(time)"
            isAnimationStarted = false
            setupColors()
            duration = 1000
            creatingCircularPath()
            progressAnimation(duration: TimeInterval(time))
        } else if time < 1 && isAnimationStarted == false {
            time = timeWork
            labelTimer.text = "\(time)"
            isAnimationStarted = true
            setupColors()
            duration = 1000
            creatingCircularPath()
            progressAnimation(duration: TimeInterval(time))
        }
        labelTimer.text = timeFormat()
    }

    @objc func startButton() {
        if !isStarted {
            settingTimer()
            labelTimer.text = timeFormat()
            isStarted = true
            buttonPlay.setImage(Constant.buttonPause, for: .normal)
            buttonPlay.tintColor = .systemRed
            progressAnimation(duration: TimeInterval(time))
        } else {
            timer.invalidate()
            let presentation = frontProgressLayer.presentation()
            frontProgressLayer.strokeEnd = presentation?.strokeEnd ?? 0
            frontProgressLayer.removeAnimation(forKey: "animation")
            buttonPlay.setImage(Constant.buttonPlay, for: .normal)
            buttonPlay.tintColor = .green
            isStarted = false
        }
    }
    //MARK: - Setups

    private func setupView() {
        view.backgroundColor = .darkGray
    }

    func settingTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }

    func timeFormat() -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func isStartedCheck() {
        if isStarted {
            progressAnimation(duration: TimeInterval(time))
        }
    }

    func creatingCircularPath() {
        let center: CGPoint = CGPoint(x: shapeView.frame.size.width / 2.0, y: shapeView.frame.size.height / 2.0)
        let circularPath = UIBezierPath(arcCenter: center, radius: 130, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true)

        backProgressLayer.path = circularPath.cgPath
        backProgressLayer.fillColor = UIColor.clear.cgColor
        backProgressLayer.lineCap = .butt
        backProgressLayer.lineWidth = 15
        backProgressLayer.strokeEnd = 1
        shapeView.layer.addSublayer(backProgressLayer)

        frontProgressLayer.fillMode = CAMediaTimingFillMode.forwards
        frontProgressLayer.removeAllAnimations()
        frontProgressLayer.path = circularPath.cgPath
        frontProgressLayer.fillColor = UIColor.clear.cgColor
        frontProgressLayer.lineCap = .butt
        frontProgressLayer.lineWidth = 15
        frontProgressLayer.strokeEnd = 0
        shapeView.layer.addSublayer(frontProgressLayer)
    }

    func progressAnimation(duration: TimeInterval) {
        let animationProgressLayer = CABasicAnimation(keyPath: "strokeEnd")
        animationProgressLayer.duration = duration
        animationProgressLayer.toValue = 1
        animationProgressLayer.fillMode = CAMediaTimingFillMode.forwards
        animationProgressLayer.isRemovedOnCompletion = false
        frontProgressLayer.add(animationProgressLayer, forKey: "animation")
    }

    func setupColors() {
        if isAnimationStarted {
            labelPomodoro.text = Constant.labelWork
            labelTimer.textColor = Constant.colorBlue
            labelPomodoro.textColor = Constant.colorBlue
            frontProgressLayer.strokeColor = UIColor.systemCyan.cgColor
            backProgressLayer.strokeColor = UIColor.white.cgColor
        } else {
            labelPomodoro.text = Constant.labelRest
            labelTimer.textColor = Constant.colorGreen
            labelPomodoro.textColor = Constant.colorGreen
            frontProgressLayer.strokeColor = UIColor.systemTeal.cgColor
            backProgressLayer.strokeColor = UIColor.white.cgColor
        }
    }

    private func setupHierarchy() {
        view.addSubview(labelPomodoro)
        view.addSubview(labelTimer)
        view.addSubview(buttonPlay)
        view.addSubview(progressBarContainer)
        progressBarContainer.addSubview(shapeView)
        shapeView.addSubview(labelTimer)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            progressBarContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBarContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            progressBarContainer.heightAnchor.constraint(equalToConstant: 305),
            progressBarContainer.widthAnchor.constraint(equalToConstant: 305),

            labelPomodoro.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPomodoro.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250),
            
            labelTimer.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            labelTimer.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor),

            buttonPlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            buttonPlay.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150),
            buttonPlay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            buttonPlay.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}












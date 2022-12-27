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
    static let play = UIImage(named: "playOne")
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

    private lazy var buttonPlay: UIButton = {
        let buttonPlay = UIButton(configuration: .plain(), primaryAction: nil)
        buttonPlay.configuration?.image = Constant.play
        buttonPlay.imageView?.layer.transform = Constant.buttonImageSize
        buttonPlay.imageView?.contentMode = .scaleAspectFit
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.addTarget(self, action: #selector(startButton), for: .touchUpInside)
        // buttonPlay.configuration?.baseBackgroundColor = .yellow
        //buttonPlay.shadowButton()
        return buttonPlay
    }()

    //MARK: - Timer

    var timer = Timer()
    var isWorkTime = true
    var isStarted = false
    var timerDurationWork = 11
    var timerDurationvarRest = 6

    //MARK: - Animations

    let shapeLayer = CAShapeLayer()

    func animationProgressBar() {
        let center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        let endAngle = (CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle

        let circle = UIBezierPath(arcCenter: center,
                                  radius: 120,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: false)

        shapeLayer.path = circle.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        view.layer.addSublayer(shapeLayer)
    }

    func baseAnimation() {
        let baseAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.toValue = 0
        baseAnimation.duration = CFTimeInterval(timerDurationWork)
        baseAnimation.fillMode = CAMediaTimingFillMode.forwards
        baseAnimation.isRemovedOnCompletion = true
        shapeLayer.add(baseAnimation, forKey: "baseAnimation")
    }

    //MARK: - LifeCycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationProgressBar()
    }

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
        view.addSubview(buttonPlay)
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

            buttonPlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonPlay.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150),
            buttonPlay.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            buttonPlay.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    //MARK: - Actions

    @objc func startTimer() {
        workTimer()
        restTimer()
    }

    private func workTimer() {
        if isWorkTime == true {
            timerDurationWork -= 1
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
            let minutes = timerDurationvarRest / 60
            let seconds = timerDurationvarRest % 60
            labelTimer.text = String(format: "%02d:%02d", minutes, seconds)
            if timerDurationvarRest == 0 {
                timerDurationvarRest += 6
                isWorkTime = true
            }
        }
    }

    @objc func startButton() {
        if isStarted == false {
            baseAnimation()
            buttonPlay.configuration?.image = Constant.pause
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(startTimer),
                                         userInfo: nil,
                                         repeats: true)
            isStarted = true
        } else { buttonPlay.configuration?.image = Constant.play
            timer.invalidate()
            isStarted = false
        }
    }
}








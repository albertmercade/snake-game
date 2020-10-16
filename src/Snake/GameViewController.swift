//
//  GameViewController.swift
//  Snake
//
//  Created by Albert Mercadé on 18/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    
    
    var game: SnakeGame!
    
    var firstSwipe: Bool = true
    var paused: Bool!
    
    var score: Int = 1 {
        didSet {
            currentScore.text = String(score)
        }
    }
    var highScore: Int!
    var isNewHighScore: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup swipe gesture recognizers
        setupSwipeRecognizers()
        setupNotificationObservers()
        setupPauseButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createGame()
    }
    
    // MARK: Setup Functions
    func createGame() {
        let viewWidth = mainStackView.frame.size.width
        game = SnakeGame(viewWidth: viewWidth)
        mainStackView.addArrangedSubview(game.board)
    }
    
    func setupSwipeRecognizers() {
        // Swipe right gesture
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        // Swipe right gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        // Swipe up gesture
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        // Swipe down gesture
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func setupPauseButton() {
        paused = false
        pauseButton.isHidden = true
        pauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: UIControl.State.normal)
        
        let btnWidth = UIScreen.main.bounds.width / 15
        pauseButton.widthAnchor.constraint(equalToConstant: btnWidth).isActive = true
    }
    
    func setupNotificationObservers() {
        // Setup notification observer for app interruption
        NotificationCenter.default.addObserver(self, selector: #selector(appResigned), name: UIApplication.willResignActiveNotification, object: nil)
        
        // Setup notification observer for score update
        NotificationCenter.default.addObserver(self, selector: #selector(updateScoreLabel), name: NSNotification.Name("updatedScore"), object: nil)
        
        // Setup notification observer for game over
        NotificationCenter.default.addObserver(self, selector: #selector(gameOver), name: NSNotification.Name("gameOver"), object: nil)
    }
    
    // MARK: Gesture Handling Function
    @objc func handleSwipe(swipe: UISwipeGestureRecognizer) {
        
        if !paused {
            switch swipe.direction {
                case .right:
                    if(game.dir != .left) {
                        game.dir = .right
                    }
                case .left:
                    if(game.dir != .right) {
                        game.dir = .left
                    }
                case .up:
                    if(game.dir != .down) {
                        game.dir = .up
                    }
                case .down:
                    if(game.dir != .up) {
                        game.dir = .down
                    }
                default:
                    fatalError("Unknown swipe direction.")
            }
        }
        
        if firstSwipe {
            game.startTimer()
            firstSwipe = false
            pauseButton.isHidden = false
        }
    }
    
    // MARK: Notification Handlers
    @objc func appResigned() {
        if !firstSwipe && !paused {
            performSegue(withIdentifier: "showPauseVC", sender: self)
        }
    }
    
    @objc func updateScoreLabel(_ notification: NSNotification) {
        if let score = notification.userInfo?["score"] as? Int {
            self.score = score
            currentScore.text = "\(score)"
        }
    }
    
    @objc func gameOver() {
        let currentHighScore = UserDefaults.standard.integer(forKey: "highScore")
        
        pauseButton.isHidden = true
        
        highScore = currentHighScore
        isNewHighScore = false
        
        if score > highScore {
            UserDefaults.standard.set(score, forKey: "highScore")
            highScore = score
            isNewHighScore = true
        }
        
        performSegue(withIdentifier: "showPopUpVC", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPauseVC" {
            paused = true
            game.stopTimer()
            pauseButton.isHidden = true
        }
        if segue.identifier == "showPopUpVC" {
            let popUpVC = segue.destination as! PopUpViewController
            popUpVC.score = score
            popUpVC.hScore = highScore
            popUpVC.isNewHighScore = isNewHighScore
        }
    }
    
    @IBAction func unwindFromPopUpToGameView(_ segue: UIStoryboardSegue) {
        score = 0
        firstSwipe = true
        
        game.board.removeFromSuperview()
        
        let viewWidth = mainStackView.frame.size.width
        game = SnakeGame(viewWidth: viewWidth)
        mainStackView.addArrangedSubview(game.board)
        setupPauseButton()
    }
    
    @IBAction func unwindFromPauseToGameView(_ segue: UIStoryboardSegue) {
        paused = false
        game.startTimer()
        pauseButton.isHidden = false
    }
}

//
//  PopUpViewController.swift
//  Snake
//
//  Created by Albert Mercadé on 20/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var lastScore: UILabel!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var stackViewButtons: UIStackView!
    
    var score: Int!
    var hScore: Int!
    var isNewHighScore: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        popUpView.layer.cornerRadius = 20
        
        playAgainButton.layer.cornerRadius = 5
        homeButton.layer.cornerRadius = 5
        
        lastScore.text = String(score)
        highScore.text = String(hScore)
        if isNewHighScore {
            highScoreLabel.text = "New High Score:"
            highScoreLabel.textColor = .red
            highScore.textColor = .red
        }
    }
    
    // MARK: Actions
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToGameView", sender: self)
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToInitialView", sender: self)
    }
}

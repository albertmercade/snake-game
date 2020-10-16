//
//  InitialViewController.swift
//  Snake
//
//  Created by Albert Mercadé on 18/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
        setupInitialView()
    }

    
    // MARK: Private Functions
    private func setupInitialView() {
        // Set button size relative to screen
        let screenWidth = UIScreen.main.bounds.size.width
        playButton.widthAnchor.constraint(equalToConstant: screenWidth/6).isActive = true

        
        highScoreLabel.text = String(UserDefaults.standard.integer(forKey: "highScore"))
    }
    
    // MARK: Actions
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ShowGameView", sender: self)
    }
    
    @IBAction func unwindFromPopUpToInitialView(_ segue: UIStoryboardSegue) {
        highScoreLabel.text = String(UserDefaults.standard.integer(forKey: "highScore"))
    }
    
    @IBAction func unwindFromSettingsToInitialView(_ segue: UIStoryboardSegue) {
        highScoreLabel.text = String(UserDefaults.standard.integer(forKey: "highScore"))
    }
}


//
//  SettingsViewController.swift
//  Snake
//
//  Created by Albert Mercadé on 21/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var snakeSpeedSlider: UISlider!
    @IBOutlet weak var snakeColorPicker: UIStackView!
    @IBOutlet weak var gameModeControl: UISegmentedControl!
    @IBOutlet weak var wallsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        snakeSpeedSlider.value = 1/UserDefaults.standard.float(forKey: "snakeSpeed")
        gameModeControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "gameMode")
        wallsSwitch.isOn = UserDefaults.standard.bool(forKey: "wallsInGrid")
        checkGameMode()
        snakeSpeedSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        wallsSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider!) {
        UserDefaults.standard.set(1/sender.value, forKey: "snakeSpeed")
    }
    
    @objc func switchChanged(sender: UISwitch) {
        let value = sender.isOn
        UserDefaults.standard.set(value, forKey: "wallsInGrid")
    }

    @IBAction func gameModeChanged(_ sender: UISegmentedControl) {
        let mode:Int = sender.selectedSegmentIndex

        UserDefaults.standard.set(mode, forKey: "gameMode")
        
        checkGameMode()
    }
    
    func checkGameMode() {
        if gameModeControl.selectedSegmentIndex == 0 {
            snakeSpeedSlider.isEnabled = true
        }
        else {
            snakeSpeedSlider.isEnabled = false
        }
    }
    
    @IBAction func resetHighScoreButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "highScore")
    }
}

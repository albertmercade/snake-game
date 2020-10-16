//
//  PauseViewController.swift
//  Snake
//
//  Created by Albert Mercadé on 23/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenWidth = UIScreen.main.bounds.size.width
        playButton.widthAnchor.constraint(equalToConstant: screenWidth/6).isActive = true
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToGameViewFromPause", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

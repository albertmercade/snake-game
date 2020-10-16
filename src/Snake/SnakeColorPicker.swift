//
//  SnakeColorPicker.swift
//  Snake
//
//  Created by Albert Mercadé on 21/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class SnakeColorPicker: UIStackView {
    let colors = [UIColor.yellow, UIColor.orange, UIColor.red, UIColor.purple, UIColor.magenta, UIColor.cyan, UIColor.blue, UIColor.green]
    var selectedColor: UIColor!
    
    var colorButtons:[UIButton]!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setupStackView()
        self.createButtons()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStackView()
        self.createButtons()
    }
    
    func setupStackView() {
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 0
    }
    
    func createButtons() {
        let currentSnakeColor = UserDefaults.standard.color(forKey: "snakeColor")
        colorButtons = [UIButton]()
        for col in colors {
            let btn = UIButton()
            btn.backgroundColor = col
            if (currentSnakeColor == col) {btn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)}
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.heightAnchor.constraint(equalTo: btn.widthAnchor, multiplier: 1.0).isActive = true
            btn.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)
            colorButtons.append(btn)
            self.addArrangedSubview(btn)
        }
    }
    
    @objc func colorButtonPressed(_ sender: UIButton) {
        selectedColor = sender.backgroundColor
        UserDefaults.standard.set(selectedColor, forKey: "snakeColor")
        
        for btn in colorButtons {
            if selectedColor == btn.backgroundColor {
                btn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            }
            else {
                btn.setImage(nil, for: .normal)
            }
        }
    }
}

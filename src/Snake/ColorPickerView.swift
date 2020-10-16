//
//  ColorPickerView.swift
//  Snake
//
//  Created by Albert Mercadé on 21/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class ColorPickerView: UIStackView {
    let colors = [UIColor.white, UIColor.yellow, UIColor.orange, UIColor.red, UIColor.purple, UIColor.blue, UIColor.green, UIColor.brown]
    var selectedColor: UIColor!
    
    //let colorButtons: [UIButton]?
    
    //var colorButtonSide: CGFloat!

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("hello")
//        self.spacing = 0
//        colorButtonSide = 20
//        self.heightAnchor.constraint(equalToConstant: colorButtonSide).isActive = true
//        addButtonsToView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addButtonsToView() {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

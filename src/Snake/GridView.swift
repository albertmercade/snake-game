//
//  GridView.swift
//  Snake
//
//  Created by Albert Mercadé on 19/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

class GridView: UIView {
    // MARK: Properties
    var rows = 25
    let cols = 20
    var cellSide:CGFloat?
    
    var gridPath: UIBezierPath!
    var snakePath = [UIBezierPath]()
    var foodPath: UIBezierPath!
    var wallPath = [UIBezierPath]()
    
    // MARK: Initialization
    init(frame: CGRect, viewWidth: CGFloat) {
        super.init(frame: frame)
        
        self.cellSide = viewWidth/CGFloat(cols)
        
        // Set background color
        self.backgroundColor = .systemFill
        
        let availableHeight = UIScreen.main.bounds.height - 175
        var maxRows = availableHeight / cellSide!
        maxRows.round(.down)
        self.rows = min(Int(maxRows), 25)
        
        // Set GridView constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: self.cellSide! * CGFloat(self.rows)).isActive = true
        self.widthAnchor.constraint(equalToConstant: self.cellSide! * CGFloat(self.cols)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        drawSnake()
        drawFood()
        drawWalls()
    }
    
    func drawSnake() {
        let snakeColor = UserDefaults.standard.color(forKey: "snakeColor")!
        snakeColor.setFill()
        for cell in snakePath {
            cell.fill()
        }
    }
    
    func drawFood() {
        if foodPath != nil {
            UIColor.brown.setFill()
            foodPath.fill()
        }
    }
    
    func drawWalls() {
        UIColor.init(displayP3Red: 0.55, green: 0.55, blue: 0.55, alpha: 1.0).setFill()
        for wall in wallPath {
            wall.fill()
        }
    }
    
    func updateFoodOnBoard(food: CGPoint) {
        foodPath = UIBezierPath(rect: CGRect(x: food.x * cellSide!, y: food.y*cellSide!, width: cellSide!, height: cellSide!))
    }
    
    func appendToSnakePath(cell: CGPoint) {
        snakePath.insert(UIBezierPath(rect: CGRect(x: cell.x * cellSide! + cellSide!/40, y: cell.y * cellSide! + cellSide!/40, width: cellSide! - cellSide!/40, height: cellSide!  - cellSide!/40)), at: 0)
    }
    
    func appendToWallPath(wall: CGPoint) {
        wallPath.append(UIBezierPath(rect: CGRect(x: wall.x * cellSide! - cellSide!/100, y: wall.y * cellSide! - cellSide!/100, width: cellSide! + cellSide!/50, height: cellSide! + cellSide!/50)))
    }
    
    func removeLastSnakeCellFromPath() {
        snakePath.removeLast()
    }
}

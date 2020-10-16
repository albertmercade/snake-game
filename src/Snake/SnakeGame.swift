//
//  SnakeGame.swift
//  Snake
//
//  Created by Albert Mercadé on 20/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import Foundation
import UIKit

class SnakeGame {
    // MARK: Properties
    // View painting the grid, snake and food
    var board: GridView!
    
    var walls = [CGPoint]()
    var snake = [CGPoint]()
    var food: CGPoint!
    
    enum direction {
        case up, down, right, left
    }
    // Direction of snake movement
    var dir: direction?
    
    // Timer to repeatedly call moveSnake and simulate movement
    var timer: Timer!
    
    // Snake speed
    var speed: Double!
    var increasingSpeed = false
    
    // Snake length
    var score: Int! {
        didSet {
            // notify GameViewController of score update
            NotificationCenter.default.post(name: NSNotification.Name("updatedScore"), object: nil, userInfo: ["score":score!])
            
            if increasingSpeed && score % 3 == 0 && speed > 0.05 {
                speed -= 0.02
                stopTimer()
                startTimer()
            }
        }
    }
    
    // MARK: Initialization
    init(viewWidth: CGFloat) {
        increasingSpeed = UserDefaults.standard.integer(forKey: "gameMode") == 1
        if increasingSpeed {
            speed = 0.25
        }
        else {
            speed = Double(UserDefaults.standard.float(forKey: "snakeSpeed"))
        }
        
        score = 0
        createAndSetupGrid(viewWidth: viewWidth)
        if UserDefaults.standard.bool(forKey: "wallsInGrid") {
            setupWalls()
        }
        setupInitialSnakeAndFoodPosition()
        board.setNeedsDisplay()
    }
    
    // MARK: Setup Functions
    private func createAndSetupGrid(viewWidth: CGFloat) {
        // Initialize board view
        board = GridView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: viewWidth, height: viewWidth*1.25), viewWidth: viewWidth) as GridView
    }
    
    private func setupInitialSnakeAndFoodPosition() {
        // Initial snake position
        var snakePos: CGPoint!
        repeat {
            snakePos = CGPoint(x: Int.random(in: 2 ..< board.cols-2), y: Int.random(in: 2 ..< board.rows-2))
        } while walls.contains(snakePos)
        
        appendToSnake(cell: snakePos)
        
        // Position random food
        setNewRandomFood()
    }
    
    private func setupWalls() {
        let numWalls = 7
        
        for _ in 0..<numWalls {
            var randomCentre: CGPoint!
            repeat {
                randomCentre = CGPoint(x: Int.random(in: 3 ..< board.cols-3), y: Int.random(in: 3 ..< board.rows-3))
            } while isNotAtDistance(centre: randomCentre, distance: 5.0)
            let wall = generateWall(centre: randomCentre)
            
            walls += wall
            
            for block in wall {
                board.appendToWallPath(wall: block)
            }
        }
    }
    
    private func generateWall(centre: CGPoint) -> [CGPoint] {
        var wall = [centre]
        for _ in 0..<2 {
            var newWall = centre
            repeat {
                let dir = Int.random(in: 0...3)
                newWall = centre
                switch dir {
                    case 0:
                        newWall.y -= 1
                    case 1:
                        newWall.x += 1
                    case 2:
                        newWall.y += 1
                    case 3:
                        newWall.x -= 1
                    default:
                        fatalError("Unrecognised direction.")
                }
            } while wall.contains(newWall)
            wall.append(newWall)
        }
        return wall
    }
    
    private func isNotAtDistance(centre: CGPoint, distance: Float) -> Bool {
        for block in walls {
            if distanceCGP(p1: block, p2: centre) < distance {
                return true
            }
        }
        return false
    }
    
    private func distanceCGP(p1: CGPoint, p2: CGPoint) -> Float {
        return Float(sqrt(pow(p2.x - p1.x,2) + pow(p2.y - p1.y,2)))
    }
    
    // MARK: Private Functions
    private func setNewRandomFood() {
        repeat {
            food = CGPoint(x: Int.random(in: 2 ..< board.cols-2), y: Int.random(in: 2 ..< board.rows-2))
        } while snake.contains(food) || walls.contains(food)
        
        board.updateFoodOnBoard(food: food)
    }
    
    private func appendToSnake(cell : CGPoint) {
        snake.insert(cell, at: 0)
        
        board.appendToSnakePath(cell: cell)
    }
    
    // MARK: Timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(moveSnake), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
        timer = nil
    }
    
    // MARK: Snake Behaviour Function
    @objc func moveSnake() {
        // Create new cell
        var newCell = snake[0]
        
        // Move cell in direction of snake movement
        switch dir {
            case .up:
                newCell.y -= 1
                if newCell.y < 0 {
                    newCell.y = CGFloat(board.rows) - 1
                }
            case .down:
                newCell.y += 1
                if newCell.y >= CGFloat(board.rows) {
                    newCell.y = 0
                }
            case .left:
                newCell.x -= 1
                if newCell.x < 0 {
                    newCell.x = CGFloat(board.cols) - 1
                }
            case .right:
                newCell.x += 1
                if newCell.x >=  CGFloat(board.cols){
                    newCell.x = 0
                }
            case .none:
                fatalError("Direction not recognized")
        }
        
        if ateItself(p: newCell) || hitWall(p: newCell) {
            // Stop timer and movement of snake
            stopTimer()
            
            // Notify GameViewController of game over
            NotificationCenter.default.post(name: NSNotification.Name("gameOver"), object: nil)
        }
        else {
            // Append cell to snake
            appendToSnake(cell: newCell)
            
            if newCell == food {
                // Update score
                score! += 1
                // Set new food position
                setNewRandomFood()
            }
            else {
                // Remove last cell of snake
                snake.removeLast()
                // Update snakePath
                board.removeLastSnakeCellFromPath()
            }
            
            // Redraw board
            board.setNeedsDisplay()
        }
    }
    
    // MARK: Auxiliary Functions
    // Check is snake collided with itself
    func ateItself(p: CGPoint) -> Bool {
        if !snake.isEmpty && (snake[0..<snake.count-1]).contains(p) {
            return true
        }
        return false
    }
    
    // Check whether snake has hit a wall
    func hitWall(p: CGPoint) -> Bool {
        if walls.contains(p) {
            return true
        }
        return false
    }
}

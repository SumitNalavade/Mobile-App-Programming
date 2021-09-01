//
//  ViewController.swift
//  whackAMole
//
//  Created by Sumit Nalavade on 8/29/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    let screenWidth = Int(UIScreen.main.bounds.width)
    let screenHeight = Int(UIScreen.main.bounds.height)
    
    let scoreLabel = UILabel()
    let fieldLabel = UILabel();
    let messageLabel = UILabel();
    let startButton = UIButton()
    let newMoleButton = UIButton()
    let moleImage = UIImage(named: "mole") as UIImage?
    var moleTimer = Timer()
    
    var mainTimer = Timer()
    
    
    var score : Int = 0
    var secondsInBetween : Double = 3
    let maxGameTime : Double = 30
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            
            //Create and initialize score label
            scoreLabel.frame = CGRect(x: 25, y: 50, width: 200, height: (screenHeight/10))
            scoreLabel.textColor = .white
            scoreLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
            
            updateScore(0, true)
            
            messageLabel.frame = CGRect(x: screenWidth - 200, y: 50, width: 200, height: (screenHeight/10))
            messageLabel.textColor = .red
            messageLabel.font = UIFont.boldSystemFont(ofSize: 25.0)

            //Create the field
            fieldLabel.frame = CGRect(x: 0, y: 50 + Int(screenHeight/10), width: screenWidth, height: screenHeight - (50 + Int(89.6)))
            fieldLabel.backgroundColor = .green
            fieldLabel.isUserInteractionEnabled = true
            
            //Create the starting button
            startButton.frame = CGRect(x: 0, y: 0, width: 100, height: (screenHeight/10))
            startButton.backgroundColor = .brown
            startButton.setTitle("Tap to start", for: .normal)
            startButton.addTarget(self, action: #selector(createNewMole), for: .touchUpInside)
        
            self.view.addSubview(scoreLabel)
            self.view.addSubview(fieldLabel)
            self.view.addSubview(messageLabel)
            fieldLabel.addSubview(startButton)
        
            selectDifficulty()
                            
    }
    
    @objc func selectDifficulty () {
        let alert = UIAlertController(title: "Game Mode", message: "Select Difficulty", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Hard", style: .default, handler: {
            action in self.secondsInBetween = 1
        }))
        
         alert.addAction(UIAlertAction(title: "Easy", style: .cancel, handler: {
                   action in self.secondsInBetween = 3
               }))

        self.present(alert, animated: true)
    }
    
    //Called if a mole is clicked and calls the updateScore function, removes the clicked mole from view and calls the createNewMole functon
    @objc func moleClicked (size : Int) {
        let addedScore : Int
        let moleSize = newMoleButton.bounds.size.width
        
        switch moleSize {
        case 0...50:
            addedScore = 5
        case 50...100:
            addedScore = 3
        case 100...150:
            addedScore = 2
        default:
            addedScore = 1
        }
        
        messageLabel.text = ""
        updateScore(addedScore, true)
        createNewMole()
    }
    
    //Generated a randomX and randomY position and adds a new mole to the field with the random coordinates. Resets the current timer
    @objc func createNewMole () {
        if startButton.isDescendant(of: view) {
            self.mainTimer = Timer.scheduledTimer(timeInterval: self.maxGameTime, target:self, selector:#selector(self.showGameOver), userInfo:nil, repeats:true)
            startButton.removeFromSuperview()
        }
        
        let randomSize = Int.random(in: 10...200)
        let randomX = Int.random(in: 0...screenWidth - randomSize)
        let randomY = Int.random(in: 0...Int(fieldLabel.bounds.size.height) - randomSize)
        
        newMoleButton.frame = CGRect(x: randomX, y: randomY, width: randomSize, height: randomSize)
        newMoleButton.setImage(moleImage, for: .normal)
        newMoleButton.addTarget(self, action: #selector(moleClicked), for: .touchUpInside)
        
        fieldLabel.addSubview(newMoleButton)
        
        moleTimer.invalidate()
        //deleteMole function is called if the timer runs out
        moleTimer = Timer.scheduledTimer(timeInterval: secondsInBetween, target:self, selector:#selector(deleteMole), userInfo:nil, repeats:true)
    }
    
    //Called if the timer runs out. Removes the current mole from screen and decrements the score by 1, and called the createNewMole function
    @objc func deleteMole(_ sender: UIButton!) {
        messageLabel.text = "Missed Mole!"
        newMoleButton.removeFromSuperview()
        updateScore(1, false)
        createNewMole()
    }
    
    //Takes in a number to change the score by and takes in a boolean value representing weather to increment or decrement the score
    func updateScore (_ addScore : Int, _ isIncrement : Bool) {
        isIncrement ? (score = score + addScore) : (score = score - addScore)
        
        if(score < 0) {
            score = 0
        }
        
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func showGameOver () {
        moleTimer.invalidate()
        
        let gameOverAlert = UIAlertController(title: "Game Over", message: """
            Total Score : \(score)
            Play again?
            """, preferredStyle: .alert)
        
        gameOverAlert.addAction(UIAlertAction(title: "No", style: .default, handler: {
            action in let finalGameOver = UIAlertController(title: "Game Over", message: "Thank You For Playing!", preferredStyle: .alert)
            self.present(finalGameOver, animated: true)
        } ))
        
        gameOverAlert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: {
            action in self.reset()
        }))

        self.present(gameOverAlert, animated: true)
    }
    
    @objc func reset () {
        newMoleButton.removeFromSuperview()
        mainTimer.invalidate()
        score = 0
        updateScore(0, true)
        
        viewDidAppear(true)

    }
    
}


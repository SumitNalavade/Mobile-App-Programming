//
//  ViewController.swift
//  Wordle
//
//  Created by Sumit Nalavade on 1/29/22.
//  Copyright © 2022 Sumit Nalavade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game = Game()
    @IBOutlet var row1Labels: [UILabel]!
    @IBOutlet var row2Labels: [UILabel]!
    @IBOutlet var row3Labels: [UILabel]!
    @IBOutlet var row4Labels: [UILabel]!
    @IBOutlet var row5Labels: [UILabel]!
    @IBOutlet var row6Labels: [UILabel]!
    
    let customGreen = UIColor(red: 0.41, green: 0.66, blue: 0.39, alpha: 1)
    let customYellow = UIColor(red: 0.78, green: 0.71, blue: 0.35, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateRows()
    }

    @IBAction func wordTextFieldSubmit(_ sender: UITextField) {
        let submittedWord = sender.text!
        
        self.game.addWord(word: submittedWord)
        self.populateRows()
        sender.text = ""
        
        if(submittedWord == game.correctWord) {
            self.showAlert(message: "Correct!")
        } else if(game.remainingAttempts <= 0) {
            self.showAlert(message: """
0 Attempts remaining
Correct Word: \(game.correctWord)
""")
        }
    }
    
    func populateRows() {
        let UILabels = [row1Labels, row2Labels, row3Labels, row4Labels, row5Labels, row6Labels]
        let gameRows = [game.row1, game.row2, game.row3, game.row4, game.row5, game.row6]
        
        for (gameRowIndex, gameRow) in gameRows.enumerated() {
            for (index, letter) in gameRow.enumerated() {
                let label = UILabels[gameRowIndex]![index]
                                
                if(label.text == letter.letter) { continue }
                
                if(letter.isCorrect) {
                    label.backgroundColor = customGreen
                }
                
                UIView.transition(with: label, duration: 0.5, options: .transitionFlipFromTop, animations: {
                    label.text = letter.letter; if(letter.isCorrect) {
                        label.backgroundColor = self.customGreen
                    } else if(letter.inWord) { label.backgroundColor = self.customYellow }
                }, completion: nil)
            }
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


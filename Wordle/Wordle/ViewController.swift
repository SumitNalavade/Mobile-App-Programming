//
//  ViewController.swift
//  Wordle
//
//  Created by Sumit Nalavade on 1/29/22.
//  Copyright © 2022 Sumit Nalavade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Initialize the game
    var game = Game()
    
    //Array of UI labels of each on screen row
    @IBOutlet var row1Labels: [UILabel]!
    @IBOutlet var row2Labels: [UILabel]!
    @IBOutlet var row3Labels: [UILabel]!
    @IBOutlet var row4Labels: [UILabel]!
    @IBOutlet var row5Labels: [UILabel]!
    @IBOutlet var row6Labels: [UILabel]!
    
    @IBOutlet weak var hintsLabel: UILabel!
    
    let customGreen = UIColor(red: 0.41, green: 0.66, blue: 0.39, alpha: 1)
    let customYellow = UIColor(red: 0.78, green: 0.71, blue: 0.35, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateRows()
        self.updateHintsLabel()
    }

    //Take the word submitted in the text field and call the game.addWord() function
    //Call the self.populateRows() function to redraw the on screen labels
    //If the submitted word is the same as game.correctWord, show an alert telling the user that they won
    @IBAction func wordTextFieldSubmit(_ sender: UITextField) {
        let submittedWord = sender.text!.lowercased()
                
        self.game.addWord(word: submittedWord)
        self.populateRows()
        sender.text = ""
        
        if(submittedWord == game.correctWord) {
            self.showAlert(message: "Correct!")
        } else if(game.remainingAttempts <= 0) {
            self.showAlert(message: """
0 Attempts remaining
Correct Word: \(game.correctWord!)
""")
        }
    }
    
    //Create two arrays. One representing the UILables and one representing the game state
    //Iterate through the game state and match each UILabel to show the correct letter as defined in the game state
    //If the Letter.isCorrect property is true, change the UILabel background color to green or else if the Letter.inWord property is true, change the background color to yellow
    //Use a transition to flip the UILabel if there is a change to it
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
    
    //Update the hints label with the game.remainingHints property
    func updateHintsLabel() {
        let remainingHints = game.remainingHints
        
        self.hintsLabel.text = "Hints: \(remainingHints)"
    }
    
    //Show an alert when the hint button is tapped
    //Guard against the remaining hints being 0
    @IBAction func useHintButtonTapped(_ sender: Any) {
        guard game.remainingHints > 0 else { return }
        
        game.remainingHints -= 1
        self.updateHintsLabel()
    
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Definition", message: self.game.hint!, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Show an alert with a message of "Won" or loss when the user either enters a correct word or runs out of attempts
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateRows()
    }

    @IBAction func wordTextFieldSubmit(_ sender: UITextField) {
        let submittedWord = sender.text!
        
        self.game.addWord(word: submittedWord)
        self.populateRows()
        print(game)
    }
    
    func populateRows() {
        for (index, letter) in game.row1.enumerated() {
            row1Labels[index].text = letter
        }
        
        for (index, letter) in game.row2.enumerated() {
            row2Labels[index].text = letter
        }
        
        for (index, letter) in game.row3.enumerated() {
            row3Labels[index].text = letter
        }
        
        for (index, letter) in game.row4.enumerated() {
            row4Labels[index].text = letter
        }
        
        for (index, letter) in game.row5.enumerated() {
            row5Labels[index].text = letter
        }
        
        for (index, letter) in game.row6.enumerated() {
            row6Labels[index].text = letter
        }
    }
}


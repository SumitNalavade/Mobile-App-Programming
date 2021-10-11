//
//  welcomeViewController.swift
//  TicTacToe
//
//  Created by Sumit Nalavade on 10/1/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit
import AVFoundation

class welcomeViewController: UIViewController {
    
    @IBOutlet var startButtonsCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        for buttons in startButtonsCollection {
            buttons.layer.cornerRadius = 5
        }
    }

    @IBAction func startButtonClicked(_ sender: UIButton) {
        let gameVC = storyboard?.instantiateViewController(identifier: "gameVC") as! ViewController
        
        gameVC.gameMode = sender.tag
                
        present(gameVC, animated: true)
    }
}

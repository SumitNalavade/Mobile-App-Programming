//
//  ViewController.swift
//  Xylophone
//
//  Created by Nalavade, Sumit S on 11/12/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var keys: [UIButton]!
    var player: AVAudioPlayer!
    @IBOutlet weak var guitarButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var spacing : Int = 5
        
        guitarButton.layer.cornerRadius = 5
        
        guitarButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        keys.forEach { key in
            NSLayoutConstraint.init(item: key, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: CGFloat(spacing)).isActive = true
            
            spacing += 5
            
            key.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
            
        }
        
    }
    
    @objc func keyPressed(_ sender: UIButton) {
        let url = Bundle.main.url(forResource: sender.title(for: .normal), withExtension: "wav")
        
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let guitarVC = storyboard?.instantiateViewController(identifier: "GuitarViewController") as! GuitarViewController
        
        present(guitarVC, animated: true)
    }
}



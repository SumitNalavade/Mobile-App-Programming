//
//  GuitarViewController.swift
//  Xylophone
//
//  Created by Sumit Nalavade on 11/14/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit
import AVFoundation

class GuitarViewController: UIViewController {

   @IBOutlet var keys: [UIButton]!
    var player: AVAudioPlayer!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var spacing : Int = 5
    
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
}

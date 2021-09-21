//
//  ViewController.swift
//  magic8Ball
//
//  Created by Nalavade, Sumit S on 9/20/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    let initialText : String = "Think of a question, Any Question"
    
    var shakeTimer = Timer()
    
    var responses : [String] = [
        "Outlook good",
        "It is certain",
        "Without a Doubt",
        "Signs point to yes",
        "Reply hazy, try again later",
        "Ask again later",
        "Cannot predict now",
        "Better not tell you now",
        "Don't count on it",
        "My reply is no",
        "My sources say no",
        "Outlook not so good",
        "Very doubtful"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "triangle")
        textLabel.text = initialText
        
        view.becomeFirstResponder()
                
    }


    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if(textLabel.text == "Think of a question, Any Question") {
            textLabel.text = drawRandomQuestion()
        }
        
        shakeTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(resetTextLabel), userInfo: nil, repeats: false)
    }
    
    func drawRandomQuestion () -> String {
        let randomIndex = Int.random(in: 0...responses.count - 1)
        
        return responses[randomIndex]

    }
    
    @objc func resetTextLabel () {
        textLabel.text = initialText
        
        shakeTimer.invalidate()
    }
    
    
}


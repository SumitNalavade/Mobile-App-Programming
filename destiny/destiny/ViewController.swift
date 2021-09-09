//
//  ViewController.swift
//  destiny
//
//  Created by Sumit Nalavade on 9/9/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @IBOutlet var sceneLabel: UILabel!
    @IBOutlet var choice1Button: UIButton!
    @IBOutlet var choice2Button: UIButton!
    
    var currentStory = Story(title: "You are a refugee from a war torn country. Your parents want you to go to school but you want to work to support your family", choice1: "Go To School", choice2: "Go To Work", choice1Index: 0, choice2Index: 1)
    
    struct Story {
        var title : String
        var choice1 : String
        var choice2 : String
        var choice1Index : Int
        var choice2Index : Int
        
        init(title: String, choice1 : String, choice2: String, choice1Index: Int, choice2Index: Int) {
            self.title = title
            self.choice1 = choice1
            self.choice2 = choice2
            self.choice1Index = choice1Index
            self.choice2Index = choice2Index
        }
    }
    
    let stories = [
        Story(title: "You attend school for the first time but don't have any friends. You want to meet people and find friends", choice1: "Go to a club meeting", choice2: "Hang out with students after school", choice1Index: 2, choice2Index: 3),
        
        Story(title: "You go to work in a chemical factory and are asked to choice what job to perform", choice1: "Shipping (Low Pay, Low Risk)", choice2: "Manufacturing (High Pay, High Risk)", choice1Index: 4, choice2Index: 5),
        
        Story(title: "You check out a few clubs after school and are intersted by two. Which ones will you join?", choice1: "Robotics Club", choice2: "Film Club", choice1Index: 6, choice2Index: 7),
        
        Story(title: "You meet up with a large group of sketchy students after school and are offered a joint. Will you take it?", choice1: "Yes", choice2: "No", choice1Index: 8, choice2Index: 9),
        
        Story(title: "You choose to do shipping work for low pay but get into an accident. You're hurt but think you will be fine. Should you get it check out?", choice1: "Go to doctor", choice2: "Walk it off", choice1Index: 10, choice2Index: 11),
        
        Story(title: "You choose to manufacture chemicals which is risky, but you make good money. Suddenly, your buddy gets hurt and almost dies.", choice1: "Stay in manufacturing", choice2: "Switch to shipping", choice1Index: 12, choice2Index: 4)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        choice1Button.layer.cornerRadius = 5
        choice2Button.layer.cornerRadius = 5
        
        sceneLabel.text = currentStory.title
        choice1Button.setTitle(currentStory.choice1, for: .normal)
        choice2Button.setTitle(currentStory.choice2, for: .normal)
        
        choice1Button.addTarget(self, action: #selector(choice1Clicked(_:)), for: .touchUpInside)
        choice2Button.addTarget(self, action: #selector(choice2Clicked(_:)), for: .touchUpInside)
    }

    @objc func choice1Clicked (_ sender : UIButton!) {
        currentStory = stories[currentStory.choice1Index]
        sceneLabel.text = currentStory.title
        choice1Button.setTitle(currentStory.choice1, for: .normal)
        choice2Button.setTitle(currentStory.choice2, for: .normal)
    }
    
    @objc func choice2Clicked (_ sender : UIButton!) {
        currentStory = stories[currentStory.choice2Index]
        sceneLabel.text = currentStory.title
        choice1Button.setTitle(currentStory.choice1, for: .normal)
        choice2Button.setTitle(currentStory.choice2, for: .normal)
    }

}


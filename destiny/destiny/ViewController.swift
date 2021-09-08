//
//  ViewController.swift
//  destiny
//
//  Created by Nalavade, Sumit S on 9/8/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
        
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var goToSchoolButton: UIButton!
    @IBOutlet weak var goToWorkButton: UIButton!
    
    var game = Destiny()
    
    struct Story {
        let title : String
        let choice1 : String
        let choice1Index : Int
        let choice2 : String
        let choice2Index : Int
        
        init(title : String, choice1 : String, choice1Index : Int, choice2 : String, choice2Index : Int) {
            self.title = title
            self.choice1 = choice1
            self.choice1Index = choice1Index
            self.choice2 = choice2
            self.choice2Index = choice2Index
        }
        
    }
    
    struct Destiny {
        
        var currentStory : Int = 0
        
        let stories = [ //construct Story objects inside the list
            Story(title: "this is the first story text (room) that will display", choice1: "first path choice", choice1Index: 1, choice2: "second path choice", choice2Index: 2), //Story object at index 0
            
            Story(title: "second room text", choice1: "third choice", choice1Index: 0, choice2: "fourth choice", choice2Index: 1),
            
            Story(title: "final room", choice1: "the", choice1Index: -1, choice2: "end", choice2Index: -1)  //Story object at index 1
        ]
        
        func getCurrentStoryTitle () -> String {
            return stories[currentStory].title
        }
        
        func getCurrentStoryChoice1 () -> String {
            return stories[currentStory].choice1
        }
        
        func getCurrentStoryChoice2 () -> String {
            return stories[currentStory].choice2
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToSchoolButton.layer.cornerRadius = 5
        goToWorkButton.layer.cornerRadius = 5
        
        goToSchoolButton.addTarget(self, action: #selector(goToSchoolButtonPressed(_:)), for: .touchUpInside)
        goToWorkButton.addTarget(self, action: #selector(goToWorkButtonPressed(_:)), for: .touchUpInside)
        
    }


    @objc func goToSchoolButtonPressed (_ sender: UIButton) {
        print("Go To School Button Pressed")
    }
    
    @objc func goToWorkButtonPressed (_ sender: UIButton) {
        print("Go To Work Button Pressed")
    }
}

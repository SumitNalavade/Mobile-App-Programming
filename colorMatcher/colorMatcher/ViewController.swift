//
//  ViewController.swift
//  colorMatcher
//
//  Created by Nalavade, Sumit S on 11/2/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var matchColorBox: UILabel!
    @IBOutlet weak var myColorBox: UILabel!
    
    @IBOutlet var colorBoxes: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for box in colorBoxes {
            box.layer.borderWidth = 5
            box.layer.borderColor = UIColor.black.cgColor
        }
        
        for slider in sliders {
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            
            slider.value = 1.0
        }
        
        matchColorBox.backgroundColor = generateRandomColor()
                
    }
    
    func generateRandomColor () -> UIColor {
        let r : CGFloat = CGFloat.random(in: 0...1)
        let g : CGFloat = CGFloat.random(in: 0...1)
        let b : CGFloat = CGFloat.random(in: 0...1)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
        
    }

    @IBAction func SliderAction(_ sender: UISlider) {
        myColorBox.backgroundColor = UIColor(red: CGFloat(sliders[0].value), green: CGFloat(sliders[1].value), blue: CGFloat(sliders[2].value), alpha: 1.0)
        
        checkColor()
    }
    
    func checkColor () {
        if(matchColorBox.backgroundColor == myColorBox.backgroundColor) {
            let alert = UIAlertController(title: "Game Over", message: "Color Matched!", preferredStyle: .alert)
            
            self.present(alert, animated: true)
        }
    }
    
}


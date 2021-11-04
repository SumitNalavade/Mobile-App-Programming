//
//  ViewController.swift
//  colorMatcher
//
//  Created by Nalavade, Sumit S on 11/2/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

//1. Extension to UIColor that returns the RGB values as doubles
extension UIColor {
    var getRGB: (red: Double, green: Double, blue: Double, alpha: Double) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (Double(red), Double(green), Double(blue), Double(alpha))
    }
}

class ViewController: UIViewController {

    //2. Outlets to on screen components
    @IBOutlet weak var matchColorBox: UILabel!
    @IBOutlet weak var myColorBox: UILabel!
    
    @IBOutlet var colorBoxes: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    
    @IBOutlet var timeLeftLabel: UILabel!
    
    //3. Timer
    let MAXTIME = 30
    var timeLeft = 30
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //4. Programmatically style the color boxes
        colorBoxes.forEach { box in
            box.layer.borderWidth = 5
            box.layer.borderColor = UIColor.black.cgColor
        }
        
        sliders.forEach { slider in
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            
            slider.value = 1.0
        }
        
        //5. Pick a random color to match
        matchColorBox.backgroundColor = generateRandomColor()
        
        //6. Start the timer
        setTimer()
    }
    
    //7. Function generates three random numbers between 0-1 and returns a UIColor made up of those colors
    func generateRandomColor () -> UIColor {
        let r : CGFloat = CGFloat.random(in: 0...1)
        let g : CGFloat = CGFloat.random(in: 0...1)
        let b : CGFloat = CGFloat.random(in: 0...1)
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
        
    }

    //8. Function is called when a slider is moved, calls the check color function to check if the current color is the same as the randomly generated one
    @IBAction func SliderAction(_ sender: UISlider) {
        myColorBox.backgroundColor = UIColor(red: CGFloat(sliders[0].value), green: CGFloat(sliders[1].value), blue: CGFloat(sliders[2].value), alpha: 1.0)
        
        checkColor()
    }
    
    //9. Checks if the user's color is the same as the randomly generated color. Calls the gameOverAlert function if the color is the same
    func checkColor () {
        if(matchColorBox.backgroundColor == myColorBox.backgroundColor) {
            self.gameOverAlert(status: 0)
        }
    }
    
    //10. Sets the timer that updates the time left label evert second. Calls the gameOverAlert function when the remaining time reaches 0
    func setTimer () {        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeLeft -= 1
            
            self.timeLeftLabel.text = "Time Left: \(self.timeLeft)"
            
            if(self.timeLeft == 0) {
                timer.invalidate()
                
                self.gameOverAlert(status: 1)
            }
        }
    }
    
    //11. Function takes in a status code. 0 means the color is matched while anything else means the user has ran out of time. Presents a alert with the score and asking to play again
    func gameOverAlert (status : Int) {
        let message = (status == 0) ? "Color Matched!" : "Time Out!"
        
        let alert = UIAlertController(title: "\(message)", message: "Score: \(scoreCalc())", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            self.reset()
        }))
        
        self.present(alert, animated: true)
    }
    
    //12. Calculates the liner distance and converts it into a score and returns the value rounded to the neart intger
    func scoreCalc () -> Double {
        let myColor = myColorBox.backgroundColor!.getRGB
        let matchColor = matchColorBox.backgroundColor!.getRGB
        
        let rDiff = pow((matchColor.red - myColor.red), 2)
        let bDiff = pow((matchColor.blue - myColor.blue), 2)
        let gDiff = pow((matchColor.green - myColor.green), 2)
    
        var score = (1 - pow((rDiff + gDiff + bDiff), 2)) * 100
        
        if(score < 0) {
            score = 0
        }
        
        return score.rounded()
    }
    
    //13. Resets the game
    func reset () {
        sliders.forEach { slider in
            slider.value = 1.0
        }
        
        myColorBox.backgroundColor = .white
        matchColorBox.backgroundColor = generateRandomColor()
        timeLeft = MAXTIME
        setTimer()
    }
}


//
//  ViewController.swift
//  Light
//
//  Created by Nalavade, Sumit S on 8/23/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lightOn = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeBackgroundColor () {
        if(lightOn) {
            view.backgroundColor = .white
        } else if (!lightOn) {
            view.backgroundColor = .black
        }
    }

    @IBAction func toggleLightButton(_ sender: Any) {
        lightOn.toggle()
    }
}


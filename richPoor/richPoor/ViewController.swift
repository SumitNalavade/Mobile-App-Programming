//
//  ViewController.swift
//  richPoor
//
//  Created by Nalavade, Sumit S on 8/25/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isRich = true
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var caption: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changeStatus (status : Bool) {
        if(status) {
            statusLabel.text = "I Am Rich"
            caption.text = "My Wealth Is Great 👑"
            image.image = UIImage(named: "diamond")
            view.backgroundColor = (.systemGreen)
        } else {
            statusLabel.text = "I Am Poor"
            caption.text = "My Money Is No More 😔"
            image.image = UIImage(named: "pennies")
            view.backgroundColor = (.gray)
        }
    }
    
    @IBAction func changeButton(_ sender: Any) {
        isRich.toggle()
        changeStatus(status: isRich)
    }
    
}


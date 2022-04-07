//
//  ViewController.swift
//  Mynance
//
//  Created by Nalavade, Sumit S on 4/7/22.
//  Copyright © 2022 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        if(validateLogin(username: username, password: password)) {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    func validateLogin(username: String, password: String) -> Bool {
        return true
    }
    

}


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
            let currentUser = User(name: "Sumit Nalavade", email: "vs.nalavade2003@gmail.com", address: "Test Address", balance: 100, transactions: []) //Create a new user
                       
            performSegue(withIdentifier: "loginSegue", sender: currentUser)
        }
    }
    
    func validateLogin(username: String, password: String) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            guard let user = sender as? User else { return }
            
            let tabBarViewController = segue.destination as! UITabBarController
            let navigationController = tabBarViewController.viewControllers![0] as! UINavigationController
            let homepageViewController = navigationController.viewControllers[0] as! HomepageViewController
            homepageViewController.user = user
        }
    }

}


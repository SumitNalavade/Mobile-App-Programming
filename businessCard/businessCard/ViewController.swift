//
//  ViewController.swift
//  businessCard
//
//  Created by Nalavade, Sumit S on 10/19/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    var nathanImage = UIImage(named: "sumit.jpg")
    var profileImageView = UIImageView()
    
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    var showContactButton = UIButton()
    var phoneLabel = UILabel()
    var emailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                
        profileImageView = UIImageView(frame: CGRect(x: screenSize.midX-100, y: 100, width: 200, height: 200))
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        profileImageView.clipsToBounds = true
        profileImageView.image = nathanImage
        view.addSubview(profileImageView)
        
        nameLabel.frame = CGRect(x: 0, y: (profileImageView.bounds.maxY + 50), width: screenSize.width, height: 200)
        nameLabel.text = "Sumit Nalavade"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name:"Helvetica Bold",size:30)
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
        
        descriptionLabel.frame = CGRect(x: 0, y: (nameLabel.bounds.maxY + 100), width: screenSize.width, height: 200)
        descriptionLabel.text = "Senior"
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont(name:"Helvetica",size:25)
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)

        showContactButton.frame = CGRect(x: screenSize.midX-100, y: (descriptionLabel.bounds.maxY + 250), width: screenSize.width / 2, height: 50)
        showContactButton.setTitle("Contact", for: .normal)
        showContactButton.backgroundColor = .green
        showContactButton.setTitleColor(.white, for: .normal)
        showContactButton.layer.cornerRadius = 15
        view.addSubview(showContactButton)
        
        phoneLabel.frame = CGRect(x: 0, y: (showContactButton.bounds.maxY + 500), width: screenSize.width, height: 50)
        phoneLabel.text = "Phone: 469-450-6323"
        phoneLabel.textColor = .blue
        phoneLabel.backgroundColor = .white
        phoneLabel.font = UIFont(name:"Helvetica Bold",size:15)
        phoneLabel.textAlignment = .center
        view.addSubview(phoneLabel)
        
        emailLabel.frame = CGRect(x: 0, y: (phoneLabel.bounds.maxY + 600), width: screenSize.width, height: 50)
        emailLabel.text = "Email: vs.nalavade2003@gmail.com"
        emailLabel.textColor = .blue
        emailLabel.backgroundColor = .white
        emailLabel.font = UIFont(name:"Helvetica Bold",size:15)
        emailLabel.textAlignment = .center
        view.addSubview(emailLabel)

    }


}


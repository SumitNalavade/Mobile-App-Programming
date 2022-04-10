//
//  HomepageViewController.swift
//  Mynance
//
//  Created by Nalavade, Sumit S on 4/7/22.
//  Copyright © 2022 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceView.layer.cornerRadius = 20
        balanceLabel.text = "$\(user!.balance)"
        
        dateLabel.text = getDate()
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: date)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  TransactionViewController.swift
//  Mynance
//
//  Created by Nalavade, Sumit S on 4/26/22.
//  Copyright © 2022 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var transaction: Transaction? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayTransaction(transaction: transaction!)
    }
    
    func displayTransaction(transaction: Transaction) {
        descriptionLabel.text = transaction.description
        amountLabel.text = "$\(transaction.balanceChangeAmt)"
        dateLabel.text = "Date"
        
        if(transaction.transactionType == TransactionType.expense) {
            amountLabel.textColor = .red
        } else if(transaction.transactionType == TransactionType.income) {
            amountLabel.textColor = .green
        }
    }
}

//
//  NewTransactionViewController.swift
//  Mynance
//
//  Created by Sumit Nalavade on 4/10/22.
//  Copyright © 2022 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController {
    
    @IBOutlet weak var transactionAmtTextField: UITextField!
    @IBOutlet weak var transactionTypeControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func addTransactionButtonTapped(_ sender: Any) {
        do {
            try addTransaction(transaction: createTransaction())
        } catch  {
            print("Error")
        }
    }
    
    func addTransaction(transaction: Transaction) throws {
        do {
            try user?.addTransaction(transaction: transaction)
        } catch TransactionError.overdraft {
            print("Overdraft Error")
        } catch {
            print("Unspecified Error")
        }
    }
    
    func createTransaction() throws -> Transaction {
        let transactionAmt = Double(transactionAmtTextField.text!)!
        let transactionDescription = descriptionTextField.text!
        let transactionType : TransactionType
        
        let transactionTypeControlValue = transactionTypeControl.titleForSegment(at: transactionTypeControl.selectedSegmentIndex)!
        
        switch transactionTypeControlValue {
        case "Income":
            transactionType = TransactionType.income
        case "Expense":
            transactionType = TransactionType.expense
        default:
            throw TransactionError.invalidTransactionType
        }
        
        let newTransaction = Transaction(balanceChangeAmt: transactionAmt, transactionType: transactionType, description: transactionDescription)
                
        return newTransaction
    }    
}

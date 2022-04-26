//
//  HomepageViewController.swift
//  Mynance
//
//  Created by Nalavade, Sumit S on 4/7/22.
//  Copyright © 2022 Nalavade, Sumit S. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var transactionDescriptionLabel: UILabel!
    @IBOutlet weak var transactionAmtLabel: UILabel!
}

class HomepageViewController: UIViewController {
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    var selectedTransaction: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceView.layer.cornerRadius = 20
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        balanceLabel.text = "$\(user!.balance)"
        
        dateLabel.text = getDate()
        
        self.tableView.reloadData()
    }
    
    @IBAction func addTransactionButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "newTransactionSegue", sender: nil)
    }
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTransactionSegue" {
            
            let newTransactionViewController = segue.destination as! NewTransactionViewController
            
            newTransactionViewController.user = self.user
        } else if(segue.identifier == "SegueToTransactionView") {
            let transactionViewController = segue.destination as! TransactionViewController
            
            transactionViewController.transaction = self.selectedTransaction
        }
    }
}


extension HomepageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTransaction = user?.transactions[indexPath.row]
        performSegue(withIdentifier: "SegueToTransactionView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (user?.transactions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let transaction = user?.transactions[indexPath.row]
        
        cell.transactionDescriptionLabel.text = transaction!.description
        
        if(transaction?.transactionType == TransactionType.expense) {
            cell.transactionAmtLabel.text = " - $\(transaction!.balanceChangeAmt)"
            cell.transactionAmtLabel.textColor = .red
        } else if(transaction?.transactionType == TransactionType.income) {
            cell.transactionAmtLabel.text = " + $\(transaction!.balanceChangeAmt)"
            cell.transactionAmtLabel.textColor = .green
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let deletedTransaction = user?.transactions[indexPath.row]
            user?.removeTransaction(transaction: deletedTransaction!)
            balanceLabel.text = "$\(user!.balance)"

            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
}

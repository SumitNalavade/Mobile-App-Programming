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
        }
    }
}





extension HomepageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomepageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (user?.transactions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let transaction = user?.transactions[indexPath.row]
        
        cell.transactionDescriptionLabel.text = transaction!.description
        cell.transactionAmtLabel.text = "$\(transaction!.balanceChangeAmt)"
        
        return cell
    }
}

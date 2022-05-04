import Foundation

class User {
    var balance: Double
    var transactions: [Transaction]
    
    init(balance: Double, transactions: [Transaction]) {
        self.balance = balance
        self.transactions = transactions
    }
    
    func addTransaction(transaction: Transaction) throws {
        let balanceChangeAmount: Double = transaction.balanceChangeAmt
        let transactionType: TransactionType = transaction.transactionType
        
        switch transactionType {
        case TransactionType.income:
            self.transactions.append(transaction)
            return balance += balanceChangeAmount
            
        case TransactionType.expense:
            let newBalance = balance - balanceChangeAmount
            guard newBalance >= 0 else {
                throw TransactionError.overdraft(deficit: abs(newBalance))
            }
            
            self.transactions.append(transaction)
            return balance -= balanceChangeAmount
        }
    }
    
    func removeTransaction(transaction: Transaction) {
        //Find index of transaction in transaction array
        var transactionIndex: Int?
        for (index, element) in self.transactions.enumerated() {
            if(element.id == transaction.id) {
                transactionIndex = index
                break
            }
        }
        self.transactions.remove(at: transactionIndex!)
        
        //Apply the balance change amount in the opposite way
        if(transaction.transactionType == TransactionType.income) {
            self.balance -= transaction.balanceChangeAmt
        } else if (transaction.transactionType == TransactionType.expense) {
            self.balance += transaction.balanceChangeAmt
        }
        
    }
}

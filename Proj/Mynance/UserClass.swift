import Foundation

class User {
    var name: String
    var email: String
    var address: String
    var balance: Double
    var transactions: [Transaction]
    
    init(name: String, email: String, address: String, balance: Double, transactions: [Transaction]) {
        self.name = name
        self.email = email
        self.address = address
        self.balance = balance
        self.transactions = transactions
    }
    
    var description: String {
        return "\(name): $\(balance)"
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
}

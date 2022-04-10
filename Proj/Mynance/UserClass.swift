import Foundation

class User {
    var name: String
    var email: String
    var address: String
    var balance: Double
    
    init(name: String, email: String, address: String, balance: Double) {
        self.name = name
        self.email = email
        self.address = address
        self.balance = balance
    }
    
    var description: String {
        return "\(name): $\(balance)"
    }
    
    func applyTransaction(transaction: Transaction) throws {
        let balanceChangeAmount: Double = transaction.balanceChangeAmt
        let transactionType: TransactionType = transaction.transactionType
        
        switch transactionType {
        case TransactionType.increase:
            return balance += balanceChangeAmount
            
        case TransactionType.decrease:
            let newBalance = balance - balanceChangeAmount
            guard newBalance >= 0 else {
                throw TransactionError.overdraft(deficit: abs(newBalance))
            }
            
            return balance -= balanceChangeAmount
        }
    }
}

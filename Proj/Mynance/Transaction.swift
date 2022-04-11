import Foundation

enum TransactionType {
    case expense
    case income
}

enum TransactionError: Error {
    case overdraft(deficit: Double)
    case invalidTransactionType
}

struct Transaction {
    var balanceChangeAmt: Double
    var transactionType: TransactionType
    var description: String
        
    let id: UUID = UUID() 
    
    init(balanceChangeAmt: Double, transactionType: TransactionType, description: String) {
        self.balanceChangeAmt = balanceChangeAmt
        self.transactionType = transactionType
        self.description = description
    }
}

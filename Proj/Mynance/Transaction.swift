import Foundation

enum TransactionType {
    case increase
    case decrease
}

enum TransactionError: Error {
    case overdraft(deficit: Double)
    case invalidTransactionType
}

struct Transaction {
    var balanceChangeAmt: Double
    var transactionType: TransactionType
    
    init(balanceChangeAmt: Double, transactionType: TransactionType) {
        self.balanceChangeAmt = balanceChangeAmt
        self.transactionType = transactionType
    }
}

import Foundation

enum transactionType {
    case increase
    case decrease
}

struct Transaction {
    var balanceChangeAmt: Double?
    var transactionType: transactionType?
    
    init(balanceChangeAmt: Double, transactionType: transactionType) {
        balanceChangeAmt = balanceChangeAmt
        transactionType = transactionType
    }
}

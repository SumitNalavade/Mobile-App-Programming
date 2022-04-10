import Foundation

struct User {
    let name: String
    let email: String
    let password: String
    let address: String
    
    var balance: Double
    
    func addBalance(balanceToAdd: Double) -> Double {
        balance += balanceToAdd
        
        return balance
    }
    
    func subtractBalance(balanceToSubtract: Double) -> Double {
        balance -= balanceToSubtract
        
        return balance
    }
}


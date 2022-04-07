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
    
}

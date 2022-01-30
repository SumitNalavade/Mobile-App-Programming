import Foundation

class Game: CustomStringConvertible {
    let correctWord = "Test"
    
    var remainingAttempts: Int = 6
    
    var row1: [String] = ["", "", "", "", ""]
    var row2: [String] = ["", "", "", "", ""]
    var row3: [String] = ["", "", "", "", ""]
    var row4: [String] = ["", "", "", "", ""]
    var row5: [String] = ["", "", "", "", ""]
    var row6: [String] = ["", "", "", "", ""]
    
    var description: String {
        return """
        *******
            Row 1: \(row1)
            Row2: \(row2)
            Row3: \(row3)
            Row4: \(row4)
            Row5: \(row5)
            Row6: \(row6)
        *******
"""
    }
    
    init() {
        
    }
    
    func addWord(word: String) {
        
        guard remainingAttempts > 0 else { return }
            remainingAttempts -= 1
        
        switch remainingAttempts {
        case 5:
            self.row1 = self.stringSplit(word: word)
        case 4:
            self.row2 = self.stringSplit(word: word)
        case 3:
            self.row3 = self.stringSplit(word: word)
        case 2:
            self.row4 = self.stringSplit(word: word)
        case 1:
            self.row5 = self.stringSplit(word: word)
        case 0:
            self.row6 = self.stringSplit(word: word)
        default:
            print("gdfgsdf")
        }
    }
    
    private func stringSplit(word: String) -> [String] {
        var splitStringArray: [String] = []
        
        for (index, letter) in word.enumerated() {
            guard index < 5 else { break }
            
            splitStringArray.append(String(letter))
        }
        
        return splitStringArray
    }
    
}

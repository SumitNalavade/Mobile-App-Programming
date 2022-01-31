import Foundation

class Game: CustomStringConvertible {    
    var correctWord : String? = nil
    var hint: String? = nil
    
    var remainingAttempts: Int = 6
    var remainingHints : Int = 1
    
    var row1: [Letter] = [Letter(), Letter(), Letter(), Letter(), Letter()]
    var row2: [Letter] = [Letter(), Letter(), Letter(), Letter(), Letter()]
    var row3: [Letter] = [Letter(), Letter(), Letter(), Letter(), Letter()]
    var row4: [Letter] = [Letter(), Letter(), Letter(), Letter(), Letter()]
    var row5: [Letter] = [Letter(), Letter(), Letter(), Letter(), Letter()]
    var row6: [Letter] = [Letter(), Letter(), Letter(), Letter(), Letter()]
    
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
        getOfficialWord { (word) in
            self.correctWord = word
            self.getWordDefinition({ (definition) in
                self.hint = definition
            }, word: word)
        }
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
            print("Add Word Error")
        }
    }
    
    private func stringSplit(word: String) -> [Letter] {
        var splitStringArray: [Letter] = []
                
        for (index, letter) in word.enumerated() {
            guard index < 5 else { break }
            var correct: Bool = false
            var wordContainsLetter : Bool = false
            
            if(self.correctWord![index] == letter) {
                correct = true
            } else if(self.correctWord!.contains(letter)) {
                wordContainsLetter = true
            }
                        
            splitStringArray.append(Letter(letter: String(letter), isCorrect: correct, inWord: wordContainsLetter))
        }
        
        return splitStringArray
    }
    
    private func getOfficialWord(_ completion: @escaping (String) -> ()) {
        
        let urlPath = "https://frontpage-exercises-chart-fairfield.trycloudflare.com/currentword"

        guard let url = URL(string: urlPath) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let results = jsonResult["word"] as! String
                    completion(results.lowercased())
                }
            } catch {
                
            }
        }
        task.resume()
    }
    
    private func getWordDefinition(_ completion: @escaping (String) -> (), word: String) {
        let urlString = "https://owlbot.info/api/v4/dictionary/\(word)"
        let session = URLSession.shared
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)

        request.addValue("Token d933fb9d92440b3aa667ef2b4b02079fda4500c2", forHTTPHeaderField: "Authorization")

        session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let data = data
            {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    
                    if(json?["definitions"] == nil) {
                        completion("No definition avalible")
                        return
                    }
                    
                    completion(((json!["definitions"] as! NSArray)[0] as! NSDictionary)["definition"] as! String)
                } catch {
                    print(error)
                }
            }
        }).resume()
    }
    
    
}

//
//  ViewController.swift
//  TicTacToe
//
//  Created by Sumit Nalavade on 9/28/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     1. Sets the game mode from the home screen.
        Game mode 0 = Single player (computer)
        Game mode 1 = Multiplayer
     */
    var gameMode : Int = -1
        
    /*
    2. Outlets for various components on screen
     */
    @IBOutlet weak var gridImage: UIImageView!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
        
    @IBOutlet var buttonsCollection: [UIButton]!
        
    /*
     3. Creates the initial game board.
        2D array with strings of index values
     */
    var gameBoard = [
        ["0", "1", "2"],
        ["3", "4", "5"],
        ["6", "7", "8"]
    ]
    
    /*
     4. Sets up the player struct
     */
    struct Player {
        let playerIcon : String
        var playerNumber : Int
        var score : Int
        
        mutating func incrementPlayerScore () {
            self.score += 1
        }
    }

    var player1 = Player(playerIcon: "X", playerNumber: 1, score : 0)
    var player2 = Player(playerIcon: "O", playerNumber: 2, score : 0)
    
    var currentPlayer = Player(playerIcon: "G", playerNumber: -1, score : 0)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPlayer = player1
        
        player1ScoreLabel.text = String(player1.score)
        player2ScoreLabel.text = String(player2.score)
        
    }

    /*
     5. Responder for the individual buttons on the Tic-Tac-Toe Board
        Calls the changeButtonIcon function by sending the tag value of the button that was pressed
        If game mode is set to 0 (Single player), calls the compMove function to make the computer make a move
     */
    @IBAction func buttonPressed(_ sender: UIButton) {
        if (sender.title(for: .normal) == "Blank") {
            
            changeButtonIcon(tagValue: sender.tag)
                     
            if(gameMode == 0) {
                for buttons in buttonsCollection {
                    if(buttons.currentTitle! == "Blank" && buttons.tag != sender.tag) {
                        compMove()
                        break
                    }
                }
            }
        }
    }
    
    /*
     6. Calls the getCompMove function to get the index of the 2D array where to place the icon
        Calls the changeButtonIcon function with the value of getCompMove
     */
    func compMove () {
        getCompMove { (array) in
            self.changeButtonIcon(tagValue: array)
        }
    }
        
    /*
     7. Takes in the index of the 2D array in which to change the value of
        Changes the value of the 2D array to the current player's icon
        Changes the on screen button title to the current player's icon
     */
    @objc func changeButtonIcon (tagValue : Int) {
        for (index, i) in gameBoard.enumerated() {
            for j in 0..<i.count {
                if(i[j] == String(tagValue)) {
                    gameBoard[index][j] = currentPlayer.playerIcon
                }
            }
        }
        
        DispatchQueue.main.async {
            for buttons in self.buttonsCollection {
                if(buttons.tag == tagValue) {
                    buttons.setTitle(self.currentPlayer.playerIcon, for: .normal)
                    buttons.setTitleColor(.systemGreen, for: .normal)
                }
            }
            
            self.checkWin()
            
            if(self.currentPlayer.playerNumber == 1) {
                self.currentPlayer = self.player2
            } else {
                self.currentPlayer = self.player1
            }
        }
        
    }
    
    /*
     8.
        Converts the 2D array into a string to be passed into the Tic-Tac-Toe API
        Ex : ---O---X-/O is a valid string which means There is an 0 in the left middle (3rd spot) and an X in the 7th spot. The next player is O
        Read more: https://github.com/stujo/tictactoe-api
     */
    func getGameState () -> String {
        var currGameState : String = ""
        
        for i in gameBoard {
            for j in i {
                if(j != "X" && j != "O") {
                    currGameState += "-"
                } else {
                    currGameState += j
                }
            }
        }
        
        currGameState += "/\(currentPlayer.playerIcon)"
        
        return currGameState
    }
    
    /*
     9. Requests the Tic-Tac-Toe API (https://github.com/stujo/tictactoe-api) and returns the index of the next move the computer should make
        Takes in the value from getGameState and sends it to the API to get a response
     */
    func getCompMove(_ completion: @escaping (NSInteger) -> ()) {
        
        let gameState = getGameState()

        let urlPath = "https://tttapi.herokuapp.com/api/v1/\(gameState)"

        guard let url = URL(string: urlPath) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let results = jsonResult["recommendation"] as! NSInteger
                    completion(results)
                }
            } catch {
                
            }
        }
        task.resume()
    }
    
    /*
     10. Iterates through the 2D array to check the horizontal and vertical values for if they are the same icon.
        Hard coded the diagonal check
        Iteration through the array eliminates multiple if statements and makes code more concise
     */
    @objc func checkWin () {
        //Horizontal Check
        for i in gameBoard {
            if(i[0] == i[1] && i[1] == i[2]) {
                winner(playerNum: currentPlayer.playerNumber)
            }
        }
        
        //Vertical Check
        for i in 0..<gameBoard[0].count {
            if(gameBoard[0][i] == gameBoard[1][i] && gameBoard[1][i] == gameBoard[2][i]) {
                winner(playerNum: currentPlayer.playerNumber)
            }
        }
        
        //Diagonal Check
        if(gameBoard[0][0] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[2][2]) {
            winner(playerNum: currentPlayer.playerNumber)
        }
        if(gameBoard[0][2] == gameBoard[1][1] && gameBoard[1][1] == gameBoard[2][0]) {
            winner(playerNum: currentPlayer.playerNumber)
        }
        
        for i in 0..<buttonsCollection.count {
            if(i == 8 && !(buttonsCollection[i].title(for: .normal) == "Blank")) {
                winner(playerNum: 3)
            }
            
            if(buttonsCollection[i].title(for: .normal) == "Blank") {
                break
            }
        }
        
    }
    
    /*
     11. Called if the checkWin function detects a win.
        Congratulates which ever player won and alerts the user if they want to play a new game -> calls the reset function
     */
    @objc func winner (playerNum : Int) {
        var message : String
        
        if(playerNum == 1) {
            player1.incrementPlayerScore()
            player1ScoreLabel.text = String(player1.score)
            message = "Player 1 Wins!"
        } else if (playerNum == 2) {
            player2.incrementPlayerScore()
            player2ScoreLabel.text = String(player2.score)
            message = "Computer Wins!"
        } else {
            message = "Draw!"
        }
        
        let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            self.reset()
        }))

        self.present(alert, animated: true)
    }
    
    /*
     12. Resets the gameboard to the initial state and changes the on screen button title to blank
     */
    @objc func reset () {
           gameBoard = [
               ["0", "1", "2"],
               ["3", "4", "5"],
               ["6", "7", "8"]
           ]
           
           currentPlayer = player1
           
           for buttons in buttonsCollection {
               buttons.setTitle("Blank", for: .normal)
               buttons.setTitleColor(view.backgroundColor, for: .normal)
           }
       }
    
    }



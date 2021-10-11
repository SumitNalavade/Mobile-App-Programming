//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Sumit Nalavade on 9/30/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import Foundation

struct TicTacToe : Codable {
    let game : String
    let player : String
    let recommendation : Int
    let strength : Int
}

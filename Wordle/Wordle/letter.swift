//
//  letter.swift
//  Wordle
//
//  Created by Sumit Nalavade on 1/30/22.
//  Copyright © 2022 Sumit Nalavade. All rights reserved.
//

import Foundation

//Letter struct defines a type that represents each letter in a potential guess
//A Letter is represented by a String
//isCorrect is true if the letter is in the right position in the full word
//inWord is true if the letter is supposed to exist in the word
struct Letter {
    var letter: String = ""
    var isCorrect: Bool = false
    var inWord : Bool = false
}

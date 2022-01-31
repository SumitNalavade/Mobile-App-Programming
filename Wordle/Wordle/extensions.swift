//
//  extensions.swift
//  Wordle
//
//  Created by Sumit Nalavade on 1/30/22.
//  Copyright © 2022 Sumit Nalavade. All rights reserved.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

//
//  Helpers.swift
//  project
//
//  Created by Mohammad Bitar on 9/25/20.
//

import UIKit

class Helpers {
    
    static func isIpad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        return false
    }
    
    public static func min(_ numbers: Int...) -> Int {
        return numbers.reduce(numbers[0]) { $0 < $1 ? $0 : $1 }
    }
}

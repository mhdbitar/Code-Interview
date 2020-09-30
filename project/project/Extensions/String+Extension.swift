//
//  String+Extension.swift
//  project
//
//  Created by Mohammad Bitar on 9/29/20.
//

import UIKit

extension String {
    
    // "LevenshteinDistance" algorithm to calculate the distance between two string
    func levenshteinDistance(bString: String) -> Int {
        let a = Array(self.utf16)
        let b = Array(bString.utf16)

        if a.count == 0 || b.count == 0 { return 0 }

        let dist = Array2D(cols: a.count + 1, rows: b.count + 1)

        for i in 1...a.count {
            dist[i, 0] = i
        }

        for j in 1...b.count {
            dist[0, j] = j
        }

        for i in 1...a.count {
            for j in 1...b.count {
                if a[i-1] == b[j-1] {
                    dist[i, j] = dist[i-1, j-1]
                } else {
                    dist[i, j] = Helpers.min(
                        dist[i-1, j] + 1, // deletion
                        dist[i, j-1] + 1, // insertion
                        dist[i-1, j-1] + 1 // substitution
                    )
                }
            }
        }

        let distance = dist[a.count, b.count]
        let maxNumber = max(a.count, b.count)
        let div: Float = Float(distance) / Float(maxNumber)
        let result: Int = Int((1 - div) * 100)
        return result
    }
}

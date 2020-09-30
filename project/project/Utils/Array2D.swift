//
//  Array2D.swift
//  project
//
//  Created by Mohammad Bitar on 9/29/20.
//

import Foundation

class Array2D {

    var cols: Int
    var rows: Int
    var matrix: [Int]

    init(cols: Int, rows: Int) {
        self.cols = cols
        self.rows = rows
        matrix = Array(repeating: 0, count: cols * rows)
    }

    subscript(col: Int, row: Int) -> Int {
        get { return matrix[cols * row + col] }
        set { matrix[cols * row + col] = newValue }
    }

    func colCount() -> Int {
        return self.cols
    }

    func rowCount() -> Int {
        return self.rows
    }
}

//
//  GenElement.swift
//
//  Created by M on 01.12.2021.
//

import Foundation

struct GenElement {
    let deg: Int
    let items: [Int]
    let matrix: Matrix

    var gen: Gen? {
        let im = ImMatrix(mult: matrix)
        return im.rows.isEmpty ? nil : Gen(label: "\(items)", deg: deg, elem: im.rows[0])
    }
}

extension Array where Element == Int {
    func d3HasSubarray(_ arr: [Int]) -> Bool {
        var i = 0
        for a in self {
            if a == arr[i] {
                i += 1
                if i == arr.count { return true }
            }
        }
        return false
    }
}

extension Array where Element == GenElement {
    func d3Contains(_ arr: [Int]) -> Bool {
        for g in self {
            if g.items.count == arr.count {
                var same = true
                for i in 0 ..< g.items.count {
                    if g.items[i] != arr[i] { same = false; break }
                }
                if same { return true }
            }
        }
        return false
    }
}

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
        return GenElement.gen(for: matrix, deg: deg, label: "\(items)")

    }

    static func gen(for matrix: Matrix, deg: Int, label: String = "G") -> Gen? {
        let im = ImMatrix(mult: matrix)
        return im.rows.isEmpty ? nil : Gen(label: label, deg: deg, elem: im.rows[0])
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

    func d3Equal(_ arr: [Int]) -> Bool {
        if count != arr.count { return false }
        for i in 0 ..< count {
            if self[i] != arr[i] { return false }
        }
        return true
    }

    mutating func d3Add(_ n: Element) {
        for j in 0 ..< count {
            if self[j] > n {
                insert(n, at: j)
                return
            }
        }
        append(n)
    }

    mutating func d3Replace(_ arr1: [Int], to arr2: [Int]) {
        for a in arr1 { remove(at: firstIndex(where: { $0 == a })!) }
        arr2.forEach { d3Add($0) }
    }
}

extension Array where Element == GenElement {
    func d3Contains(_ arr: [Int]) -> Bool {
        return contains { $0.items.d3Equal(arr) }
    }
}

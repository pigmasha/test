//
//  Gen.swift
//
//  Created by M on 11.11.2021.
//

import Foundation

final class Gen {
    let label: String
    let deg: Int
    let elem: [Element]

    init(label: String, deg: Int, elem: [Element]) {
        self.label = label
        self.deg = deg
        self.elem = elem.map { Element(element: $0) }
    }

    init?(sum g1: Gen, and g2: Gen, koef: Int) {
        if g1.deg != g2.deg { return nil }
        self.label = g1.label + " + " + g2.label
        self.deg = g1.deg
        var arr: [Element] = []
        for i in 0 ..< g1.elem.count {
            let e = Element(element: g1.elem[i])
            e.add(element: g2.elem[i])
            arr.append(e)
        }
        self.elem = arr
    }

    private func label(from s: String) -> String {
        let parts = s.components(separatedBy: " * ")
        if parts.count < 3 || parts[0] != parts[1] { return s }
        for i in 2 ..< parts.count {
            if parts[i] != parts[0] {
                var s1 = parts[0] + Utils.supStr("\(i)")
                for j in i ..< parts.count { s1 += " * " + parts[j] }
                return s1
            }
        }
        return s
    }

    func eqKoef(_ other: Gen) -> Int {
        guard elem.count == other.elem.count else { return 0 }
        return elem.eqKoef(other.elem)
    }

    var str: String {
        let s = elem.map { $0.str }.joined(separator: ", ")
        let s1 = PathAlg.isTex ? "$" : ""
        return s1 + "Gen \(deg): "  + label(from: label) + " = (" + s + ")" + s1
    }
}

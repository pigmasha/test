//
//  Gen.swift
//
//  Created by M on 11.11.2021.
//

import Foundation

final class Gen {
    let label: String
    let deg: Int
    let elem: [(Int, Way)]

    init(label: String, deg: Int, elem: [(Int, Way)]) {
        self.label = label
        self.deg = deg
        self.elem = elem
    }

    private func label(from s: String) -> String {
        let parts = s.components(separatedBy: " * ")
        if parts.count < 3 { return s }
        for i in 2 ..< parts.count {
            if parts[i] != parts[0] {
                var s1 = parts[0] + "<sup>\(i)</sup>"
                for j in i ..< parts.count { s1 += " * " + parts[j] }
                return s1
            }
        }
        return s
    }

    func eqKoef(_ other: Gen) -> Int {
        guard elem.count == other.elem.count else { return 0 }
        var kk = 0
        for i in 0 ..< elem.count {
            let k1 = elem[i].0
            let k2 = other.elem[i].0
            if k1 == 0 && k2 == 0 { continue }
            if k1 == 0 || k2 == 0 || !elem[i].1.isEq(other.elem[i].1) || k1 % k2 != 0 { return 0 }
            let k = k1 / k2
            if k == 0 { return 0 }
            if kk > 0 && k != kk { return 0 }
            kk = k
        }
        return kk
    }

    var str: String {
        var s = ""
        var zeroSz = 0
        for e in elem {
            if e.0 == 0 {
                zeroSz += 1
            } else {
                if zeroSz != 0 {
                    if s != "" { s += ", " }
                    s += (zeroSz == 1) ? "0" : "O<sub>\(zeroSz)</sub>"
                    zeroSz = 0
                }
                if s != "" { s += ", " }
                s += (e.0 == 1 ? "" : (e.0 == -1 ? "-" : "\(e.0)")) + e.1.str

            }
        }
        if zeroSz != 0 {
            if s != "" { s += ", " }
            s += (zeroSz == 1) ? "0" : "O<sub>\(zeroSz)</sub>"
        }
        return "Gen \(deg): "  + label(from: label) + " = (" + s + ")"
    }
}

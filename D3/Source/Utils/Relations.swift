//
//  Relations.swift
//
//  Created by M on 01.12.2021.
//

import Foundation

struct Relations {
    private static func multMatrix(_ e1: Gen, and e2: Gen) -> Matrix? {
        var s2 = ShiftHH(gen: e2, shiftDeg: 0).matrix
        if s2.isZero { s2 = ShiftHH(gen: e2).matrix }
        let s1 = ShiftHH(gen: e1, shiftDeg: e2.deg).matrix
        if !s1.isZero { return Matrix(mult: s2, and: s1) }
        let s12 = ShiftHH(gen: e1, shiftDeg: 0).matrix
        let s22 = ShiftHH(gen: e2, shiftDeg: e1.deg).matrix
        return s12.isZero || s22.isZero ? nil : Matrix(mult: s12, and: s22)
    }

    private static func zeroGens() -> [String: Int] {
        let relations = self.zeroRelations
        var zeroGens: [String: Int] = [:]
        for r in relations {
            if r.count == 1 { zeroGens[r[0]] = 1 }
        }
        return zeroGens
    }

    static func checkOrder(labels: [String], _ orderMap: [String: Int]) -> Bool {
        if labels.count < 2 { return true }
        for i in 1 ..< labels.count {
            if orderMap[labels[i - 1]]! > orderMap[labels[i]]! {
                OutputFile.writeLog(.error, "Bad \(labels)")
                return false
            }
        }
        return true
    }

    static func multGens(labels: [String], checkZero: Bool, _ orderMap: [String: Int], _ gensMap: [String: Gen]) -> (Int, Matrix)? {
        for l in labels { if orderMap[l] == nil { return nil } }
        if !checkOrder(labels: labels, orderMap) { return nil }

        var j = -1
        for i in 0 ..< labels.count {
            if labels[i] != "c12" && labels[i] != "c23" && labels[i] != "c31" { j = i; break }
        }
        if j == -1 { j = labels.count - 1 }
        //if j != labels.count - 1 && j != labels.count - 2 { return nil }
        var matrix: Matrix
        let deg: Int
        if j == labels.count - 1 {
            let g1 = gensMap[labels[j]]!
            (matrix, deg) = (ShiftHH(gen: g1, shiftDeg: 0).matrix, g1.deg)
        } else if j == labels.count - 2 {
            let (g1, g2) = (gensMap[labels[j]]!, gensMap[labels[j + 1]]!)
            (matrix, deg) = (multMatrix(g1, and: g2)!, g1.deg + g2.deg)
        } else {
            var labels0: [String] = []
            for i in j ..< labels.count { labels0.append(labels[i]) }
            if labels0.last! == "u1" || labels0.last! == "u2" {
                labels0.insert(labels0.last!, at: 0)
                _ = labels0.popLast()
                //OutputFile.writeLog(.normal, "\(labels) to \(labels0)")
            }
            let g1 = gensMap[labels0[0]]!
            var d = g1.deg
            var m = ShiftHH(gen: g1, shiftDeg: 0).matrix
            if m.isZero { return nil }
            for i in 1 ..< labels0.count {
                let g2 = gensMap[labels0[i]]!
                let m1 = ShiftHH(gen: g2, shiftDeg: d).matrix
                if m1.isZero { return nil }
                d += g2.deg
                m = Matrix(mult: m, and: m1)
                if m.isNil { OutputFile.writeLog(.error, "Nil matrix \(labels)"); return nil }
            }
            (matrix, deg) = (m, d)
        }
        let checker = GenCreate(deg: deg)
        for i in 0 ..< j {
            if checkZero && matrix.isZero { OutputFile.writeLog(.error, "Zero matrix \(labels)"); return nil }
            if checkZero && deg > 0 {
                let g0 = Gen(label: "C", deg: deg, elem: ImMatrix(mult: matrix).rows[0])
                if checker.checkNotIm(g0, inIm: true) == nil { OutputFile.writeLog(.error, "In Im \(labels), i=\(i)"); return nil }
            }
            matrix = Matrix(mult: matrix, and: ShiftHH(gen: gensMap[labels[i]]!, shiftDeg: deg).matrix)
            if matrix.isNil { OutputFile.writeLog(.error, "Nil matrix \(labels)"); return nil }
        }
        return (deg, matrix)
    }

    static func checkZeroRelations(_ orderMap: [String: Int], _ gensMap: [String: Gen]) -> Bool {
        let relations = self.zeroRelations
        let zeroGens = zeroGens()
        for r in relations {
            if r.count == 1 {
                if gensMap[r[0]] != nil { return false }
                if zeroGens[r[0]] == nil { return false }
                continue
            }
            if r.contains(where: { zeroGens[$0] != nil }) { continue }
            guard let (deg, matrix) = multGens(labels: r, checkZero: true, orderMap, gensMap) else { return false }
            if matrix.isZero { continue }
            if deg == 0 { return false }
            let im = ImMatrix(mult: matrix)
            if im.rows.isEmpty { continue }
            let g0 = Gen(label: "C", deg: deg, elem: im.rows[0])
            if GenCreate(deg: deg).checkNotIm(g0, inIm: true, log: false) != nil {
                OutputFile.writeLog(.error, "Not in Im \(r): " + g0.str)
                return false
            }
        }
        return true
    }

    static func checkRelations(_ orderMap: [String: Int], _ gensMap: [String: Gen]) -> Bool {
        let zeroGens = zeroGens()
        let relations = self.relations
        let processMult: ([String]) -> (Matrix, Int)? = { pp in
            for p in pp { if gensMap[p] == nil { return nil } }
            if !checkOrder(labels: pp, orderMap) { return nil }
            let g1 = gensMap[pp[0]]!
            var matrix = ShiftHH(gen: g1, shiftDeg: 0).matrix
            var deg = g1.deg
            for i in 1 ..< pp.count {
                let g2 = gensMap[pp[i]]!
                let shift = ShiftHH(gen: g2, shiftDeg: deg).matrix
                if shift.isZero { return nil }
                matrix = Matrix(mult: matrix, and: shift)
                deg += g2.deg
                if matrix.isNil { OutputFile.writeLog(.error, "Nil matrix \(pp)"); return nil }
            }
            return (matrix, deg)
        }
        for (m1, m2, _, k) in relations {
            let p1 = m1.components(separatedBy: " * ")
            let p2 = m2.components(separatedBy: " * ")
            if p1.contains(where: { zeroGens[$0] != nil }) || p2.contains(where: { zeroGens[$0] != nil }) { continue }
            guard let (mult1, deg1) = processMult(p1), let (mult2, deg2) = processMult(p2) else { return false }
            if deg1 != deg2 { return false }
            mult1.add(mult2, koef: -k)
            if mult1.isZero { continue }
            let im = ImMatrix(mult: mult1)
            if im.rows.isEmpty { continue }
            let g0 = Gen(label: "C", deg: deg1, elem: im.rows[0])
            if GenCreate(deg: deg1).checkNotIm(g0, inIm: true) != nil {
                OutputFile.writeLog(.error, "Not in Im \(m1)")
                return false
            }
        }
        return true
    }

    static func zeroRelations(_ orderMap: [String: Int]) -> [[Int]] {
        return zeroRelations.map { r in
            r.map { orderMap[$0]! }
        }
    }

    static func relations(_ orderMap: [String: Int]) -> [([Int], [Int])] {
        return relations.map { m1, m2, _, _ in
            return (m1.components(separatedBy: " * ").map { orderMap[$0]! },
                    m2.components(separatedBy: " * ").map { orderMap[$0]! })
        }
    }

    private static var zeroRelations: [[String]] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let c12_n3_1 = n3 == 1 ? [] : (0 ..< n3 - 1).map { _ in "c12" }
        let c23_n1_1 = n1 == 1 ? [] : (0 ..< n1 - 1).map { _ in "c23" }
        let c31_n2_1 = n2 == 1 ? [] : (0 ..< n2 - 1).map { _ in "c31" }
        var relations = [
            // 0
            ["c12", "c23"], ["c23", "c31"], ["c12", "c31"],
            c12_n3_1 + ["c12", "c12"], c23_n1_1 + ["c23", "c23"], c31_n2_1 + ["c31", "c31"],
            // 1
            ["c12", "z1"], ["c23", "z1"], ["c31", "z1"]
        ]
        if NumInt.isZero(n: n1) {
            relations += [
                ["c12", "w23"], c23_n1_1 + ["c23", "w23"], ["c31", "w23"],
                c12_n3_1 + ["x1"], ["c23", "x1"], ["c31", "x1"],
                ["c12", "x3"], ["c23", "x3"], c31_n2_1 + ["x3"]
            ]
        } else {
            relations += [c12_n3_1 + ["c12", "w"], c23_n1_1 + ["c23", "w"], c31_n2_1 + ["c31", "w"]]
        }
        relations += [
            // 2
            c12_n3_1 + ["x12"], c23_n1_1 + ["x23"], c31_n2_1 + ["x31"],
            ["c23", "x12"], ["c31", "x12"], ["c12", "x23"], ["c31", "x23"], ["c12", "x31"], ["c23", "x31"],
            ["z1", "z1"]
        ]
        if NumInt.isZero(n: n1) {
            relations += [
                ["c12", "q"], ["c23", "q"], ["c31", "q"],
                ["z1", "w23"], ["z1", "x1"], ["z1", "x3"],
                ["w23", "w23"], ["w23", "x1"], ["w23", "x3"], ["x1", "x1"], ["x1", "x3"], ["x3", "x3"]
            ]
        } else {
            relations += [["w", "w"]]
        }
        relations += [
            ["c12", "u1"], ["c23", "u1"], ["c31", "u1"], ["c12", "u2"], ["c23", "u2"], ["c31", "u2"],
            // 3
            ["z1", "x12"], ["z1", "x23"], ["z1", "x31"]
        ]
        if NumInt.isZero(n: n1) {
            relations += [
                ["c12", "w23_h"], c23_n1_1 + ["c23", "w23_h"], ["c31", "w23_h"],
                c12_n3_1 + ["x1_h"], ["c23", "x1_h"], ["c31", "x1_h"],
                ["c12", "x3_h"], ["c23", "x3_h"], c31_n2_1 + ["x3_h"],
                ["z1", "q"],
                ["w23", "x12"], ["w23", "x31"], ["w23", "u1"], ["w23", "q"],
                ["x1", "x23"], ["x1", "x31"], ["x1", "u1"], ["x1", "u2"], ["x1", "q"],
                ["x3", "x12"], ["x3", "x23"], ["x3", "u1"], ["x3", "u2"], ["x3", "q"],
            ]
        } else {
            relations += [["w", "u1"]]
        }
        relations += [
            // 4
            ["x12", "u1"], ["x23", "u1"], ["x31", "u1"], ["x12", "u2"], ["x23", "u2"], ["x31", "u2"],
            c12_n3_1 + ["c12", "e"]
        ]
        if NumInt.isZero(n: n1) {
            relations += [
                ["z1", "w23_h"], ["z1", "x1_h"], ["z1", "x3_h"],
                ["w23", "w23_h"], ["w23", "x1_h"], ["w23", "x3_h"],
                ["x1", "w23_h"], ["x1", "x1_h"], ["x1", "x3_h"],
                ["x3", "w23_h"], ["x3", "x1_h"], ["x3", "x3_h"],
                ["x12", "q"], ["x23", "q"], ["x31", "q"], ["u1", "q"], ["u2", "q"], ["q", "q"]
            ]
        } else {
            relations += [c23_n1_1 + ["c23", "e"]]
        }
        relations += [
            c31_n2_1 + ["c31", "e"],
            ["x12", "x23"], ["x23", "x31"], ["x12", "x31"],
            ["u1", "u1"], ["u2", "u2"], ["u1", "u2"]
        ]
        // 5
        if NumInt.isZero(n: n1) {
            relations += [
                ["w23_h", "x12"], ["w23_h", "x31"], ["w23_h", "u1"], ["w23_h", "u2"], ["w23_h", "q"],
                ["x1_h", "x23"], ["x1_h", "x31"], ["x1_h", "u1"], ["x1_h", "u2"], ["x1_h", "q"],
                ["x3_h", "x12"], ["x3_h", "x23"], ["x3_h", "u1"], ["x3_h", "u2"], ["x3_h", "q"]
            ]
        }
        relations += [
            // 6
            ["e", "u1"], ["e", "u2"],
            ["c12", "e1_h"], ["c23", "e1_h"], ["c31", "e1_h"], ["c12", "e2_h"], ["c23", "e2_h"], ["c31", "e2_h"]
        ]
        if NumInt.isZero(n: n1) {
            relations += [
                ["w23_h", "w23_h"], ["w23_h", "x1_h"], ["w23_h", "x3_h"],
                ["x1_h", "x1_h"], ["x1_h", "x3_h"], ["x3_h", "x3_h"],
                // 7
                ["w23", "e1_h"],
                ["x1", "e1_h"], ["x1", "e2_h"],
                ["x3", "e1_h"], ["x3", "e2_h"],
                ["c12", "u1_h"], ["c23", "u1_h"], ["c31", "u1_h"],
                ["c12", "u2_h"], ["c23", "u2_h"], ["c31", "u2_h"]
            ]
        }
        relations += [
            // 8
            ["e1_h", "x12"], ["e1_h", "x23"], ["e1_h", "x31"], ["e2_h", "x12"], ["e2_h", "x23"], ["e2_h", "x31"],
            ["e2_h", "u1"], ["e1_h", "u2"]
        ]
        if NumInt.isZero(n: n1) {
            relations += [
                ["w23", "u1_h"], ["x1", "u1_h"], ["x1", "u2_h"], ["x3", "u1_h"], ["x3", "u2_h"],
                // 9
                ["x12", "u1_h"], ["x12", "u2_h"], ["x23", "u1_h"], ["x23", "u2_h"], ["x31", "u1_h"], ["x31", "u2_h"],
                ["u1", "u1_h"], ["u1", "u2_h"], ["u2", "u1_h"], ["u2", "u2_h"], ["u1_h", "q"], ["u2_h", "q"],
                ["w23_h", "e1_h"], ["w23_h", "e2_h"], ["x1_h", "e1_h"], ["x1_h", "e2_h"], ["x3_h", "e1_h"], ["x3_h", "e2_h"],
                // 10
                ["w23_h", "u1_h"], ["w23_h", "u2_h"], ["x1_h", "u1_h"], ["x1_h", "u2_h"], ["x3_h", "u1_h"], ["x3_h", "u2_h"],
                // 13
                ["e1_h", "u2_h"], ["e2_h", "u1_h"],
                // 14
                ["u1_h", "u1_h"], ["u1_h", "u2_h"], ["u1_h", "u2_h"], ["u2_h", "u2_h"]
            ]
        }
        if PathAlg.N > 3 {
            // 12
            relations += [["e1_h", "e2_h"]]
        }
        return relations
    }

    private static var relations: [(String, String, String, Int)] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        var relations: [(String, String, String, Int)] = []
        // 3
        if NumInt.isZero(n: n1) {
            relations += [
                ("w23 * x23", "c23 * w23_h", "-1", -1),
                ("w23 * u2", "z1 * u2", "1", 1),
                ("x1 * x12", "c12 * x1_h", "-1", -1),
                ("x3 * x31", "c31 * x3_h", "-1", -1)
            ]
        } else {
            relations += [("w * u2", "z1 * u2", "(n1*n2+n2*n3+n3*n1)", n1 * n2 + n2 * n3 + n3 * n1)]
        }
        relations += [
            // 4
            ("x12 * x12", "c12 * c12 * e", "-1", -1),
            ("x23 * x23", "c23 * c23 * e", "-1", -1),
            ("x31 * x31", "c31 * c31 * e", "-1", -1)
        ]
        if NumInt.isZero(n: n1) {
            relations += [
                // 5
                ("w23_h * x23", "c23 * w23 * e", "1", 1),
                ("x1_h * x12", "c12 * x1 * e", "1", 1),
                ("x3_h * x31", "c31 * x3 * e", "1", 1),
                // 7
                ("w23 * e2_h", "z1 * e2_h", "1", 1),
                // 8
                ("w23 * u2_h", "z1 * u2_h", "1", 1),
                ("e1_h * q", "z1 * u1_h", "-1", -1),
                ("e2_h * q", "z1 * u2_h", "1", 1)
            ]
        }
        if PathAlg.N == 3 {
            // 12
            relations += [("e1_h * e2_h", "e * e * e", "", 1)]
        }
        return relations
    }
}

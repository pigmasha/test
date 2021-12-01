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
            if GenCreate(deg: deg).checkNotIm(g0, inIm: true) != nil {
                OutputFile.writeLog(.error, "Not in Im \(r)")
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
        let c12_n3_1 = PathAlg.n3 == 1 ? [] : (0 ..< PathAlg.n3 - 1).map { _ in "c12" }
        let c23_n1_1 = PathAlg.n1 == 1 ? [] : (0 ..< PathAlg.n1 - 1).map { _ in "c23" }
        let c31_n2_1 = PathAlg.n2 == 1 ? [] : (0 ..< PathAlg.n2 - 1).map { _ in "c31" }
        return [
            // 0
            ["c12", "c23"], ["c23", "c31"], ["c12", "c31"],
            c12_n3_1 + ["c12", "c12"], c23_n1_1 + ["c23", "c23"], c31_n2_1 + ["c31", "c31"],
            // 1
            ["c12", "z1"], ["c23", "z1"], ["c31", "z1"],
            c12_n3_1 + ["c12", "w"], c23_n1_1 + ["c23", "w"], c31_n2_1 + ["c31", "w"],
            // 2
            c12_n3_1 + ["x12"], c23_n1_1 + ["x23"], c31_n2_1 + ["x31"],
            ["c23", "x12"], ["c31", "x12"], ["c12", "x23"], ["c31", "x23"], ["c12", "x31"], ["c23", "x31"],
            ["z1", "z1"], ["w", "w"],
            ["c12", "u1"], ["c23", "u1"], ["c31", "u1"], ["c12", "u2"], ["c23", "u2"], ["c31", "u2"],
            // 3
            ["z1", "x12"], ["z1", "x23"], ["z1", "x31"], ["w", "u1"],
            // 4
            ["x12", "u1"], ["x23", "u1"], ["x31", "u1"], ["x12", "u2"], ["x23", "u2"], ["x31", "u2"],
            c12_n3_1 + ["c12", "e"], c23_n1_1 + ["c23", "e"], c31_n2_1 + ["c31", "e"],
            ["x12", "x23"], ["x23", "x31"], ["x12", "x31"],
            ["u1", "u1"], ["u2", "u2"], ["u1", "u2"],
            // 6
            ["e", "u1"], ["e", "u2"],
            ["c12", "e1"], ["c23", "e1"], ["c31", "e1"], ["c12", "e2"], ["c23", "e2"], ["c31", "e2"],
            // 8
            ["e1", "x12"], ["e1", "x23"], ["e1", "x31"], ["e2", "x12"], ["e2", "x23"], ["e2", "x31"],
            ["e2", "u1"], ["e1", "u2"]
        ] + (PathAlg.N == 3 ? [] : [["e1", "e2"]]) // 12
    }

    private static var relations: [(String, String, String, Int)] {
        return [
            ("w * u2", "z1 * u2", "(n1*n2+n2*n3+n3*n1)", PathAlg.n1 * PathAlg.n2 + PathAlg.n2 * PathAlg.n3 + PathAlg.n3 * PathAlg.n1),
            ("x12 * x12", "c12 * c12 * e", "-1", -1),
            ("x23 * x23", "c23 * c23 * e", "-1", -1),
            ("x31 * x31", "c31 * c31 * e", "-1", -1)
        ] + (PathAlg.N == 3 ? [("e1 * e2", "e * e * e", "", 1)] : []) // 12
    }
}

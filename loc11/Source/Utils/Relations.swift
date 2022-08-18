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
        let sumRelations = self.sumRelations
        for r in sumRelations {
            if r.0.count == 1 { zeroGens[r.0[0]] = 1 }
        }
        return zeroGens
    }

    static func checkOrder(labels: [String], _ orderMap: [String: Int]) -> Bool {
        if labels.count < 2 { return true }
        for i in 1 ..< labels.count {
            if orderMap[labels[i - 1]]! > orderMap[labels[i]]! {
                OutputFile.writeLog(.error, "checkOrder: bad order \(labels)")
                return false
            }
        }
        return true
    }

    static func multGens(labels: [String], checkZero: Bool, _ orderMap: [String: Int], _ gensMap: [String: Gen]) -> (Int, Matrix)? {
        if labels.contains(where: { orderMap[$0] == nil }) {
            OutputFile.writeLog(.error, "Unknown gens in \(labels)")
            return nil
        }
        if !checkOrder(labels: labels, orderMap) { return nil }

        let shiftedLabels = ["v1", "v2"]
        let orderedLabels = labels.filter { !shiftedLabels.contains($0) } + labels.filter { shiftedLabels.contains($0) }

        let g1 = gensMap[orderedLabels[0]]!
        var deg = g1.deg
        var matrix = ShiftHH(gen: g1, shiftDeg: 0).matrix
        if matrix.isZero { return nil }
        for i in 1 ..< orderedLabels.count {
            let g2 = gensMap[orderedLabels[i]]!
            let m1 = ShiftHH(gen: g2, shiftDeg: deg).matrix
            if m1.isZero { return nil }
            deg += g2.deg
            matrix = Matrix(mult: matrix, and: m1)
            if matrix.isNil { OutputFile.writeLog(.error, "Nil matrix \(labels)"); return nil }
        }
        return (deg, matrix)
    }

    static func checkZeroRelations(all: Bool, _ orderMap: [String: Int], _ gensMap: [String: Gen]) -> Bool {
        let relations = self.zeroRelations
        let zeroGens = zeroGens()
        for r in relations {
            if r.count == 1 {
                if gensMap[r[0]] != nil {
                    return false
                }
                if zeroGens[r[0]] == nil {
                    return false
                }
                continue
            }
            if r.contains(where: { zeroGens[$0] != nil }) { continue }
            guard let (deg, matrix) = multGens(labels: r, checkZero: true, orderMap, gensMap) else {
                OutputFile.writeLog(.error, "Can't mult \(r)")
                return false
            }
            if matrix.isZero { continue }
            if deg == 0 { return false }
            if !matrixIsZero(matrix, deg: deg) {
                OutputFile.writeLog(.error, "checkZeroRelations: Not zero \(r)")
                return false
            }
        }
        return true
    }

    private static func processMult(_ pp: [String], _ orderMap: [String: Int], _ gensMap: [String: Gen]) -> (Matrix, Int)? {
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

    static func checkRelations(all: Bool, _ orderMap: [String: Int], _ gensMap: [String: Gen]) -> Bool {
        let zeroGens = zeroGens()
        let relations = self.relations
        for (p1, p2, _, k) in relations {
            if all && p1.contains(where: { gensMap[$0] == nil }) { continue }
            if all && p2.contains(where: { gensMap[$0] == nil }) { continue }
            if all && p1.contains(where: { $0 == "c12" || $0 == "c23" || $0 == "c31" })
                && p2.contains(where: { $0 == "c12" || $0 == "c23" || $0 == "c31" }) {
                continue
            }
            if p1.contains(where: { zeroGens[$0] != nil }) || p2.contains(where: { zeroGens[$0] != nil }) { continue }
            guard let (mult1, deg1) = processMult(p1, orderMap, gensMap) else {
                OutputFile.writeLog(.error, "checkRelations: can't mult \(p1)")
                return false
            }
            guard let (mult2, deg2) = processMult(p2, orderMap, gensMap) else {
                OutputFile.writeLog(.error, "checkRelations: can't mult \(p2)")
                return false
            }
            if deg1 != deg2 { return false }
            mult1.add(mult2, koef: -k)
            if !matrixIsZero(mult1, deg: deg1) {
                OutputFile.writeLog(.error, "checkRelations: Not zero \(p1)")
                return false
            }
        }
        return true
    }

    static func checkSumRelations(_ orderMap: [String: Int], _ gensMap: [String: Gen]) -> Bool {
        let relations = self.sumRelations
        let zeroGens = zeroGens()
        for (p, k1, p1, k2, p2) in relations {
            if p.contains(where: { zeroGens[$0] != nil }) { continue }
            guard let (mult, deg) = processMult(p, orderMap, gensMap),
                  let (mult1, deg1) = processMult(p1, orderMap, gensMap),
                  let (mult2, deg2) = processMult(p2, orderMap, gensMap) else { return false }
            if deg != deg1 || deg1 != deg2 { return false }
            mult.add(mult1, koef: -k1)
            mult.add(mult2, koef: -k2)
            if !matrixIsZero(mult, deg: deg) {
                OutputFile.writeLog(.error, "checkSumRelations: Not zero \(p) = \(p1) + \(p2)")
                return false
            }
        }
        return true
    }

    private static func matrixIsZero(_ m: Matrix, deg: Int, inImChecker: GenCreate? = nil) -> Bool {
        if m.isZero { return true }
        let im = ImMatrix(mult: m)
        if im.rows.isEmpty { return true }
        let g0 = Gen(label: "C", deg: deg, elem: im.rows[0])
        return (inImChecker ?? GenCreate(deg: deg)).checkNotIm(g0, inIm: true) == nil
    }

    static func zeroRelations(_ orderMap: [String: Int]) -> [[Int]] {
        return zeroRelations.map { r in
            r.map { orderMap[$0]! }
        }
    }

    static func relations(_ orderMap: [String: Int]) -> [([Int], [Int])] {
        return relations.map { m1, m2, _, _ in
            return (m1.map { orderMap[$0]! }, m2.map { orderMap[$0]! })
        }
    }

    static func sumRelations(_ orderMap: [String: Int]) -> [([Int], [Int], [Int])] {
        let items = sumRelations.map { m1, k1, m2, k2, m3 in
            return (m1.map { orderMap[$0]! },
                    NumInt.isZero(n: k1) ? [] : m2.map { orderMap[$0]! },
                    NumInt.isZero(n: k2) ? [] : m3.map { orderMap[$0]! })
        }
        return items
        + items.compactMap { m1, m2, m3 in m2.isEmpty ? nil : (m2, m1, m3) }
        + items.compactMap { m1, m2, m3 in m2.isEmpty ? nil : (m2, m3, m1) }
        + items.compactMap { m1, m2, m3 in m3.isEmpty ? nil : (m3, m1, m2) }
        + items.compactMap { m1, m2, m3 in m3.isEmpty ? nil : (m3, m2, m1) }
    }

    private static var zeroRelations: [[String]] {
        let k = PathAlg.kk
        var relations: [[String]] = []
        // 0
        relations += [
            (1 ... k).map { _ in "p1" },
            ["p1", "p2"], ["p1", "p3"], ["p1", "p4"],
            ["p2", "p2"], ["p2", "p3"], ["p2", "p4"],
            ["p3", "p3"], ["p3", "p4"], ["p4", "p4"],
        ]
        // 1
        relations += [
            ["p1", "u2"], ["p4", "u2"],
            ["p1", "u3"], ["p2", "u3"], ["p3", "u3"], ["p4", "u3"],
            ["p1", "u4"], ["p2", "u4"], ["p3", "u4"], ["p4", "u4"]
        ]
        if k % 2 == 0 {
            relations += [ ["p2", "u1"], ["p4", "u1"] ]
        }
        if k % 2 == 1 {
            relations += [
                (1 ... k - 1).map { _ in "p1" } + ["u1'"], ["p2", "u1'"], ["p3", "u1'"], ["p4", "u1'"],
            ]
        }
        // 2
        relations += [
            ["u3", "u3"], ["u3", "u4"], ["u4", "u4"],
            ["p1", "v1"], ["p2", "v1"], ["p3", "v1"],
            ["p1", "v2"], ["p2", "v2"], ["p3", "v2"],
            ["p1", "v3"], ["p2", "v3"], ["p4", "v3"],
            ["p1", "v4"], ["p3", "v4"], ["p4", "v4"],
            ["p2", "v5"], ["p3", "v5"], ["p4", "v5"],
            ["p1", "v6"], ["p2", "v6"], ["p3", "v6"], ["p4", "v6"],
        ]
        if k % 2 == 0 {
            relations += [ ["u1", "u4"] ]
        }
        if k % 2 == 1 {
            relations += [ ["u1'", "u1'"], ["u1'", "u2"], ["u1'", "u3"], ["u1'", "u4"], ["u2", "u2"] ]
        }
        // 3
        relations += [
            ["u2", "v5"], ["u2", "v6"],
            ["u3", "v2"], ["u3", "v3"], ["u3", "v4"], ["u3", "v5"], ["u3", "v6"],
            ["u4", "v1"], ["u4", "v3"], ["u4", "v4"], ["u4", "v5"], ["u4", "v6"],
        ]
        if k % 2 == 0 {
            relations += [
                ["u1", "v2"], ["u1", "v4"], ["u1", "v6"],
                ["p2", "w1"], ["p4", "w1"], ["p3", "w2"], ["p4", "w2"],
            ]
        }
        if k % 2 == 1 {
            relations += [
                ["u1'", "v1"], ["u1'", "v2"], ["u1'", "v3"], ["u1'", "v4"], ["u1'", "v6"],
                ["p2", "w1'"], ["p4", "w1'"], ["p3", "w2'"], ["p4", "w2'"],
            ]
        }
        // 4
        for i in 1 ... 4 {
            for j in i + 1 ... 5 {
                relations += [ ["v\(i)", "v\(j)"] ]
            }
        }
        relations += [
            ["v3", "v3"], ["v4", "v4"], ["v3", "v6"], ["v4", "v6"], ["v5", "v6"], ["v6", "v6"],
        ]
        if k % 2 == 0 {
            relations += [
                ["u1", "w1"], ["u1", "w2"], ["u2", "w1"], ["u2", "w2"], ["u3", "w2"], ["u4", "w1"],
                ["u1", "u1", "v1"]
            ]
        }
        if k % 2 == 1 {
            relations += [
                ["u3", "w2'"], ["u4", "w1'"], ["u1'", "w1'"], ["u1'", "w2'"], ["p4", "v1", "v1"],
            ]
        }
        // 5
        relations += [
            ["u2", "v1", "v1"], // ex
        ]
        if k % 2 == 0 {
            relations += [
                ["u1", "v1", "v1"], // ex
                ["v1", "w2"], ["v2", "w1"], ["v3", "w2"],
                ["v4", "w1"], ["v6", "w1"], ["v6", "w2"]
            ]
        }
        if k % 2 == 1 {
            relations += [
                ["v3", "w1'"], ["v4", "w2'"], ["v6", "w1'"], ["v6", "w2'"]
            ]
        }
        // 8
        if k % 2 == 0 {
            relations += [ ["v2", "w2", "w2"] ]
        }
        return relations
    }

    private static var relations: [([String], [String], String, Int)] {
        let k = PathAlg.kk
        var relations: [([String], [String], String, Int)] = []
        // 1
        if k % 2 == 0 {
            relations += [ (["p3", "u1"], ["p3", "u2"], "1", 1) ]
        }
        // 2
        relations += [
            (["p3", "v3"], ["p4", "v1"], "1", 1),
            (["u2", "u3"], ["p4", "v1"], "1", 1),
            (["u2", "u4"], ["p4", "v2"], "1", 1),
            (["p2", "v4"], ["p4", "v2"], "1", 1),
        ]
        if k % 2 == 0 {
            relations += [
                (["u1", "u3"], ["p4", "v1"], "1", 1),
                (["u1", "u2"], ["p4", "v1"], "1", 1),
            ]
        }
        if k % 4 == 2 {
            relations += [ (["u1", "u1"], ["p4", "v2"], "1", 1) ] // ex
        }
        if k % 2 == 1 {
            relations += [
                (["p4", "v2"], ["p4", "v1"], "1", 1),
            ]
        }
        // 3
        relations += [ (["u2", "v2"], ["u2", "v1"], "1", 1) ]
        if k % 2 == 0 {
            relations += [
                (["u1", "v1"], ["u2", "v1"], "1", 1),
                (["u1", "v3"], ["u2", "v3"], "1", 1),
                (["p3", "w1"], ["u2", "v3"], "1", 1),
                (["p1", "w1"], ["u1", "v5"], "1", 1),
                (["p1", "w2"], ["u1", "v5"], "1", 1),
                (["p2", "w2"], ["u2", "v4"], "1", 1),
            ]
        }
        if k % 2 == 1 {
            relations += [
                (["u1'", "v5"], ["p1", "p1", "w1'"], "1", 1),
                (["p3", "w1'"], ["u2", "v3"], "1", 1),
                (["p1", "w2'"], ["p1", "w1'"], "1", 1),
                (["p2", "w2'"], ["u2", "v4"], "1", 1), 
            ]
        }
        // 4
        relations += [
            (["v5", "v5"], ["p1", "p1", "t"], "1", 1),
            (["u2", "u2", "v1"], ["p4", "v1", "v1"], "1", 1) // ex
        ]
        if k % 2 == 0 {
            relations += [
                (["u3", "w1"], ["v1", "v6"], "1", 1),
                (["u4", "w2"], ["v2", "v6"], "1", 1),
            ]
        }
        if k % 2 == 1 {
            relations += [
                (["u2", "w2'"], ["p4", "t"], "1", 1),
                (["u3", "w1'"], ["v1", "v6"], "1", 1),
                (["u4", "w2'"], ["v2", "v6"], "1", 1),
                (["u2", "w1'"], ["p4", "t"], "1", 1), 
            ]
        }
        // 5
        if k % 2 == 0 {
            relations += [
                (["v3", "w1"], ["p3", "u2", "t"], "1", 1),
                (["v4", "w2"], ["p2", "u2", "t"], "1", 1),
                (["v5", "w1"], ["p1", "u1", "t"], "1", 1),
                (["v5", "w2"], ["p1", "u1", "t"], "1", 1)
            ]
        }
        if k % 2 == 1 {
            relations += [
                (["v1", "w2'"], ["u3", "t"], "1", 1),
                (["v2", "w1'"], ["u4", "t"], "1", 1),
                (["v3", "w2'"], ["p3", "u2", "t"], "1", 1),
                (["v4", "w1'"], ["p2", "u2", "t"], "1", 1),
                (["v5", "w1'"], ["u1'", "t"], "1", 1),
                (["v5", "w2'"], ["u1'", "t"], "1", 1),
            ]
        }
        // 6
        if k % 2 == 0 {
            relations += [
                (["w1", "w1"], ["u1", "u1", "t"], "1", 1),
                ((1 ... k - 1).map { _ in "p1" } + ["v5", "t"], ["u2", "u2", "t"], "1", 1),
            ]
        }
        if k % 2 == 1 {
            relations += [
                (["w1'", "w1'"], ["p4", "v1", "t"], "1", 1),
                (["w2'", "w2'"], ["p4", "v1", "t"], "1", 1),
            ]
        }
        return relations
    }

    private static var sumRelations: [([String], Int, [String], Int, [String])] {
        let k = PathAlg.kk
        var relations: [([String], Int, [String], Int, [String])] = []
        // 2
        relations += [
            ((1 ... k - 1).map { _ in "p1" } + ["v5"], k + 1, ["p4", "v1"], k + 1, ["p4", "v2"]),
            (["u2", "u2"], 1, ["p4", "v1"], 1, ["p4", "v2"]),
        ]
        if k % 2 == 0 {
            relations += [
                (["u1", "u1"], k / 2 + 1, ["p4", "v1"], k / 2, ["p4", "v2"]),
            ]
        }
        // 6
        if k % 2 == 0 {
            relations += [
                (["w2", "w2"], 1, ["u1", "u1", "t"], 1, ["u2", "u2", "t"]),
                (["w2", "w2"], k / 2 + 1, ["p4", "v2", "t"], k / 2, ["p4", "v1", "t"]), // ex
                (["w1", "w2"], k / 2, ["p4", "v2", "t"], k / 2, ["p4", "v1", "t"]),
                (["p4", "v2", "t"], 1, ["u1", "u1", "t"], k / 2 + 1, ["u2", "u2", "t"]), // ex
            ]
        }
        if k % 2 == 1 {
            relations += [
                (["w1'", "w2'"], 1, ["p4", "v1", "t"], 1, ["v6", "t"]),
            ]
        }
        return relations
    }
}

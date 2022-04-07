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

        var j = -1
        for i in 0 ..< labels.count {
            if labels[i] != "c1" && labels[i] != "c2" && labels[i] != "c3" &&
                labels[i] != "p1" && labels[i] != "p2" && labels[i] != "p3" { j = i; break }
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
                let im = ImMatrix(mult: matrix)
                if im.rows.isEmpty { OutputFile.writeLog(.error, "Zero matrix \(labels)"); return nil }
                let g0 = Gen(label: "C", deg: deg, elem: im.rows[0])
                if checker.checkNotIm(g0, inIm: true) == nil { OutputFile.writeLog(.error, "In Im \(labels), i=\(i)"); return nil }
            }
            if gensMap[labels[i]] == nil {
                OutputFile.writeLog(.error, "Unknown gen " + labels[i])
                return nil
            }
            matrix = Matrix(mult: matrix, and: ShiftHH(gen: gensMap[labels[i]]!, shiftDeg: deg).matrix)
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

    static func checkSum3Relations(_ orderMap: [String: Int], _ gensMap: [String: Gen]) -> Bool {
        let relations = self.sum3Relations
        let zeroGens = zeroGens()
        for (p, k1, p1, k2, p2, k3, p3) in relations {
            if p.contains(where: { zeroGens[$0] != nil }) { continue }
            guard let (mult, deg) = processMult(p, orderMap, gensMap),
                  let (mult1, deg1) = processMult(p1, orderMap, gensMap),
                  let (mult2, deg2) = processMult(p2, orderMap, gensMap),
                  let (mult3, deg3) = processMult(p3, orderMap, gensMap) else { return false }
            if deg != deg1 || deg1 != deg2 || deg2 != deg3 { return false }
            mult.add(mult1, koef: -k1)
            mult.add(mult2, koef: -k2)
            mult.add(mult3, koef: -k3)
            if !matrixIsZero(mult, deg: deg) {
                OutputFile.writeLog(.error, "checkSum3Relations: Not zero \(p) = \(p1) + \(p2) + \(p3)")
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
        return sumRelations.map { m1, _, m2, _, m3 in
            return (m1.map { orderMap[$0]! }, m2.map { orderMap[$0]! }, m3.map { orderMap[$0]! })
        }
    }

    static func sum3Relations(_ orderMap: [String: Int]) -> [([Int], [Int], [Int], [Int])] {
        return sum3Relations.map { m1, _, m2, _, m3, _, m4 in
            return (m1.map { orderMap[$0]! }, m2.map { orderMap[$0]! }, m3.map { orderMap[$0]! }, m4.map { orderMap[$0]! })
        }
    }

    private static var zeroRelations: [[String]] {
        let (n1, n2, n3, rkC) = (PathAlg.n1, PathAlg.n2, PathAlg.n3, PathAlg.rkC)
        let c1_n3_1 = n3 == 1 ? [] : (0 ..< n3 - 1).map { _ in "c1" }
        let c2_n1_1 = n1 == 1 ? [] : (0 ..< n1 - 1).map { _ in "c2" }
        let c3_n2_1 = n2 == 1 ? [] : (0 ..< n2 - 1).map { _ in "c3" }
        var relations: [[String]] = []
        // 0
        relations += [
            ["c1", "c2"], ["c2", "c3"], ["c1", "c3"],
            ["c1", "p1"], ["c1", "p2"], ["c1", "p3"], ["c2", "p1"], ["c2", "p2"], ["c2", "p3"],
            ["c3", "p1"], ["c3", "p2"], ["c3", "p3"],
            ["p1", "p1"], ["p1", "p2"], ["p1", "p3"], ["p2", "p2"], ["p2", "p3"], ["p3", "p3"]
        ]
        // 1
        if rkC == 2 {
            relations += [
                ["p1", "x1"], ["p2", "x1"], ["p3", "x1"],
                ["c1", "x2"], ["c2", "x2"], ["c3", "x2"], ["p1", "x2"], ["p2", "x2"], ["p3", "x2"]
            ]
            if n1 % 2 == 0 {
                relations += [
                    ["c1", "x1"], ["c3", "x1"],
                    ["c1", "x4"], ["c2", "x4"], c3_n2_1 + ["x4"], ["p1", "x4"], ["p2", "x4"], ["p3", "x4"],
                    c1_n3_1 + ["x3"], ["c2", "x3"], ["c3", "x3"], ["p1", "x3"], ["p2", "x3"], ["p3", "x3"]
                ]
            }
        }
        if rkC == 1 || rkC == 0 {
            relations += [
                ["c1", "x1_1"], ["c3", "x1_1"], ["p1", "x1_1"], ["p2", "x1_1"], ["p3", "x1_1"],
                ["c1", "x1_2"], ["c2", "x1_2"], ["p1", "x1_2"], ["p2", "x1_2"], ["p3", "x1_2"],
            ]
        }
        if rkC == 1 {
            relations += [
                ["c1", "x2"], ["c2", "x2"], ["c3", "x2"], ["p1", "x2"], ["p2", "x2"], ["p3", "x2"],
                c1_n3_1 + ["x3"], ["c2", "x3"], ["c3", "x3"], ["p1", "x3"], ["p2", "x3"], ["p3", "x3"],
            ]
        }
        if rkC == 0 {
            relations += [
                ["c1", "x1_2"], ["c2", "x1_2"], ["p1", "x1_2"], ["p2", "x1_2"], ["p3", "x1_2"],
                ["c2", "x2_2"], ["c3", "x2_2"], ["p1", "x2_2"], ["p2", "x2_2"], ["p3", "x2_2"],
                ["p1", "x2_1"], ["p2", "x2_1"], ["p3", "x2_1"],
                ["c2", "x2_1"], ["c3", "x2_1"],
            ]
        }
        // 2
        relations += [
            ["c1", "y2"], ["c2", "y2"], ["c3", "y2"], ["p1", "y2"], ["p2", "y2"], ["p3", "y2"],
            ["c1", "y3"], ["c2", "y3"], ["c3", "y3"], ["p1", "y3"], ["p2", "y3"], ["p3", "y3"],
        ]
        if rkC == 2 {
            relations += [c1_n3_1 + ["c1", "y1"], c2_n1_1 + ["c2", "y1"], c3_n2_1 + ["c3", "y1"], ["x1", "x1"], ["x2", "x2"]]
        }
        if rkC == 2 && n1 % 2 == 0 {
            relations += [
                ["x1", "x2"], ["x1", "x3"], ["x1", "x4"],
                ["x2", "x3"], ["x2", "x4"], ["x3", "x3"], ["x3", "x4"], ["x4", "x4"],
            ]
        }
        if rkC == 1 || rkC == 0 {
            relations += [ ["x1_1", "x1_2"], ]
        }
        if rkC == 1 {
            relations += [
                c1_n3_1 + ["c1", "y1"],
                ["x2", "x2"], ["x2", "x1_1"], ["x2", "x1_2"], ["x2", "x3"], ["x2", "x1_1"],
                ["x3", "x1_1"], ["x3", "x1_2"], ["x3", "x1_2"], ["x3", "x3"],
            ]
        }
        if rkC == 0 {
            relations += [ ["x1_1", "x2_1"], ["x1_1", "x2_2"], ["x1_2", "x2_1"], ["x1_2", "x2_2"] ]
        }
        // 3
        relations += [ ["c1", "z1"], ["c2", "z1"], ["c3", "z1"], ["c1", "z2"], ["c2", "z2"], ["c3", "z2"] ]
        if rkC == 2 {
            relations += [ ["x1", "y2"] ]
        }
        if rkC == 2 && n1 % 2 == 0 {
            relations += [ ["x4", "y2"], ["x4", "y3"] ]
        }
        if (rkC == 2 && n1 % 2 == 0) || rkC == 1 {
            relations += [ ["x3", "y2"], ["x3", "y3"] ]
        }
        if rkC == 1 || rkC == 0 {
            relations += [ ["x1_1", "y2"], ["x1_2", "y2"] ]
        }
        if rkC == 0 {
            relations += [ ["x2_1", "y2"], ["x2_2", "y3"] ]
        }
        // 4
        relations += [ ["y2", "y2"], ["y3", "y3"] ]
        if PathAlg.N > 3 {
            relations += [ ["y2", "y3"] ]
        }
        if rkC == 2 && n1 % 2 == 0 {
            relations += [ ["x1", "z1"], ["x3", "z1"], ["x3", "z2"], ["x4", "z1"], ["x4", "z2"] ]
        }
        if rkC == 1 || rkC == 0 {
            relations += [ ["x1_1", "z1"], ["x1_2", "z1"] ]
        }
        if rkC == 1 {
            relations += [ ["x3", "z1"], ["x3", "z2"] ]
        }
        if rkC == 0 {
            relations += [ ["x2_1", "z1"], ["x2_2", "z2"] ]
        }
        // 5
        if (n1 > 1 && n2 > 1) || (n1 > 1 && n3 > 1) || (n2 > 1 && n3 > 1) {
            relations += [ ["y2", "z2"], ["y3", "z1"] ]
        }
        return relations
    }

    private static var relations: [([String], [String], String, Int)] {
        let (n1, n2, n3, rkC) = (PathAlg.n1, PathAlg.n2, PathAlg.n3, PathAlg.rkC)
        let c1_n3_1 = n3 == 1 ? [] : (0 ..< n3 - 1).map { _ in "c1" }
        let c2_n1_1 = n1 == 1 ? [] : (0 ..< n1 - 1).map { _ in "c2" }
        let c3_n2_1 = n2 == 1 ? [] : (0 ..< n2 - 1).map { _ in "c3" }
        var relations: [([String], [String], String, Int)] = []
        // 1
        if rkC == 0 {
            relations += [ (["c1", "x2_2"], ["c1", "x2_1"], "1", 1) ]
        }
        // 2
        if rkC == 2 {
            relations += [
                (["p2", "y1"], ["p1", "y1"], "1", 1),
                (["p3", "y1"], ["p1", "y1"], "1", 1)
            ]
            if n1 % 2 == 1 {
                relations += [ (["x1", "x2"], ["p1", "y1"], "1", 1) ]
            }
        }
        if rkC == 1 {
            relations += [
                (["p2", "y1"], ["p1", "y1"], "1", 1),
                (c3_n2_1 + ["c3", "y1"], c2_n1_1 + ["c2", "y1"], "1", 1),
                (["x1_1", "x1_1"], c2_n1_1 + ["c2", "y1"], "n1/2", PathAlg.n1 / 2),
                (["x1_2", "x1_2"], c2_n1_1 + ["c2", "y1"], "n2/2", PathAlg.n2 / 2),
            ]
        }
        if rkC == 0 {
            relations += [
                (["x1_1", "x1_1"], c2_n1_1 + ["c2", "y1"], "n1/2", PathAlg.n1 / 2),
                (["x2_1", "x2_1"], c1_n3_1 + ["c1", "y1"], "n3/2", PathAlg.n3 / 2),
                (["x2_1", "x2_2"], c1_n3_1 + ["c1", "y1"], "n3/2", PathAlg.n3 / 2),
                (["x2_2", "x2_2"], c1_n3_1 + ["c1", "y1"], "n3/2", PathAlg.n3 / 2),
            ]
        }
        // 3
        relations += [
            (["p2", "z1"], ["p1", "z1"], "1", 1),
            (["p3", "z1"], ["p1", "z1"], "1", 1),
            (["p2", "z2"], ["p1", "z2"], "1", 1),
            (["p3", "z2"], ["p1", "z2"], "1", 1),
        ]
        if rkC == 2 {
            relations += [ (["x1", "y3"], ["p1", "z2"], "1", 1) ]
        }
        if rkC == 1 || rkC == 2 {
            relations += [
                (["x2", "y2"], ["p1", "z1"], "1", 1),
                (["x2", "y3"], ["p1", "z2"], "1", 1),
            ]
        }
        if rkC == 0 || rkC == 1 {
            relations += [
                (["x1_1", "y3"], ["p1", "z2"], "1", 1),
                (["x1_2", "y3"], ["p1", "z2"], "1", 1),
            ]
        }
        if rkC == 0 {
            relations += [
                (["x2_1", "y3"], ["p1", "z2"], "1", 1),
                (["x2_2", "y2"], ["p1", "z1"], "1", 1),
            ]
        }
        // 4
        if PathAlg.N == 3 {
            relations += [ (["y2", "y3"], ["p1", "y1", "y1"], "1", 1) ]
        }
        if rkC == 2 && n1 % 2 == 1 {
            relations += [ (["y1", "y2"], ["x1", "z1"], "1", 1) ]
        }
        if rkC == 2 && n1 % 2 == 0 {
            relations += [ (["x2", "z2"], ["x1", "z2"], "1", 1) ]
        }
        if rkC == 1 {
            relations += [
                (["x1_1", "z2"], ["x2", "z2"], "1", 1),
                (["x1_2", "z2"], ["x2", "z2"], "1", 1)
            ]
        }
        if rkC == 0 {
            relations += [
                (["x1_2", "z2"], ["x1_1", "z2"], "1", 1),
                (["x2_1", "z2"], ["x1_1", "z2"], "1", 1),
                (["x1_2", "x1_2", "y1"], c3_n2_1 + ["c3", "y1", "y1"], "1", PathAlg.n2 / 2)
            ]
        }
        // 5
        if (n1 == 1 && n2 == 1) || (n2 == 1 && n3 == 1) || (n1 == 1 && n3 == 1) {
            relations += [ (["y2", "z2"], c1_n3_1 + c2_n1_1 + c3_n2_1 + ["x1", "y1", "y1"], "1", 1) ]
        }
        // 6
        relations += [ (["z1", "z2"], c1_n3_1 + c2_n1_1 + c3_n2_1 + ["y1", "y1", "y1"], "n1", PathAlg.n1) ]
        return relations
    }

    private static var sumRelations: [([String], Int, [String], Int, [String])] {
        let (n1, n2, n3, rkC) = (PathAlg.n1, PathAlg.n2, PathAlg.n3, PathAlg.rkC)
        let c1_n3_1 = n3 == 1 ? [] : (0 ..< n3 - 1).map { _ in "c1" }
        let c2_n1_1 = n1 == 1 ? [] : (0 ..< n1 - 1).map { _ in "c2" }
        let c3_n2_1 = n2 == 1 ? [] : (0 ..< n2 - 1).map { _ in "c3" }
        var relations: [([String], Int, [String], Int, [String])] = []
        // 2
        if rkC == 1 {
            relations += [ (["p3", "y1"], 1, c2_n1_1 + ["c2", "y1"], 1, ["p1", "y1"]) ]
        }
        if rkC == 0 {
            relations += [
                (c3_n2_1 + ["c3", "y1"], 1, c1_n3_1 + ["c1", "y1"], 1, c2_n1_1 + ["c2", "y1"]),
                (["p2", "y1"], 1, c1_n3_1 + ["c1", "y1"], 1, ["p1", "y1"]),
                (["x1_2", "x1_2"], PathAlg.n2 / 2, c1_n3_1 + ["c1", "y1"], PathAlg.n2 / 2, c2_n1_1 + ["c2", "y1"]),
            ]
        }
        // 5
        if (n1 == 1 && n2 == 1) || (n2 == 1 && n3 == 1) || (n1 == 1 && n3 == 1) {
            relations += [ (["y3", "z1"], 1, c1_n3_1 + c2_n1_1 + c3_n2_1 + ["x1", "y1", "y1"],  PathAlg.N == 3 ? 1 : 0, ["x2", "y1", "y1"]) ]
        }
        // 4
        if rkC == 2 && (n1 % 2 == 1) {
            relations += [ (["y1", "y3"], 1, ["x1", "z2"], 1, ["x2", "z2"]) ]
        }
        if rkC == 0 {
            relations += [ (c1_n3_1 + ["c1", "y1", "y1"], 1, c2_n1_1 + ["c2", "y1", "y1"], 1, c3_n2_1 + ["c3", "y1", "y1"]) ]
        }
        // 0
        relations += [
            (c1_n3_1 + ["c1"], 1, ["p1"], 1, ["p2"]),
            (c2_n1_1 + ["c2"], 1, ["p2"], 1, ["p3"]),
            (c3_n2_1 + ["c3"], 1, ["p1"], 1, ["p3"])
        ]
        return relations
    }

    private static var sum3Relations: [([String], Int, [String], Int, [String], Int, [String])] {
        let (n1, n2, n3, rkC) = (PathAlg.n1, PathAlg.n2, PathAlg.n3, PathAlg.rkC)
        let c1_n3_1 = n3 == 1 ? [] : (0 ..< n3 - 1).map { _ in "c1" }
        let c2_n1_1 = n1 == 1 ? [] : (0 ..< n1 - 1).map { _ in "c2" }
        let c3_n2_1 = n2 == 1 ? [] : (0 ..< n2 - 1).map { _ in "c3" }
        var relations: [([String], Int, [String], Int, [String], Int, [String])] = []
        // 2
        if rkC == 0 {
            relations += [
                (["p3", "y1"], 1, c1_n3_1 + ["c1", "y1"], 1, c2_n1_1 + ["c2", "y1"], 1, ["p1", "y1"]),
            ]
        }
        return relations
    }
}

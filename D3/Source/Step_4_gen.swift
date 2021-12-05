//
//  Step_4_gen.swift
//
//  Created by M on 11.11.2021.
//

import Foundation

struct Step_4_gen {
    static func runCase() -> Bool {
        searchGen(deg: PathAlg.alg.someNumber)
        return false
    }

    static func searchGen(deg: Int) {
        OutputFile.writeLog(.bold, "Deg \(deg): dimHH=\(Dim.dimHH(deg))")
        var gens: [Gen] = []
        let checker = GenCreate(deg: deg)
        let inImChecker = GenCreate(deg: deg)
        let allElements = GenCreate.allElements

        if deg == 4 {
            searchInDeg(deg: deg, allElements: allElements, checker: checker, gens: &gens)
            multDeg0(allElements: allElements, inImChecker: inImChecker, checker: checker, gens: &gens)
            searchInLessDeg(deg: deg, allElements: allElements, inImChecker: inImChecker, checker: checker, gens: &gens)
        } else {
            searchInLessDeg(deg: deg, allElements: allElements, inImChecker: inImChecker, checker: checker, gens: &gens)
            searchInDeg(deg: deg, allElements: allElements, checker: checker, gens: &gens)
        }
        multDeg0(allElements: allElements, inImChecker: inImChecker, checker: checker, gens: &gens)
        if gens.count == Dim.dimHH(deg) {
            OutputFile.writeLog(.normal, "Dim ok!")
            //checker.printIm()
            return
        } else {
            gens.forEach { OutputFile.writeLog(.normal, $0.str) }
            OutputFile.writeLog(.error, "Dim not ok! Has \(gens.count) elements, need \(Dim.dimHH(deg))")
        }
        searchAllVariants(deg: deg, checker: checker, gens: &gens)
    }

    private static func searchInLessDeg(deg: Int, allElements: [Gen], inImChecker: GenCreate, checker: GenCreate, gens: inout [Gen]) {
        for i in 0 ..< allElements.count {
            let e1 = allElements[i]
            if e1.deg == 0 { continue }
            for j in i ..< allElements.count {
                let e2 = allElements[j]
                if e1.deg + e2.deg != deg { continue }
                if let g = mult(e1, and: e2, inImChecker: inImChecker, checker: checker, gens: gens) {
                    //OutputFile.writeLog(.normal, "New! " + g.str)
                    gens.append(g)
                }
            }
        }
    }

    private static func multDeg0(allElements: [Gen], inImChecker: GenCreate, checker: GenCreate, gens: inout [Gen]) {
        let deg0Elements = allElements.filter { $0.deg == 0 }
        var i = 0
        while i < gens.count {
            let e = gens[i]
            for e0 in deg0Elements {
                if e0.label == "1" { continue }
                if let g = mult(e0, and: e, inImChecker: inImChecker, checker: checker, gens: gens) { gens.append(g) }
            }
            i += 1
        }
    }

    private static func searchInDeg(deg: Int, allElements: [Gen], checker: GenCreate, gens: inout [Gen]) {
        for e in allElements {
            if e.deg != deg { continue }
            //PrintUtils.printMatrix("Diff", Diff(deg: e.deg - 1))
            //PrintUtils.printImMatrix("Im", ImMatrix(diff: Diff(deg: e.deg - 1)))
            //OutputFile.writeLog(.normal, "Check \(e.str)")
            if let err = checker.check(e) {
                OutputFile.writeLog(.error, "Check \(e.str): " + err)
                return
            }
            gens.append(e)
        }
    }

    private static func searchAllVariants(deg: Int, checker: GenCreate, gens: inout [Gen]) {
        var variants: [[(Int, Way)]] = []
        let q = BimodQ(deg: deg)
        var elem1: [(Int, Way)] = []
        q.pij.forEach { _ in elem1.append((0, Way.zero)) }
        for i in 0 ..< q.pij.count {
            let p = q.pij[i]
            let ways = Way.allWays(from: p.1, to: p.0)
            var line: [(Int, Way)] = [(0, Way.zero)]
            for w in ways {
                elem1[i] = (1, w)
                let g = Gen(label: "S1/\(gens.count)", deg: deg, elem: elem1)
                if checker.check(g) == nil {
                    OutputFile.writeLog(.normal, "Add \(g.str)")
                    gens.append(g)
                } else if GenCreate(deg: deg).check(g) != nil {
                    line.append((1, w))
                    line.append((-1, w))
                }
                elem1[i] = (0, Way.zero)
            }
            variants.append(line)
        }
        var sz = 1
        variants.forEach { sz *= $0.count }
        for s in 1 ..< sz {
            var elem: [(Int, Way)] = []
            var pos = s
            for v in variants {
                elem.append(v[pos % v.count])
                pos /= v.count
            }
            let g = Gen(label: "S/\(gens.count)", deg: deg, elem: elem)
            if checker.check(g) == nil {
                gens.append(g)
                OutputFile.writeLog(.normal, "Add \(g.str)")
            }
        }
        gens.forEach { OutputFile.writeLog(.normal, $0.str) }
    }

    private static func multMatrix(_ e1: Gen, and e2: Gen) -> Matrix {
        var s2 = ShiftHH(gen: e2, shiftDeg: 0).matrix
        if s2.isZero { s2 = ShiftHH(gen: e2).matrix }
        let s1 = ShiftHH(gen: e1, shiftDeg: e2.deg).matrix
        if !s1.isZero { return Matrix(mult: s2, and: s1) }
        return Matrix(mult: ShiftHH(gen: e1, shiftDeg: 0).matrix, and: ShiftHH(gen: e2, shiftDeg: e1.deg).matrix)
    }

    private static func mult(_ e1: Gen, and e2: Gen, inImChecker: GenCreate, checker: GenCreate, gens: [Gen]) -> Gen? {
        let multLabel = e1.label + " * " + e2.label
        if gens.contains(where: { $0.label == multLabel }) { return nil }
        let deg = e1.deg + e2.deg
        let mult = multMatrix(e1, and: e2)
        //if !checkCommutative(e1, and: e2, inImChecker: inImChecker, mult: mult) { return nil }
        if mult.isZero { printZeroMult(multLabel); return nil }
        let im = ImMatrix(mult: mult)
        //PrintUtils.printMatrix(multLabel + "Mult", mult)
        //PrintUtils.printImMatrix("Im", im)
        if im.rows.isEmpty { printZeroMult(multLabel); return nil }
        var found = false
        let g0 = Gen(label: multLabel, deg: deg, elem: im.rows[0])
        for g in gens {
            let k = g.eqKoef(g0)
            if k != 0 {
                if found { OutputFile.writeLog(.error, "Same elements " + g.str) }
                found = true
                OutputFile.writeLog(.normal, "Rel: " + g0.label + " = \(k) * " + g.label)
            }
        }
        if found { return nil }
        if inImChecker.checkNotIm(g0, inIm: true) == nil {
            //OutputFile.writeLog(.normal, "Zero " + g0.str)
            printZeroMult(multLabel);
            return nil
        }
        if checker.check(g0) == nil { return g0 }
        if checkUnknownElement(g0: g0, inImChecker: inImChecker, gens: gens) { return nil }
        OutputFile.writeLog(.error, "Unknown element " + g0.str)
        checker.printIm()
        return nil
    }

    private static func checkUnknownElement(g0: Gen, inImChecker: GenCreate, gens: [Gen]) -> Bool {
        let relations: [(String, String, String, Int)] = [
            ("w * u2", "z1 * u2", "(n1*n2+n2*n3+n3*n1)", PathAlg.n1 * PathAlg.n2 + PathAlg.n2 * PathAlg.n3 + PathAlg.n3 * PathAlg.n1),
            ("w23 * u2", "z1 * u2", "1", 1), // 3, n1 = 0
            ("c31 * x3_h", "x3 * x31", "-1", -1), // 3, n1 = 0
            ("c12 * x1_h", "x1 * x12", "-1", -1) // 3, n1 = 0
        ]
        for r in relations {
            if g0.label != r.0 { continue }
            guard let g1 = gens.first(where: { $0.label == r.1 }) else { continue }
            var e: [(Int, Way)] = []
            for i in 0 ..< g0.elem.count {
                let p0 = g0.elem[i]
                let p1 = g1.elem[i]
                if p1.0 == 0 {
                    e.append((p0.0, Way(way: p0.1)));
                    continue
                }
                let k = p0.0 - r.3 * p1.0
                if p0.0 == 0 {
                    e.append((k, k == 0 ? Way.zero : Way(way: p1.1)));
                    continue
                }
                if !p0.1.isEq(p1.1) { fatalError() }
                e.append((k, k == 0 ? Way.zero : Way(way: p0.1)))
            }
            let g2 = Gen(label: g0.label + " = " + r.2 + " * " + g1.label, deg: g0.deg, elem: e)
            if inImChecker.checkNotIm(g2, inIm: true) == nil {
                OutputFile.writeLog(.normal, "Relation " + g2.label)
                printZeroMult(g2.label);
                return true
            }
        }
        return false
    }

    private static func checkCommutative(_ e1: Gen, and e2: Gen, inImChecker: GenCreate, mult: Matrix) -> Bool {
        let deg = e1.deg + e2.deg
        let s1 = ShiftHH(gen: e1, shiftDeg: 0).matrix
        let s2 = ShiftHH(gen: e2, shiftDeg: e1.deg).matrix
        if s1.isZero || s2.isZero { return true }
        let mult2 = Matrix(mult: s1, and: s2)
        if mult.numberOfDifferents(with: mult2) == 0 { return true }
        mult2.add(mult, koef: -1)
        let im = ImMatrix(mult: mult2)
        if im.rows.count == 0 { return true }
        let g0 = Gen(label: "C", deg: deg, elem: im.rows[0])
        //OutputFile.writeLog(.normal, g0.str)
        if inImChecker.checkNotIm(g0, inIm: true) == nil { return true }
        let commLabel = e2.label + " * " + e1.label + " = - " + e1.label + " * " + e2.label
        mult2.add(mult, koef: 2)
        let im2 = ImMatrix(mult: mult2)
        if im2.rows.count == 0 { OutputFile.writeLog(.normal, commLabel); return true }
        let g1 = Gen(label: "-C", deg: deg, elem: im2.rows[0])
        if inImChecker.checkNotIm(g1, inIm: true) == nil { OutputFile.writeLog(.normal, commLabel); return true }
        OutputFile.writeLog(.error, e2.label + " * " + e1.label + " not commutative")
        return false
    }

    private static func printZeroMult(_ multLabel: String) {
        //OutputFile.writeLog(.normal, multLabel + " = 0");
    }
}

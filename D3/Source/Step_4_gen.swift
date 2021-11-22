//
//  Step_4_gen.swift
//
//  Created by M on 11.11.2021.
//

import Foundation

struct Step_4_gen {
    static func runCase() -> Bool {
        let deg = 1
        /*let elements = GenCreate.allElements
        elements.forEach { OutputFile.writeLog(.normal, $0.str) }
        let checker = GenCreate(deg: deg)
        for e in elements {
            if e.deg != deg { continue }
            if let err = checker.check(e) {
                OutputFile.writeLog(.normal, "Check \(e.str): " + err)
                return true
            }
        }*/
        searchGen(deg: deg)
        return false
    }

    static func searchGen(deg: Int) {
        OutputFile.writeLog(.bold, "Deg \(deg): dimHH=\(Dim.dimHH(deg))")
        let knownElements = GenCreate.allElements.filter { $0.deg == deg }
        let checker = GenCreate(deg: deg)
        for e in knownElements {
            if let err = checker.check(e) {
                OutputFile.writeLog(.normal, "Check \(e.str): " + err)
                return
            }
        }
        var gens: [Gen] = knownElements
        let inImChecker = GenCreate(deg: deg)
        let deg0Elements = GenCreate.allElements.filter { $0.deg == 0 }
        var i = 0
        while i < gens.count {
            let e = gens[i]
            for e0 in deg0Elements {
                if e0.label == "1" { continue }
                if let g = mult(e, and: e0, inImChecker: inImChecker, checker: checker, gens: gens) { gens.append(g) }
            }
            i += 1
        }
        gens.forEach { OutputFile.writeLog(.normal, $0.str) }
        if gens.count == Dim.dimHH(deg) {
            OutputFile.writeLog(.normal, "Dim ok!")
            return
        } else {
            OutputFile.writeLog(.error, "Dim not ok!")
        }
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
                    gens.append(g)
                } else if GenCreate(deg: deg).check(g) != nil {
                    line.append((1, w))
                    line.append((-1, w))
                    //line.append((2, w))
                    //line.append((-2, w))
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
                if !knownElements.contains(where: { $0.eqKoef(g) != 0 }) && !gens.contains(where: { $0.eqKoef(g) != 0 }) {
                    gens.append(g)
                }
            }
        }
        //knownElements.forEach { OutputFile.writeLog(.normal, $0.str) }
        //gens.append(contentsOf: knownElements)
        gens.forEach { OutputFile.writeLog(.normal, $0.str) }
    }

    private static func mult(_ e: Gen, and e0: Gen, inImChecker: GenCreate, checker: GenCreate, gens: [Gen]) -> Gen? {
        let deg = e.deg + e0.deg
        let s0 = ShiftHH(gen: e0)
        let s = ShiftHH(gen: e)
        let mult = Matrix(mult: s0.matrix, and: s.matrix)
        if mult.numberOfDifferents(with: Matrix(mult: s.matrix, and: ShiftHH(nextAfter: s0).matrix)) != 0 {
            OutputFile.writeLog(.error, e0.label + " * " + e.label + " not commutative")
        }
        let multLabel = e0.label + " * " + e.label
        if mult.isZero { printZeroMult(multLabel); return nil }
        let im = ImMatrix(diff: mult, hasZeroRows: true)
        if im.rows.isEmpty { printZeroMult(multLabel); return nil }
        if im.rows.count != 1 {
            PrintUtils.printImMatrix("Im", im)
            OutputFile.writeLog(.error, multLabel + " = unknown im")
            return nil
        }
        var found = false
        let g0 = Gen(label: multLabel, deg: deg, elem: im.rows[0])
        for g in gens {
            let k = g.eqKoef(g0)
            if k != 0 {
                if found { OutputFile.writeLog(.error, "Same elements " + g.str) }
                found = true
                OutputFile.writeLog(.normal, g0.label + " = \(k) * " + g.label)
            }
        }
        if found { return nil }
        if inImChecker.checkNotIm(g0, inIm: true) == nil { printZeroMult(multLabel); return nil }
        if checker.check(g0) == nil { return g0 }
        OutputFile.writeLog(.error, "Unknown element " + g0.str)
        return nil
    }

    private static func printZeroMult(_ multLabel: String) {
        //OutputFile.writeLog(.normal, multLabel + " = 0");
    }
}

//
//  Step_7_mult.swift
//
//  Created by M on 29.11.2021.
//

import Foundation

struct Step_7_mult {
    static func runCase() -> Bool {
        guard let env = MultEnvironment() else { return true }
        var gensByDeg: [[GenElement]] = []
        let degMax = PathAlg.N == 3 ? 50 : 30
        for deg in 0 ..< degMax {
            let items: [GenElement]
            if let gens = GensByDeg.gens(for: deg) {
                if gens.count != Dim.dimHH(deg) {
                    OutputFile.writeLog(.error, "Bad gens count for deg \(deg): \(gens.count)")
                    return true
                }
                guard let ii = process(gens: gens, deg: deg, env) else { return true }
                items = ii
            } else {
                guard let ii = searchElements(deg: deg, gensByDeg: gensByDeg, env) else { return true }
                if ii.count != Dim.dimHH(deg) {
                    OutputFile.writeLog(.error, "Bad search gens count for deg \(deg): \(ii.count)")
                    return true
                }
                items = ii
            }
            if !checkElements(items: items, deg: deg, gensByDeg: gensByDeg, env) {
                return true
            }
            gensByDeg.append(items)
            OutputFile.writeLog(.normal, "Deg \(deg) checked :)")
        }
        return false
    }

    private static func isZero(_ labels: [Int], _ relations: [[Int]]) -> Bool {
        return relations.contains { labels.d3HasSubarray($0) }
    }

    private static func genElement(from labels: [String], deg: Int, _ orderMap: [String: Int], _ gensMap: [String: Gen]) -> GenElement? {
        guard let (d, m) = Relations.multGens(labels: labels, checkZero: false, orderMap, gensMap) else {
            OutputFile.writeLog(.error, "Mult err \(labels)")
            return nil
        }
        if d != deg {
            OutputFile.writeLog(.error, "Bad deg \(d): \(labels)")
            return nil
        }
        return GenElement(deg: deg, items: labels.map { orderMap[$0]! }, matrix: m)
    }

    private static func genElement(mult g1: GenElement, and g2: GenElement, labels: [Int], _ env: MultEnvironment) -> GenElement? {
        if g1.items.count == 1 {
            let label = env.orderToLabelMap[g1.items[0]]!
            let shift = ShiftHH(gen: env.gensMap[label]!, shiftDeg: g2.deg).matrix
            if !shift.isZero {
                let matrix = Matrix(mult: g2.matrix, and: shift)
                if matrix.isNil { OutputFile.writeLog(.error, "Nil matrix \(label)!"); return nil }
                return GenElement(deg: g1.deg + g2.deg, items: labels, matrix: matrix)
            }
        }
        if g2.items.count == 1 {
            let label = env.orderToLabelMap[g2.items[0]]!
            let shift = ShiftHH(gen: env.gensMap[label]!, shiftDeg: g1.deg).matrix
            if !shift.isZero {
                let matrix = Matrix(mult: g1.matrix, and: shift)
                if matrix.isNil { OutputFile.writeLog(.error, "Nil matrix \(label)!"); return nil }
                return GenElement(deg: g1.deg + g2.deg, items: labels, matrix: matrix)
            }
        }
        return genElement(from: labels.map { env.orderToLabelMap[$0]! }, deg: g1.deg + g2.deg, env.labelToOrderMap, env.gensMap)
    }

    private static func process(gens: [[String]], deg: Int, _ env: MultEnvironment) -> [GenElement]? {
        var items: [GenElement] = []
        let checker = GenCreate(deg: deg)
        for g in gens {
            if g.count == 1 && g[0] == "1" { continue }
            guard let e = genElement(from: g, deg: deg, env.labelToOrderMap, env.gensMap) else { return nil }
            guard let g0 = e.gen else { OutputFile.writeLog(.error, "No e \(g)"); return nil }
            if let err = checker.check(g0) {
                OutputFile.writeLog(.error, "\(e.items.map { env.orderToLabelMap[$0]! }): " + g0.str + ": " + err)
                return nil
            }
            items.append(e)
        }
        return items
    }

    private static func add(_ n: Int, to arr: inout [Int]) {
        for j in 0 ..< arr.count {
            if arr[j] > n {
                arr.insert(n, at: j)
                return
            }
        }
        arr.append(n)
    }

    private static func searchElements(deg: Int, gensByDeg: [[GenElement]], _ env: MultEnvironment) -> [GenElement]? {
        var ii: [GenElement] = []
        let checker = GenCreate(deg: deg)
        let knownElements = env.gens.filter { $0.deg == deg && $0.label != "1" }
        for g in knownElements {
            if let err = checker.check(g) { OutputFile.writeLog(.error, g.str + ": " + err); return nil }
            guard let ge = genElement(from: [g.label], deg: deg, env.labelToOrderMap, env.gensMap) else { return nil }
            ii.append(ge)
            for e0 in env.deg0Elements {
                let e0Order = env.labelToOrderMap[e0.label]!
                var labels = [env.labelToOrderMap[g.label]!]
                while true {
                    labels = multLabels(labels, [e0Order], env)
                    if isZero(labels, env.zeroRelations) { break }
                    guard let ge1 = genElement(from: labels.map { env.orderToLabelMap[$0]! }, deg: deg, env.labelToOrderMap, env.gensMap) else { return nil }
                    guard let e1 = ge1.gen else { return nil }
                    if let err = checker.check(e1) { OutputFile.writeLog(.error, e1.str + ": " + err); return nil }
                    ii.append(ge1)
                }
            }
        }
        if gensByDeg.count < 2 { return ii }
        for i in 1 ..< gensByDeg.count {
            for j in i ..< gensByDeg.count {
                if i + j != deg { continue }
                let gens1 = gensByDeg[i]
                let gens2 = gensByDeg[j]
                for g1 in gens1 {
                    for g2 in gens2 {
                        let labels = multLabels(g1.items, g2.items, env)
                        if ii.d3Contains(labels) { continue }
                        if isZero(labels, env.zeroRelations) { continue }
                        guard let ge1 = genElement(mult: g1, and: g2, labels: labels, env) else { return nil }
                        guard let e1 = ge1.gen else { return nil }
                        if let err = checker.check(e1) {
                            let lll = "\(labels.map { env.orderToLabelMap[$0]! })"
                            if GenCreate(deg: deg).checkNotIm(e1, inIm: true) == nil {
                                OutputFile.writeLog(.normal, "Zero! \(lll)")
                            }
                            OutputFile.writeLog(.error, "\(lll):: " + e1.str + ": " + err)
                            return nil

                        }
                        ii.append(ge1)
                    }
                }
            }
        }
        return ii
    }

    private static func multLabels(_ g1: [Int], _ g2: [Int], _ env: MultEnvironment) -> [Int] {
        var labels = g1
        g2.forEach { add($0, to: &labels) }
        while true {
            guard let r = env.relations.first(where: { labels.d3HasSubarray($0.0) }) else { return labels }
            for r0 in r.0 { labels.remove(at: labels.firstIndex(where: { $0 == r0 })!) }
            for r1 in r.1 { add(r1, to: &labels) }
        }
        return labels
    }

    private static func checkElements(items: [GenElement], deg: Int, gensByDeg: [[GenElement]], _ env: MultEnvironment) -> Bool {
        let knownElements = env.gens.filter { $0.deg == deg && $0.label != "1" }
        for g in knownElements {
            if !items.d3Contains([env.labelToOrderMap[g.label]!]) { return false }
            for e0 in env.deg0Elements {
                let e0Order = env.labelToOrderMap[e0.label]!
                var labels = [env.labelToOrderMap[g.label]!]
                while true {
                    labels = multLabels(labels, [e0Order], env)
                    if isZero(labels, env.zeroRelations) { break }
                    if !items.d3Contains(labels) { return false }
                }
            }
        }
        if gensByDeg.count < 2 { return true }
        for i in 1 ..< gensByDeg.count {
            for j in i ..< gensByDeg.count {
                if i + j != deg { continue }
                let gens1 = gensByDeg[i]
                let gens2 = gensByDeg[j]
                for g1 in gens1 {
                    for g2 in gens2 {
                        let labels = multLabels(g1.items, g2.items, env)
                        if isZero(labels, env.zeroRelations) { continue }
                        if !items.d3Contains(labels) { return false }
                    }
                }
            }
        }
        return true
    }
}

final class MultEnvironment {
    let labelToOrderMap: [String: Int]
    let orderToLabelMap: [Int: String]
    let relations: [([Int], [Int])]
    let zeroRelations: [[Int]]
    let gens: [Gen]
    let gensMap: [String: Gen]
    let deg0Elements: [Gen]

    init?() {
        let elementsOrder = ["c12", "c23", "c31", "z1", "w", "e", "h1", "h2", "x12", "x23", "x31", "u1", "u2"]
        var labelToOrderMap: [String: Int] = [:]
        var orderToLabelMap: [Int: String] = [:]
        for i in 0 ..< elementsOrder.count {
            labelToOrderMap[elementsOrder[i]] = i
            orderToLabelMap[i] = elementsOrder[i]
        }
        self.labelToOrderMap = labelToOrderMap
        self.orderToLabelMap = orderToLabelMap
        gens = GenCreate.allElements
        var gensMap: [String: Gen] = [:]
        for g in gens { gensMap[g.label] = g }
        self.gensMap = gensMap
        if !Relations.checkZeroRelations(labelToOrderMap, gensMap) { return nil }
        if !Relations.checkRelations(labelToOrderMap, gensMap) { return nil }
        deg0Elements = gens.filter { $0.deg == 0 && $0.label != "1" }
        zeroRelations = Relations.zeroRelations(labelToOrderMap)
        relations = Relations.relations(labelToOrderMap)
    }
}

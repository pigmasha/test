//
//  Step_7_mult.swift
//
//  Created by M on 29.11.2021.
//

import Foundation

struct Step_7_mult {
    static func runCase() -> Bool {
        //return MultEnvironment(all: true) == nil
        guard let env = MultEnvironment(all: false) else { return true }
        var gensByDeg: [[GenElement]] = []
        let degMax = PathAlg.N == 3 ? 50 : PathAlg.alg.someNumber
        for deg in 0 ... degMax {
            if GensByDeg.gens(for: deg, env.labelToOrderMap) == nil { return true }
            let items: [GenElement]
            if let gens = GensByDeg.gens(for: deg, env.labelToOrderMap) {
                if gens.count != Dim.dimHH(deg) {
                    OutputFile.writeLog(.error, "Bad gens count for deg \(deg): \(gens.count)")
                    return true
                }
                guard let ii = process(gens: gens, deg: deg, env) else { return true }
                items = ii
            } else {
                let checker = GenCreate(deg: deg)
                guard let ii = searchElements(deg: deg, gensByDeg: gensByDeg, checker: checker, env) else { return true }
                if ii.count != Dim.dimHH(deg) {
                    OutputFile.writeLog(.error, "Bad search gens count for deg \(deg): \(ii.count), need \(Dim.dimHH(deg))")
                    let gens = searchAllVariants(deg: deg, checker: checker, count: Dim.dimHH(deg) - ii.count)
                    gens.forEach { OutputFile.writeLog(.normal, $0.str) }
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

    private static func sum(for labels: [Int], _ env: MultEnvironment) -> [[Int]]? {
        guard let relation = env.sumRelations.first(where: { labels.d3HasSubarray($0.0) }) else { return nil }
        return [relation.1, relation.2].compactMap { r in
            var item = Array(labels)
            item.d3Replace(relation.0, to: r)
            return isZero(item, env.zeroRelations) ? nil : item
        }
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
        return genElement(from: strLabels(for: labels, env), deg: g1.deg + g2.deg, env.labelToOrderMap, env.gensMap)
    }

    private static func process(gens: [[String]], deg: Int, _ env: MultEnvironment) -> [GenElement]? {
        var items: [GenElement] = []
        let checker = GenCreate(deg: deg)
        for g in gens {
            if g.count == 1 && g[0] == "1" { continue }
            guard let e = genElement(from: g, deg: deg, env.labelToOrderMap, env.gensMap) else { return nil }
            guard let g0 = e.gen else { OutputFile.writeLog(.error, "No e \(g)"); return nil }
            if let err = checker.check(g0) {
                OutputFile.writeLog(.error, "\(strLabels(for: e, env)): " + g0.str + ": " + err)
                return nil
            }
            items.append(e)
        }
        return items
    }

    private static func strLabels(for items: [Int], _ env: MultEnvironment) -> [String] {
        return items.map { env.orderToLabelMap[$0]! }
    }

    private static func strLabels(for g: GenElement, _ env: MultEnvironment) -> [String] {
        return strLabels(for: g.items, env)
    }

    private enum MultSearchResult {
        case zero, exist
    }

    private static func searchElements(deg: Int, gensByDeg: [[GenElement]], checker: GenCreate, _ env: MultEnvironment) -> [GenElement]? {
        var ii: [GenElement] = []
        var relationElements: [GenElement] = []
        let knownElements = env.gens.filter { $0.deg == deg && $0.label != "1" }
        var hasZeros = false
        let inImChecker = GenCreate(deg: deg)

        let searchLabels: ([Int]) -> MultSearchResult? = { labels in
            if ii.d3Contains(labels) || relationElements.d3Contains(labels) { return .exist }
            if isZero(labels, env.zeroRelations) { return .zero }
            if let sum = sum(for: labels, env) {
                if sum.isEmpty { return .zero }
                if !sum.contains(where: { !ii.d3Contains($0) }) { return .exist }
            }
            return nil
        }
        for g in knownElements {
            if let err = checker.check(g) { OutputFile.writeLog(.error, g.str + ": " + err); return nil }
            guard let ge = genElement(from: [g.label], deg: deg, env.labelToOrderMap, env.gensMap) else { return nil }
            ii.append(ge)
            for e0 in env.deg0Elements {
                let e0Order = env.labelToOrderMap[e0.label]!
                var labels = [env.labelToOrderMap[g.label]!]
                while true {
                    labels = multLabels(labels, [e0Order], env)
                    if let result = searchLabels(labels) {
                        if result == .exist { continue }
                        if result == .zero { break }
                    }
                    let label0 = strLabels(for: labels, env)
                    guard let ge1 = genElement(from: label0, deg: deg, env.labelToOrderMap, env.gensMap) else { return nil }
                    guard let e1 = ge1.gen, inImChecker.checkNotIm(e1, inIm: true) != nil else {
                        printZeroRelation(label0); hasZeros = true; break
                    }
                    if let err = checker.check(e1) {
                        if searchNewRelation(e1, labels: label0, ii, inImChecker, env) {
                            relationElements.append(ge1)
                            hasZeros = true
                        } else {
                            OutputFile.writeLog(.error, e1.str + " (\(label0)): " + err)
                            return nil
                        }
                    } else {
                        ii.append(ge1)
                    }
                }
            }
        }
        if gensByDeg.count < 2 {
            if hasZeros { OutputFile.writeLog(.error, "Zero!"); return nil }
            return ii
        }
        for i in 1 ..< gensByDeg.count {
            for j in i ..< gensByDeg.count {
                if i + j != deg { continue }
                let gens1 = gensByDeg[i]
                let gens2 = gensByDeg[j]
                for g1 in gens1 {
                    for g2 in gens2 {
                        let labels = multLabels(g1.items, g2.items, env)
                        if searchLabels(labels) != nil { continue }
                        guard let ge1 = genElement(mult: g1, and: g2, labels: labels, env) else {
                            OutputFile.writeLog(.error, "Can't mult \(strLabels(for: g1, env)) and \(strLabels(for: g2, env))")
                            return nil
                        }
                        let labels0 = strLabels(for: labels, env)
                        guard let e1 = ge1.gen, inImChecker.checkNotIm(e1, inIm: true) != nil else {
                            printZeroRelation(labels0); hasZeros = true; continue
                        }
                        if let err = checker.check(e1) {
                            if searchNewRelation(e1, labels: labels0, ii, inImChecker, env) {
                                relationElements.append(ge1)
                                hasZeros = true
                            } else {
                                OutputFile.writeLog(.error, "\(labels0):: " + e1.str + ": " + err)
                                return nil
                            }
                        } else {
                            ii.append(ge1)
                        }
                    }
                }
            }
        }
        if hasZeros { OutputFile.writeLog(.error, "Zero!"); return nil }
        return ii
    }

    private static func searchNewRelation(_ g: Gen, labels: [String], _ existingElements: [GenElement],
                                          _ inImChecker: GenCreate, _ env: MultEnvironment) -> Bool {
        for kk in 0 ... 1 {
            let koef = kk == 0 ? -1 : 1
            for i0 in existingElements {
                let e2 = i0.gen!
                let k2 = kk == 0 ? g.eqKoef(e2) : 0
                let newRelation: Bool
                if k2 != 0 {
                    newRelation = true
                } else if let e2 = Gen(sum: g, and: e2, koef: koef), inImChecker.checkNotIm(e2, inIm: true) == nil {
                    newRelation = true
                } else {
                    newRelation = false
                }
                if newRelation {
                    printRelation(labels, and: strLabels(for: i0, env), koef: k2 != 0 ? k2 : -koef)
                    return true
                }
            }
        }
        for kk in 0 ... 1 {
            let koef = kk == 0 ? -1 : 1
            for i in 0 ..< existingElements.count - 1 {
                let g1 = existingElements[i].gen!
                for j in i + 1 ..< existingElements.count {
                    let g2 = existingElements[j].gen!
                    guard let g3 = Gen(sum: g1, and: g2, koef: koef) else { continue }
                    let k2 = g.eqKoef(g3)
                    if k2 == 0 { continue }
                    let g1Labels = strLabels(for: existingElements[i], env)
                    let g2Labels = strLabels(for: existingElements[j], env)
                    if k2 != 1 && k2 != -1 {
                        OutputFile.writeLog(.error, "Bad sum relation koef \(k2)")
                        return false
                    }
                    OutputFile.writeLog(.normal, "(\(relationString(from: labels)), "
                                        + "\(k2), \(relationString(from: g1Labels)), "
                                        + "\(k2 * koef), \(relationString(from: g2Labels))),")
                    return true
                }
            }
        }
        return false
    }

    private static func relationString(from labels: [String]) -> String {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        var s = "\(labels)"
        if n3 > 1 {
            let c12_n3_1 = "[\"" + (0 ..< n3 - 1).map { _ in "c12" }.joined(separator: "\", \"") + "\", "
            s = s.replacingOccurrences(of: c12_n3_1, with: "c12_n3_1 + [")
        }
        if n1 > 1 {
            let c23_n1_1 = "[\"" + (0 ..< n1 - 1).map { _ in "c23" }.joined(separator: "\", \"") + "\", "
            s = s.replacingOccurrences(of: c23_n1_1, with: "c23_n1_1 + [")
        }
        if n2 > 1 {
            let c31_n2_1 = "[\"" + (0 ..< n2 - 1).map { _ in "c31" }.joined(separator: "\", \"") + "\", "
            s = s.replacingOccurrences(of: c31_n2_1, with: "c31_n2_1 + [")
        }
        return s
    }

    private static func printZeroRelation(_ labels: [String]) {
        OutputFile.writeLog(.normal, relationString(from: labels) + ",")
    }

    private static func printRelation(_ labels: [String], and labels2: [String], koef: Int) {
        OutputFile.writeLog(.normal, "(\(relationString(from: labels)), \(relationString(from: labels2)), \"\(koef)\", \(koef)), ")
    }

    private static func multLabels(_ g1: [Int], _ g2: [Int], _ env: MultEnvironment) -> [Int] {
        var labels = g1
        g2.forEach { labels.d3Add($0) }
        while true {
            guard let r = env.relations.first(where: { labels.d3HasSubarray($0.0) }) else { return labels }
            labels.d3Replace(r.0, to: r.1)
        }
        return labels
    }

    private static func checkElements(items: [GenElement], deg: Int, gensByDeg: [[GenElement]], _ env: MultEnvironment) -> Bool {
        let knownElements = env.gens.filter { $0.deg == deg && $0.label != "1" }

        let searchLabels: ([Int]) -> MultSearchResult? = { labels in
            if isZero(labels, env.zeroRelations) { return .zero }
            if let sum = sum(for: labels, env) {
                if sum.isEmpty { return .zero }
                if !sum.contains(where: { !items.d3Contains($0) }) { return .exist }
            }
            if items.d3Contains(labels) { return .exist }
            OutputFile.writeLog(.error, "\(strLabels(for: labels, env)): checkElements not found")
            return nil
        }

        for g in knownElements {
            if !items.d3Contains([env.labelToOrderMap[g.label]!]) { return false }
            for e0 in env.deg0Elements {
                let e0Order = env.labelToOrderMap[e0.label]!
                var labels = [env.labelToOrderMap[g.label]!]
                while true {
                    labels = multLabels(labels, [e0Order], env)
                    guard let result = searchLabels(labels) else { return false }
                    if result == .zero { break }
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
                        if searchLabels(multLabels(g1.items, g2.items, env)) == nil { return false }
                    }
                }
            }
        }
        return true
    }

    private static func searchAllVariants(deg: Int, checker: GenCreate, count: Int) -> [Gen] {
        var gens: [Gen] = []
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
        if gens.count == count { return gens }
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
                if gens.count == count { return gens }
                OutputFile.writeLog(.normal, "Add \(g.str)")
            }
        }
        return gens
    }
}

final class MultEnvironment {
    let labelToOrderMap: [String: Int]
    let orderToLabelMap: [Int: String]
    let zeroRelations: [[Int]]
    let relations: [([Int], [Int])]
    let sumRelations: [([Int], [Int], [Int])]
    let gens: [Gen]
    let gensMap: [String: Gen]
    let deg0Elements: [Gen]

    init?(all: Bool) {
        let elementsOrder = MultEnvironment.elementsOrder
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
        for g in gens {
            gensMap[g.label] = g
            if g.label != "1" && labelToOrderMap[g.label] == nil {
                OutputFile.writeLog(.error, "No order for gen " + g.label)
                return nil
            }
        }
        self.gensMap = gensMap
        if !Relations.checkZeroRelations(all: all, labelToOrderMap, gensMap) { return nil }
        if !Relations.checkRelations(all: all, labelToOrderMap, gensMap) { return nil }
        if !Relations.checkSumRelations(labelToOrderMap, gensMap) { return nil }
        deg0Elements = gens.filter { $0.deg == 0 && $0.label != "1" }
        zeroRelations = Relations.zeroRelations(labelToOrderMap)
        relations = Relations.relations(labelToOrderMap)
        sumRelations = Relations.sumRelations(labelToOrderMap)
    }

    private static var elementsOrder: [String] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let d1: [String]
        if NumInt.isZero(n: n1) && NumInt.isZero(n: n2) && NumInt.isZero(n: n3) {
            d1 = ["w23", "w31", "w12"]
        } else if NumInt.isZero(n: n1) && NumInt.isZero(n: n2) {
            d1 = ["w23", "w31", "x1"]
        } else if NumInt.isZero(n: n1) {
            d1 = ["w23", "x1", "x3"]
        } else {
            d1 = ["w"]
        }
        let d3: [String]
        if NumInt.isZero(n: n1) && NumInt.isZero(n: n2) && NumInt.isZero(n: n3) {
            d3 = ["w23_h", "w31_h", "w12_h"]
        } else if NumInt.isZero(n: n1) && NumInt.isZero(n: n2) {
            d3 = ["w23_h", "w31_h", "x1_h"]
        } else if NumInt.isZero(n: n1) {
            d3 = ["w23_h", "x1_h", "x3_h"]
        } else {
            d3 = []
        }
        return ["c12", "c23", "c31", "z1"] + d1
        + ["x12", "x23", "x31", "u1", "u2"] + (NumInt.isZero(n: n1) ? ["q"] : []) // deg=2
        + d3 + ["e", "e1_h", "e2_h"]
        + (NumInt.isZero(n: n1) ? ["u1_h", "u2_h"] : [])
    }
}

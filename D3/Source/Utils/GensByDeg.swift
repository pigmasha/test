//
//  GensByDeg.swift
//
//  Created by M on 01.12.2021.
//

import Foundation

struct GensByDeg {
    static func gens(for deg: Int, _ orderMap: [String: Int]) -> [[String]]? {
        switch deg {
        case 0: return deg0Gens
        case 1: return deg1Gens
        case 2: return deg2Gens
        case 3: return deg3Gens
        case 4: return deg4Gens
        default:
            guard let prevGens = gens(for: deg - 4, orderMap) else { return nil }
            let uGens = prevGens.filter { $0.contains("u1") || $0.contains("u2") }
            let eGens = prevGens.filter { !$0.contains("u1") && !$0.contains("u2") }
            let sameArr: (String, Int) -> [String] = { s, c in
                return c == 0 ? [] : (1 ... c).map { _ in s }
            }
            let isSame: ([[String]], [[String]]) -> Bool = { a1, a2 in
                if a1.count != a2.count { return false }
                for i1 in a1 {
                    if !a2.contains(where: { i2 in
                        if i1.count != i2.count { return false }
                        for i in 0 ..< i1.count {
                            if i1[i] != i2[i] { return false }
                        }
                        return true
                    }) { return false }
                }
                return true
            }
            var result: [[String]] = []
            let eOrder = orderMap["e"]!
            for g in eGens {
                var j = -1
                for i in 0 ..< g.count {
                    if orderMap[g[i]]! > eOrder {
                        j = i
                        break
                    }
                }
                var g1 = g
                if j == -1 {
                    g1.append("e")
                } else {
                    g1.insert("e", at: j)
                }
                result.append(g1)
            }
            let h1 = sameArr("e1_h", deg / 6)
            let h2 = sameArr("e2_h", deg / 6)
            let myUGens: [[String]]
            switch deg % 6 {
            case 0:
                myUGens = [["u1"] + sameArr("e1_h", (deg / 6) - 1), ["u2"] + sameArr("e2_h", (deg / 6) - 1)]
                result.append(h1)
                result.append(h2)
            case 1:
                myUGens = [["z1", "u1"] + sameArr("e1_h", (deg / 6) - 1), ["z1", "u2"] + sameArr("e2_h", (deg / 6) - 1)]
                result.append(["z1"] + h1)
                result.append(["z1"] + h2)
                if NumInt.isZero(n: PathAlg.n1) {
                    result.append(sameArr("e1_h", deg / 6 - 1) + ["u1_h"])
                    result.append(sameArr("e2_h", deg / 6 - 1) + ["u2_h"])
                } else {
                    result.append(["w"] + h1)
                    result.append(["w"] + h2)
                }

            case 2:
                myUGens = []
                result.append(["u1"] + h1)
                result.append(["u2"] + h2)
                if NumInt.isZero(n: PathAlg.n1) {
                    result.append(["z1"] + sameArr("e1_h", deg / 6 - 1) + ["u1_h"])
                    result.append(["z1"] + sameArr("e2_h", deg / 6 - 1) + ["u2_h"])
                } else {
                    result.append(["z1", "w"] + h1)
                    result.append(["z1", "w"] + h2)
                }
            case 3:
                myUGens = []
                result.append(["z1", "u1"] + h1)
                result.append(["z1", "u2"] + h2)
            case 4, 5:
                myUGens = []
            default:
                fatalError("Bad deg % 6=\(deg % 6)")
            }
            if !isSame(uGens, myUGens) {
                OutputFile.writeLog(.error, "GensByDeg \(deg): bad uGens: \(uGens)")
                return nil
            }
            return result
        }
    }

    private static func add(from: Int, to: Int, c: String, g: [String], to arr: inout [[String]]) {
        guard from <= to else { return }
        for i in from ... to {
            arr.append((0 ..< i).map { _ in c } + g)
        }
    }

    private static var deg0Gens: [[String]] {
        var result: [[String]] = [["1"]]
        add(from: 1, to: PathAlg.n3, c: "c12", g: [], to: &result)
        add(from: 1, to: PathAlg.n1, c: "c23", g: [], to: &result)
        add(from: 1, to: PathAlg.n2, c: "c31", g: [], to: &result)
        return result
    }

    private static var deg1Gens: [[String]] {
        if !NumInt.isZero(n: PathAlg.n1) {
            var result: [[String]] = [["z1"], ["w"]]
            add(from: 1, to: PathAlg.n3 - 1, c: "c12", g: ["w"], to: &result)
            add(from: 1, to: PathAlg.n1 - 1, c: "c23", g: ["w"], to: &result)
            add(from: 1, to: PathAlg.n2 - 1, c: "c31", g: ["w"], to: &result)
            return result
        }
        var result: [[String]] = [["z1"]]
        if !NumInt.isZero(n: PathAlg.n2) {
            add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["w23"], to: &result)
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["x1"], to: &result)
            add(from: 0, to: PathAlg.n2 - 2, c: "c31", g: ["x3"], to: &result)
            return result
        }
        if !NumInt.isZero(n: PathAlg.n3) {
            add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["w23"], to: &result)
            add(from: 0, to: PathAlg.n2 - 1, c: "c31", g: ["w31"], to: &result)
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["x1"], to: &result)
            return result
        }
        add(from: 0, to: PathAlg.n3 - 1, c: "c12", g: ["w12"], to: &result)
        add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["w23"], to: &result)
        add(from: 0, to: PathAlg.n2 - 1, c: "c31", g: ["w31"], to: &result)
        return result
    }

    private static var deg2Gens: [[String]] {
        if !NumInt.isZero(n: PathAlg.n1) {
            var result: [[String]] = [["u1"], ["u2"], ["z1", "w"]]
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["x12"], to: &result)
            add(from: 0, to: PathAlg.n1 - 2, c: "c23", g: ["x23"], to: &result)
            add(from: 0, to: PathAlg.n2 - 2, c: "c31", g: ["x31"], to: &result)
            return result
        }
        var result: [[String]] = [["u1"], ["u2"], ["q"]]
        if !NumInt.isZero(n: PathAlg.n2) {
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["x12"], to: &result)
            add(from: 0, to: PathAlg.n1 - 2, c: "c23", g: ["x23"], to: &result)
            add(from: 0, to: PathAlg.n2 - 2, c: "c31", g: ["x31"], to: &result)
            return result
        }
        if !NumInt.isZero(n: PathAlg.n3) {
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["x12"], to: &result)
            add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["x23"], to: &result)
            add(from: 0, to: PathAlg.n2 - 2, c: "c31", g: ["x31"], to: &result)
            return result
        }
        add(from: 0, to: PathAlg.n3 - 1, c: "c12", g: ["x12"], to: &result)
        add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["x23"], to: &result)
        add(from: 0, to: PathAlg.n2 - 2, c: "c31", g: ["x31"], to: &result)
        return result
    }

    private static var deg3Gens: [[String]] {
        var result: [[String]] = [["z1", "u1"], ["z1", "u2"]]
        if !NumInt.isZero(n: PathAlg.n1) {
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["w", "x12"], to: &result)
            add(from: 0, to: PathAlg.n1 - 2, c: "c23", g: ["w", "x23"], to: &result)
            add(from: 0, to: PathAlg.n2 - 2, c: "c31", g: ["w", "x31"], to: &result)
            return result
        }
        if !NumInt.isZero(n: PathAlg.n2) {
            add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["w23_h"], to: &result)
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["x1_h"], to: &result)
            add(from: 0, to: PathAlg.n2 - 2, c: "c31", g: ["x3_h"], to: &result)
            return result
        }
        if !NumInt.isZero(n: PathAlg.n3) {
            add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["w23_h"], to: &result)
            add(from: 0, to: PathAlg.n2 - 1, c: "c31", g: ["w31_h"], to: &result)
            add(from: 0, to: PathAlg.n3 - 2, c: "c12", g: ["x1_h"], to: &result)
            return result
        }
        add(from: 0, to: PathAlg.n3 - 1, c: "c12", g: ["w12_h"], to: &result)
        add(from: 0, to: PathAlg.n1 - 1, c: "c23", g: ["w23_h"], to: &result)
        add(from: 0, to: PathAlg.n2 - 1, c: "c31", g: ["w31_h"], to: &result)
        return result
    }

    private static var deg4Gens: [[String]] {
        var result: [[String]] = [["e"]]
        if !NumInt.isZero(n: PathAlg.n1) {
            add(from: 1, to: PathAlg.n3 - 1, c: "c12", g: ["e"], to: &result)
            add(from: 1, to: PathAlg.n1 - 1, c: "c23", g: ["e"], to: &result)
            add(from: 1, to: PathAlg.n2 - 1, c: "c31", g: ["e"], to: &result)
            return result
        }
        if !NumInt.isZero(n: PathAlg.n2) {
            add(from: 1, to: PathAlg.n3 - 1, c: "c12", g: ["e"], to: &result)
            add(from: 1, to: PathAlg.n1, c: "c23", g: ["e"], to: &result)
            add(from: 1, to: PathAlg.n2 - 1, c: "c31", g: ["e"], to: &result)
            return result
        }
        if !NumInt.isZero(n: PathAlg.n3) {
            add(from: 1, to: PathAlg.n3 - 1, c: "c12", g: ["e"], to: &result)
            add(from: 1, to: PathAlg.n1, c: "c23", g: ["e"], to: &result)
            add(from: 1, to: PathAlg.n2, c: "c31", g: ["e"], to: &result)
            return result
        }
        add(from: 1, to: PathAlg.n3, c: "c12", g: ["e"], to: &result)
        add(from: 1, to: PathAlg.n1, c: "c23", g: ["e"], to: &result)
        add(from: 1, to: PathAlg.n2, c: "c31", g: ["e"], to: &result)
        return result
    }
}

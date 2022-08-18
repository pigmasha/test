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
        default:
            var result: [[String]] = []
            guard let prev = gens(for: deg - 4, orderMap) else { return nil }
            result.append(contentsOf: prev.map { (($0[0] == "1") ? [] : $0) + ["t"] })
            let k = PathAlg.kk
            if deg % 2 == 0 {
                let s = deg / 2
                result += [
                    (1 ... s).map { _ in "v1" },
                    (1 ... s).map { _ in "v2" },
                    (1 ... s - 1).map { _ in "v1" } + ["v6"],
                            (1 ... s - 1).map { _ in "v2" } + ["v6"]
                ]
            } else {
                let s = (deg - 1) / 2
                result += [
                    ["u3"] + (1 ... s).map { _ in "v1" },
                    ["u4"] + (1 ... s).map { _ in "v2" },
                    (1 ... s - 1).map { _ in "v1" } + [k % 2 == 0 ? "w1" : "w1'"],
                    (1 ... s - 1).map { _ in "v2" } + [k % 2 == 0 ? "w2" : "w2'"]
                ]
            }
            return result
        }
    }

    private static func add(from: Int, to: Int, g: [String], to arr: inout [[String]]) {
        guard from <= to else { return }
        for i in from ... to {
            arr.append((0 ..< i).map { _ in "p1" } + g)
        }
    }

    private static var deg0Gens: [[String]] {
        var result: [[String]] = [["1"], ["p2"], ["p3"], ["p4"]]
        add(from: 1, to: PathAlg.kk - 1, g: [], to: &result)
        return result
    }

    private static var deg1Gens: [[String]] {
        var result: [[String]] = [["u2"], ["p2", "u2"], ["p3", "u2"], ["u3"], ["u4"]]
        if PathAlg.kk % 2 == 0 {
            add(from: 0, to: PathAlg.kk - 1, g: ["u1"], to: &result)
        } else {
            add(from: 0, to: PathAlg.kk - 2, g: ["u1'"], to: &result)
        }
        return result
    }

    private static var deg2Gens: [[String]] {
        var result: [[String]] = [["v1"], ["v2"], ["v3"], ["v4"], ["v6"], ["p4", "v1"]]
        add(from: 0, to: PathAlg.kk - 2, g: ["v5"], to: &result)
        if PathAlg.kk % 2 == 0 {
            result += [ ["p4", "v2"] ]
        }
        return result
    }

    private static var deg3Gens: [[String]] {
        var result: [[String]] = [["u2", "v1"], ["u3", "v1"], ["u4", "v2"], ["u2", "v3"], ["u2", "v4"]]
        if PathAlg.kk % 2 == 0 {
            result += [ ["w1"], ["w2"] ]
            add(from: 0, to: PathAlg.kk - 2, g: ["u1", "v5"], to: &result)
        } else {
            result += [ ["w2'"] ]
            add(from: 0, to: PathAlg.kk - 1, g: ["w1'"], to: &result)
        }
        return result
    }
}

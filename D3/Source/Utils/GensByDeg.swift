//
//  GensByDeg.swift
//
//  Created by M on 01.12.2021.
//

import Foundation

struct GensByDeg {
    static func gens(for deg: Int) -> [[String]]? {
        let n1Zero = NumInt.isZero(n: PathAlg.n1)
        switch deg {
        case 0: return deg0Gens
        case 1: return n1Zero ? nil : deg1Gens
        case 2: return n1Zero ? nil : deg2Gens
        case 3: return n1Zero ? nil : deg3Gens
        case 4: return n1Zero ? nil : deg4Gens
        default: return nil
        }
    }

    private static var deg0Gens: [[String]] {
        var result: [[String]] = [["1"]]
        for i in 1 ... PathAlg.n3 {
            result.append((0 ..< i).map { _ in "c12" })
        }
        for i in 1 ... PathAlg.n1 {
            result.append((0 ..< i).map { _ in "c23" })
        }
        for i in 1 ... PathAlg.n2 {
            result.append((0 ..< i).map { _ in "c31" })
        }
        return result
    }

    private static var deg1Gens: [[String]] {
        var result: [[String]] = [["z1"], ["w"]]
        if PathAlg.n3 > 1 {
            for i in 1 ... PathAlg.n3 - 1 {
                result.append((0 ..< i).map { _ in "c12" } + ["w"])
            }
        }
        if PathAlg.n1 > 1 {
            for i in 1 ... PathAlg.n1 - 1 {
                result.append((0 ..< i).map { _ in "c23" } + ["w"])
            }
        }
        if PathAlg.n2 > 1 {
            for i in 1 ... PathAlg.n2 - 1 {
                result.append((0 ..< i).map { _ in "c31" } + ["w"])
            }
        }
        return result
    }

    private static var deg2Gens: [[String]] {
        var result: [[String]] = [["u1"], ["u2"], ["z1", "w"]]
        if PathAlg.n3 > 1 {
            for i in 0 ... PathAlg.n3 - 2 {
                result.append((0 ..< i).map { _ in "c12" } + ["x12"])
            }
        }
        if PathAlg.n1 > 1 {
            for i in 0 ... PathAlg.n1 - 2 {
                result.append((0 ..< i).map { _ in "c23" } + ["x23"])
            }
        }
        if PathAlg.n2 > 1 {
            for i in 0 ... PathAlg.n2 - 2 {
                result.append((0 ..< i).map { _ in "c31" } + ["x31"])
            }
        }
        return result
    }

    private static var deg3Gens: [[String]] {
        var result: [[String]] = [["z1", "u1"], ["z1", "u2"]]
        if PathAlg.n3 > 1 {
            for i in 0 ... PathAlg.n3 - 2 {
                result.append((0 ..< i).map { _ in "c12" } + ["w", "x12"])
            }
        }
        if PathAlg.n1 > 1 {
            for i in 0 ... PathAlg.n1 - 2 {
                result.append((0 ..< i).map { _ in "c23" } + ["w", "x23"])
            }
        }
        if PathAlg.n2 > 1 {
            for i in 0 ... PathAlg.n2 - 2 {
                result.append((0 ..< i).map { _ in "c31" } + ["w", "x31"])
            }
        }
        return result
    }

    private static var deg4Gens: [[String]] {
        var result: [[String]] = [["e"]]
        if PathAlg.n3 > 1 {
            for i in 1 ... PathAlg.n3 - 1 {
                result.append((0 ..< i).map { _ in "c12" } + ["e"])
            }
        }
        if PathAlg.n1 > 1 {
            for i in 1 ... PathAlg.n1 - 1 {
                result.append((0 ..< i).map { _ in "c23" } + ["e"])
            }
        }
        if PathAlg.n2 > 1 {
            for i in 1 ... PathAlg.n2 - 1 {
                result.append((0 ..< i).map { _ in "c31" } + ["e"])
            }
        }
        return result
    }
}

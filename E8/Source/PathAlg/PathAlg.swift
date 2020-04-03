//
//  Created by M on 09.04.16.
//

import Foundation

func myMod(_ number: Int, mod: Int) -> Int {
    let nn = number % mod
    return (nn < 0) ? nn + mod : nn
}

func myModS(_ number: Int) -> Int {
    return myMod(number, mod: PathAlg.s)
}

func myMod2S(_ number: Int) -> Int {
    return myMod(number, mod: 2 * PathAlg.s)
}

final class PathAlg {
    static var vertexMod: Int {
        return 8 * s
    }

    static var s: Int {
        get {
            return alg.s
        }
        set {
            alg.s = newValue
        }
    }
    static var n: Int {
        get {
            return alg.n
        }
        set {
            alg.n = newValue
        }
    }
    static var charK: Int {
        get {
            return alg.charK
        }
        set {
            alg.charK = newValue
        }
    }

    static let alg = PathAlg()
    var dummy1 = 0
    var currentType = 0
    var currentStep = 0
    private var n = 0
    private var s = 0
    private var charK = 0

    static let twistPeriod = 29

    static func sigma(_ i: Int) -> Int {
        return 15 * n + i
    }

    static func modCharK(_ k: Int) -> Int {
        let charK = PathAlg.charK
        guard charK != 0 else { return k }
        var k2 = k
        while k2 >= charK { k2 -= charK }
        while k2 < 0 { k2 += charK }
        if charK == 5 && k2 == 4 { return -1 }
        return charK == 3 && k2 == 2 ? -1 : k2
    }

    static func modCharK2(_ k: Double) -> Double {
        let charK = Double(PathAlg.charK)
        guard charK != 0 else { return k }
        var k2 = k
        while k2 >= charK { k2 -= charK }
        while k2 < 0 { k2 += charK }
        if charK == 5 && k2 == 4 { return -1 }
        return charK == 3 && k2 == 2 ? -1 : k2
    }
}

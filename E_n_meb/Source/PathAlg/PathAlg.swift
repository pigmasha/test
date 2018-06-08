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
    var dummy1: Int
    private var n: Int
    private var s: Int
    private var charK: Int

    static let twistPeriod = 11

    static func sigma(_ i: Int) -> Int {
        return 4 * (n + s) + i
    }

    static func sigma(_ i: Int, isGamma: Bool) -> Int {
        if isGamma { return (myMod(i, mod: s) == s - 1) ? 1 : -1 }

        let j = myMod(i, mod: 3)
        switch j {
        case 0:
            return (myMod(i, mod: 6 * s) < 3 * s) ? -1 : 1
        case 2:
            return (myMod(i, mod: 6 * s) < 3 * s) ? 1 : -1
        default:
            return -1
        }
    }

    static func sigmaDeg(_ deg: Int, i: Int, isGamma: Bool) -> Int {
        if deg == 0 { return 1 }

        var res = 1
        var ii = i
        for _ in 1...deg {
            res *= sigma(ii, isGamma: isGamma)
            ii = isGamma ? ii + n : ii + 3 * (n + s)
        }
        return res
    }

    static func k1J(_ ell: Int, j: Int, m: Int) -> Int {
        return sigmaDeg(ell, i: 3 * (j + m), isGamma: false)
    }

    static func k1JPlus1(_ ell: Int, j: Int, m: Int) -> Int {
        return sigmaDeg(ell, i: 3 * (j + m + 1), isGamma: false)
    }

    static func k1JPlus2(_ ell: Int, j: Int, m: Int) -> Int {
        return sigmaDeg(ell, i: 3 * (j + m + 2), isGamma: false)
    }

    static func kGamma(_ ell: Int, j: Int, m: Int) -> Int {
        return sigmaDeg(ell, i: j + m, isGamma: true)
    }

    static func modCharK(_ k: Int) -> Int {
        let charK = PathAlg.charK
        guard charK != 0 else { return k }
        var k2 = k
        while k2 >= charK { k2 -= charK }
        while k2 < 0 { k2 += charK }
        return charK == 3 && k2 == 2 ? -1 : k2
    }

    static func modCharK2(_ k: Double) -> Double {
        let charK = Double(PathAlg.charK)
        guard charK != 0 else { return k }
        var k2 = k
        while k2 >= charK { k2 -= charK }
        while k2 < 0 { k2 += charK }
        return charK == 3 && k2 == 2 ? -1 : k2
    }

    init() {
        self.n = 0
        self.s = 0
        self.charK = 0
        self.dummy1 = 0
    }
}

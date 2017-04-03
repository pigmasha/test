//
//  Created by M on 09.04.16.
//
//

import Foundation

func myMod(_ number: Int, mod: Int) -> Int {
    let nn = number % mod
    return (nn < 0) ? nn + mod : nn
}

func myModS(_ number: Int) -> Int {
    return myMod(number, mod: PathAlg.alg.s)
}

func myMod2S(_ number: Int) -> Int {
    return myMod(number, mod: 2 * PathAlg.alg.s)
}

final class PathAlg: NSObject {
    static let alg = PathAlg()

    var n: Int
    var s: Int
    var charK: Int

    var twistPeriod: Int {
        return 11
    }

    func sigma(_ i: Int) -> Int {
        return 4 * (n + s) + i
    }

    func sigma(_ i: Int, isGamma: Bool) -> Int {
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

    func sigmaDeg(_ deg: Int, i: Int, isGamma: Bool) -> Int {
        if deg == 0 { return 1 }

        var res = 1
        var ii = i
        for _ in 1...deg {
            res *= sigma(ii, isGamma: isGamma)
            ii = isGamma ? ii + n : ii + 3 * (n + s)
        }
        return res
    }

    class func k1J(_ ell: Int, j: Int, m: Int) -> Int {
        return alg.sigmaDeg(ell, i: 3 * (j + m), isGamma: false)
    }

    class func k1JPlus1(_ ell: Int, j: Int, m: Int) -> Int {
        return alg.sigmaDeg(ell, i: 3 * (j + m + 1), isGamma: false)
    }

    class func kGamma(_ ell: Int, j: Int, m: Int) -> Int {
        return alg.sigmaDeg(ell, i: j + m, isGamma: true)
    }

    override init() {
        self.n = 0
        self.s = 0
        self.charK = 0
        super.init()
    }
}
//
//  Created by M on 30.09.21.
//

import Foundation

final class PathAlg {
    // k in N \ {1}
    static var k: Int {
        get { return alg.k }
        set { alg.k = newValue }
    }
    // c in field K
    static var c: Int {
        get { return alg.c }
        set { alg.c = newValue }
    }
    // d in field K
    static var d: Int {
        get { return alg.d }
        set { alg.d = newValue }
    }
    static var charK: Int {
        get { return alg.charK }
        set { alg.charK = newValue }
    }

    static let alg = PathAlg()
    var currentType = 0
    var currentStep = 0
    private var k = 0
    private var c = 0
    private var d = 0
    private var charK = 0

    static func modCharK(_ k: Int) -> Int {
        let charK = PathAlg.charK
        guard charK != 0 else { return k }
        var k2 = k
        while k2 >= charK { k2 -= charK }
        while k2 < 0 { k2 += charK }
        return k2
    }

    static func myMod(_ number: Int, mod: Int) -> Int {
        let nn = number % mod
        return (nn < 0) ? nn + mod : nn
    }
}

//
//  Created by M on 30.09.21.
//

import Foundation

final class PathAlg {
    static var n1: Int {
        get { return alg.n1 }
        set { alg.n1 = newValue }
    }
    static var n2: Int {
        get { return alg.n2 }
        set { alg.n2 = newValue }
    }
    static var n3: Int {
        get { return alg.n3 }
        set { alg.n3 = newValue }
    }
    static var charK: Int {
        get { return alg.charK }
        set { alg.charK = newValue }
    }
    static var isTex: Bool {
        return false
    }
    static var N: Int {
        return n1 + n2 + n3
    }

    private static var rkCCache: (String, Int)?
    static var rkC: Int {
        let cacheKey = "\(n1).\(n2).\(n3)"
        if let cache = rkCCache, cache.0 == cacheKey { return cache.1 }
        let rk = KoefIntMatrix(rows: [[n3, 0, -n2], [-n3, n1, 0], [0, -n1, n2]]).rank
        rkCCache = (cacheKey, rk)
        return rk
    }

    private static var rkC1Cache: (String, Int)?
    static var rkC1: Int {
        let cacheKey = "\(n1).\(n2).\(n3)"
        if let cache = rkC1Cache, cache.0 == cacheKey { return cache.1 }
        let rk = KoefIntMatrix(rows: [[n3, 0, n2], [n3, n1, 0], [0, n1, n2]]).rank
        rkC1Cache = (cacheKey, rk)
        return rk
    }

    static let alg = PathAlg()
    var currentType = 0
    var currentStep = 0
    var someNumber = 0
    private var n1 = 0
    private var n2 = 0
    private var n3 = 0
    private var charK = 0

    static func modCharK(_ k: Int) -> Int {
        let charK = PathAlg.charK
        guard charK != 0 else { return k }
        var k2 = k
        while k2 >= charK { k2 -= charK }
        while k2 < 0 { k2 += charK }
        return k2
    }
}

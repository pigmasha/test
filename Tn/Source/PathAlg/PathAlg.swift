//
//  Created by M on 30.09.21.
//

import Foundation

final class PathAlg {
    static var n: Int {
        get { return alg.n }
        set { alg.n = newValue }
    }
    static var charK: Int {
        get { return alg.charK }
        set { alg.charK = newValue }
    }
    static var isTex: Bool {
        get { return alg.isTex }
        set { alg.isTex = newValue }
    }

    static let alg = PathAlg()
    var currentType = 0
    var currentStep = 0
    var someNumber = 0
    private var n = 0
    private var charK = 0
    private var isTex = false

    static func modCharK(_ k: Int) -> Int {
        let charK = PathAlg.charK
        guard charK != 0 else { return k }
        var k2 = k
        while k2 >= charK { k2 -= charK }
        while k2 < 0 { k2 += charK }
        return k2
    }
}

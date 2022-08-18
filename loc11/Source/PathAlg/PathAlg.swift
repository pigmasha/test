//
//  Created by M on 30.09.21.
//

import Foundation

final class PathAlg {
    static var kk: Int {
        get { return alg.kk }
        set { alg.kk = newValue }
    }
    static var charK: Int { return 2 }
    static var isTex: Bool {
        get { return alg.isTex }
        set { alg.isTex = newValue }
    }

    static let alg = PathAlg()
    var currentType = 0
    var currentStep = 0
    var someNumber = 0
    private var kk = 0
    private var isTex = false

    static func modCharK(_ k: Int) -> Int {
        return k % 2 == 0 ? 0 : 1
    }
}

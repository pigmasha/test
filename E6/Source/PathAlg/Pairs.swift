//
//  Created by M on 21.04.16.
//

import Foundation

final class WayPair {
    let way: Way?
    let koef: Double

    convenience init() {
        self.init(way: nil, koef: 0)
    }
    
    init(way: Way?, koef: Double) {
        self.way = way
        self.koef = koef
    }

    class func pairWithWay(_ way: Way?, koef: Double) -> WayPair {
        return WayPair(way: way, koef: koef)
    }
}

final class TenzorPair {
    let tenzor: Tenzor
    var koef: Double

    init(tenzor: Tenzor, koef: Double) {
        self.tenzor = tenzor
        self.koef = koef
    }

    class func pairWithTenzor(_ tenzor: Tenzor, koef: Double) -> TenzorPair {
        return TenzorPair(tenzor: tenzor, koef: koef)
    }
}

final class IntPair {
    var n0: Int
    var n1: Int

    init(n0: Int, n1: Int) {
        self.n0 = n0
        self.n1 = n1
    }

    class func pairWithN0(_ n0: Int, n1: Int) -> IntPair {
        return IntPair(n0: n0, n1: n1)
    }
}

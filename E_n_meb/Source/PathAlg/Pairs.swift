//
//  Created by M on 21.04.16.
//
//

import Foundation

class WayPair: NSObject {
    let way: Way?
    let koef: Double

    init(way: Way?, koef: Double) {
        self.way = way
        self.koef = koef
        super.init()
    }

    class func pairWithWay(_ way: Way?, koef: Double) -> WayPair {
        return WayPair(way: way, koef: koef)
    }
}

class TenzorPair: NSObject {
    let tenzor: Tenzor
    var koef: Double

    init(tenzor: Tenzor, koef: Double) {
        self.tenzor = tenzor
        self.koef = koef
        super.init()
    }

    class func pairWithTenzor(_ tenzor: Tenzor, koef: Double) -> TenzorPair {
        return TenzorPair(tenzor: tenzor, koef: koef)
    }
}

class IntPair: NSObject {
    var n0: Int
    var n1: Int

    init(n0: Int, n1: Int) {
        self.n0 = n0
        self.n1 = n1
        super.init()
    }

    class func pairWithN0(_ n0: Int, n1: Int) -> IntPair {
        return IntPair(n0: n0, n1: n1)
    }
}

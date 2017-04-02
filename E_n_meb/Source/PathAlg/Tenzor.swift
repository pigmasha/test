//
//  Created by M on 21.04.16.
//
//

import Foundation

class Tenzor: NSObject {
    private var wLeft: Way
    private var wRight: Way

    init(left: Way, right: Way) {
        self.wLeft = Way(way: left)
        self.wRight = Way(way: right)
        super.init()
    }

    convenience init(tenzor: Tenzor) {
        self.init(left: tenzor.leftComponent, right: tenzor.rightComponent)
    }

    convenience init(byDivide bigTen: Tenzor, to smallTen: Tenzor) {
        if smallTen.isZero || bigTen.isZero {
            self.init(left: Way(), right: Way())
        } else {
            self.init(left: Way(from: smallTen.leftComponent.endsWith.number, to: bigTen.leftComponent.endsWith.number),
                      right: Way(from: bigTen.rightComponent.startsWith.number, to: smallTen.rightComponent.startsWith.number))
        }
    }

    var leftComponent: Way {
        return wLeft
    }

    var rightComponent: Way {
        return wRight
    }

    var isZero: Bool {
        return wLeft.isZero || wRight.isZero
    }

    func compRightW(_ way: Way) {
        wRight.compRight(way)
    }

    func compLeftW(_ way: Way) {
        wLeft.compLeft(way)
    }

    func compRight(_ tenzor: Tenzor) {
        wLeft.compLeft(tenzor.leftComponent)
        wRight.compRight(tenzor.rightComponent)
    }

    func compLeft(_ tenzor: Tenzor) {
        wLeft.compRight(tenzor.leftComponent)
        wRight.compLeft(tenzor.rightComponent)
    }

    func setTenzor(_ tenzor: Tenzor) {
        wLeft.setWay(tenzor.leftComponent)
        wRight.setWay(tenzor.rightComponent)
    }

    func setWays(_ left: Way, right: Way) {
        wLeft.setWay(left)
        wRight.setWay(right)
    }

    var str: String {
        return isZero ? "0" : "\(wLeft.str)*\(wRight.str)"
    }

    func isEq(_ other: Tenzor) -> Bool {
        return wLeft.isEq(other.leftComponent) && wRight.isEq(other.rightComponent)
    }
}

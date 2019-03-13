//
//  Created by M on 21.04.16.
//

import Foundation

final class Tenzor {
    private var wLeft: Way
    private var wRight: Way

    init(left: Way, right: Way) {
        self.wLeft = Way(way: left)
        self.wRight = Way(way: right)
    }

    convenience init(tenzor: Tenzor) {
        self.init(left: tenzor.leftComponent, right: tenzor.rightComponent)
    }

    convenience init(byDivide bigTen: Tenzor, to smallTen: Tenzor) {
        if smallTen.isZero || bigTen.isZero {
            self.init(left: Way(), right: Way())
        } else {
            var wayL = Way(from: smallTen.leftComponent.endsWith.number, to: bigTen.leftComponent.endsWith.number)
            var wayR = Way(from: bigTen.rightComponent.startsWith.number, to: smallTen.rightComponent.startsWith.number)
            if !wayL.isZero && wayL.len == 0 && smallTen.leftComponent.len < bigTen.leftComponent.len {
                let w = Way(from: smallTen.leftComponent.endsWith.number, to: bigTen.leftComponent.endsWith.number, noZeroLen: true)
                if !w.isZero { wayL = w }
            }
            if !wayR.isZero && wayR.len == 0 && smallTen.rightComponent.len < bigTen.rightComponent.len {
                let w = Way(from: bigTen.rightComponent.startsWith.number, to: smallTen.rightComponent.startsWith.number, noZeroLen: true)
                if !w.isZero { wayR = w }
            }
            self.init(left: wayL, right: wayR)
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

    var htmlStr: String {
        return isZero ? "0" : "\(wLeft.htmlStr)*\(wRight.htmlStr)"
    }

    func isEq(_ other: Tenzor) -> Bool {
        return wLeft.isEq(other.leftComponent) && wRight.isEq(other.rightComponent)
    }
}

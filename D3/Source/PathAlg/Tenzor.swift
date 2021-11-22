//
//  Created by M on 21.04.16.
//

import Foundation

final class Tenzor {
    var leftComponent: Way
    var rightComponent: Way

    init(left: Way, right: Way) {
        leftComponent = Way(way: left)
        rightComponent = Way(way: right)
    }

    convenience init(tenzor: Tenzor) {
        self.init(left: tenzor.leftComponent, right: tenzor.rightComponent)
    }

    var isZero: Bool {
        return leftComponent.isZero || rightComponent.isZero
    }

    func compRight(_ tenzor: Tenzor) {
        leftComponent.compLeft(tenzor.leftComponent)
        rightComponent.compRight(tenzor.rightComponent)
    }

    func setTenzor(_ tenzor: Tenzor) {
        leftComponent.setWay(tenzor.leftComponent)
        rightComponent.setWay(tenzor.rightComponent)
    }

    func hasPrefix(_ tenzor: Tenzor) -> Bool {
        return leftComponent.hasSuffix(tenzor.leftComponent) && rightComponent.hasPrefix(tenzor.rightComponent)
    }

    var str: String {
        return isZero ? "0" : leftComponent.str + (PathAlg.isTex ? "\\otimes " : "*") + rightComponent.str
    }

    func isEq(_ other: Tenzor) -> Bool {
        return leftComponent.isEq(other.leftComponent) && rightComponent.isEq(other.rightComponent)
    }
}

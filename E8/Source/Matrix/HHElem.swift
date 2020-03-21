//
//  Created by M on 24.04.16.
//

import Foundation

final class HHElem: Matrix {
    let deg: Int
    let type: Int

    override init() {
        self.deg = 0
        self.type = 0
        super.init()
    }

    init(deg: Int, type: Int) {
        self.deg = deg
        self.type = type
        super.init()
        createHH()
    }

    init(degree: Int, type: Int) {
        self.deg = degree
        self.type = type
        super.init()
    }

    static func addElemToHH(_ hh: HHElem, i: Int, j: Int, leftFrom from: Int, leftTo to: Int, right: Int, koef: Int,
                            noZeroLenL: Bool = false) {
        let wL = Way(from: from, to: to, noZeroLen: noZeroLenL)
        let wR = Way(from: right, to: right, noZeroLen: false)
        if wL.isZero || wR.isZero { return }

        hh.rows[i][j].addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: Double(koef)))
    }

    static func addElemToHH(_ hh: HHElem, i: Int, j: Int, leftFrom from: Int, leftTo to: Int,
                            rightFrom: Int, rightTo: Int, koef: Int, noZeroLenL: Bool = false, noZeroLenR: Bool = false) {
        let wL = Way(from: from, to: to, noZeroLen: noZeroLenL)
        let wR = Way(from: rightFrom, to: rightTo, noZeroLen: noZeroLenR)
        if wL.isZero || wR.isZero {
            fatalError("Zero ways \(wL.str)/\(wR.str) at \(i),\(j)")
            return
        }

        hh.rows[i][j].addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: Double(koef)))
    }
}

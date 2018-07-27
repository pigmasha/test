//
//  Created by M on 10.04.16.
//

import Foundation

final class ShiftHHElem02c : ShiftHHElem {
    init() {
        super.init(type:2)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:-1)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = myModS(6)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 6 * s + myModS(5)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 5 * s + 4
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 4 * s + 4
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = s + 4
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 2 * s + 3
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+1, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+1, koef:1)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        var j = 3
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)

        j = 8 * s + 2
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 4 * s + 2
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 5 * s + 1
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        var j = s + 1
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*(j+s)+1, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*(j+s)+1, koef:1)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 1
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)
    }

    override func koef11(s: Int, ell: Int) -> Int {
        return minusDeg(ell)
    }

    override func mainKoef(ell: Int) -> Int {
        return -PathAlg.k1J(ell, j:0, m:0)
    }
}

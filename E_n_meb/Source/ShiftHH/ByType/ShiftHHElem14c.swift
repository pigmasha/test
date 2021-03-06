//
//  Created by M on 20.07.2018.
//

import Foundation

final class ShiftHHElem14c: ShiftHHElem {
    init() {
        super.init(type:14)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = 7*s
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+3), noZeroLenL: true)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = 7*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+3), noZeroLenL: true)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 2*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+3), noZeroLenL: true)
        j = 3*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+3), noZeroLenL: true)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = myModS(3)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)-1, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:-f2(s,1)*PathAlg.k1J(ell, j: j, m: m+3), noZeroLenL: true)
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(s,1))+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(s,1)*PathAlg.k1J(ell, j: j, m: m+3), noZeroLenR: true)
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = myModS(2)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(s,1)*PathAlg.k1J(ell, j: j, m: m+3), noZeroLenR: true)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        let j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(s,1))+1, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell+1, j: j, m: m-1), noZeroLenR: true)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:9*s)

        let j = s + 2 - 3*f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-1, noZeroLenR: true)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        let j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(s,1))+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell+1, j: j, m: m-1), noZeroLenR: true)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        let j = s + 2 - 3*f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(s,1), noZeroLenR: true)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:7*s)

        let j = myModS(2)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell+1, j: j, m: m-1), noZeroLenL: true)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        let j = 4*s + 1
        HHElem.addElemToHH(hhElem, i:j+s-f(s,1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+2, rightTo:4*j+3, koef:-f2(s,1)*PathAlg.k1J(ell+1, j: j, m: m-1), noZeroLenL: true)
    }
}

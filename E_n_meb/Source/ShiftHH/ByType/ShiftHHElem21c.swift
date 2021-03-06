//
//  Created by M on 16.07.2018.
//

import Foundation

final class ShiftHHElem21c : ShiftHHElem {
    init() {
        super.init(type:21)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j:0, m:5), noZeroLenL: true)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = myModS(2)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenL: true)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+f(s,1))+1, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(s,1), noZeroLenR: true)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j = 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(s,1)*PathAlg.k1J(ell+1, j: j, m: m-1), noZeroLenR: true)
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+f(s,1))+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-1, noZeroLenR: true)
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        let j = 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell+1, j: j, m: m-1), noZeroLenR: true)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(s,1), noZeroLenR: true)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(s,1), noZeroLenR: true)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(s,1)*PathAlg.k1J(ell+1, j: j, m: m-1), noZeroLenR: true)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+f(s,1))+2, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(s,1)*PathAlg.kGamma(ell+1, j: j, m: m-1), noZeroLenR: true)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        let j = 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(s,1)*PathAlg.k1J(ell+1, j: j, m: m-2), noZeroLenR: true)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*j, koef:-f2(s,1)*PathAlg.kGamma(ell+1, j: j, m: m-2), noZeroLenL: true)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.kGamma(ell+1, j: j, m: m-2), noZeroLenR: true)
    }

    override func oddKoef0(s: Int, ell: Int) -> Int {
        return PathAlg.kGamma(ell, j: 0, m: 4) * PathAlg.kGamma(ell, j: 1, m: 4)
            * PathAlg.kGamma(ell, j: 2, m: 4) * -PathAlg.k1J(ell, j:0, m:5)
    }

    override func koef11(ell: Int) -> Int {
        return minusDeg(ell)
    }
}

//
//  Created by M on 30/07/2019.
//

import Foundation

final class ShiftHHElem18c : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:-1, noZeroLenL:true)
    }

    override func oddShift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:1, noZeroLenL:true)
    }

    override func oddShift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+2), rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:9*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:10*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:12*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j, rightTo:7*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:12*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:13*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j, rightTo:7*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:12*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:12*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j, rightTo:7*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:10*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:9*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+2), rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:7*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1, noZeroLenR:true)
    }

    override func koef17(ell: Int) -> Int {
        return minusDeg(ell)
    }

    override func oddKoef0(s: Int, ell: Int) -> Int {
        return -1
    }
}

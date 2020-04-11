//
//  Created by M on 29/03/2020.
//

import Foundation

//#if SHIFTS
final class ShiftHHElem11c : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:8*s)

        var j = s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
        j += s
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
    }

    override func oddShift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:8*s)

        let j = myModS(1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:9*s)

        var j = 5*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
    }

    override func oddShift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:8*s)

        let j = 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:10*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(20*s, h:11*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:11*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:13*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:14*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:16*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:16*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:19*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:18*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:19*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:18*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:20*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:18*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:19*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift17(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:18*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift18(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:19*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift19(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:16*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+2), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift20(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:16*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+1, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift21(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:14*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift22(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:13*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift23(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+7, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
    }

    override func oddShift24(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+5, rightFrom:8*j, rightTo:8*(j+1), koef:-1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift25(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:10*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+2), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift26(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+4, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift27(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:9*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }

    override func oddShift28(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:8*s)

        var j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+6, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
    }
}
//#endif /* SHIFTS */

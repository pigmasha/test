//
//  Created by M on 20/03/2020.
//

import Foundation

//#if SHIFTS
final class ShiftHHElem02c : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j, koef:1)
    }

    override func oddShift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        var j = s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+1, rightTo:8*(j+1)+1, koef:1, noZeroLenR:true)
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:(j_1+1-f(j_1,0))*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1)+j_1, koef:1, noZeroLenR:true)
        }
        j += s
        for j_1 in 0 ... 3 {
            HHElem.addElemToHH(hhElem, i:(j_1+1-f(j_1,0))*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1+1, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1)+j_1, koef:1, noZeroLenR:true)
        }
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1)+5, koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*j+7, koef:-1, noZeroLenL:true)
    }

    override func oddShift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:8*s)

        var j = 4*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m+1), rightFrom:8*j+4, rightTo:8*j+4, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m+1), rightFrom:8*j+6, rightTo:8*j+6, koef:1)
    }

    override func oddShift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:10*s)

        var j = s + myModS(1)
        for j_1 in 0 ... 3 {
            HHElem.addElemToHH(hhElem, i:j+(j_1-f(j_1,0))*s, j:j, leftFrom:8*(j+m)+2+j_1+2*f(j_1,3), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+j_1, koef:-1)
        }
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1)+1, koef:1, noZeroLenR:true)
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:(j_1+1-f(j_1,0))*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2+j_1, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1)+j_1, koef:1, noZeroLenR:true)
        }
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+5, rightFrom:8*j+3, rightTo:8*j+3, koef:-1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+5, rightTo:8*j+5, koef:-1)
    }

    override func oddShift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        var j = s + myModS(1)
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j, koef:1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+1, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j, koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*j+2, koef:1)
        j = 5*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
    }

    override func oddShift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:11*s)

        var j = myModS(1)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:-1)
        j = 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j = 2*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*j+1, koef:-1, noZeroLenL:true)
        j = 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:1)
    }

    override func oddShift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:13*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:1)
    }

    override func oddShift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:14*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+6, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
    }

    override func oddShift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:16*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7+f(j_1,2), leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:minusDeg(j_1))
        }
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:12*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
    }

    override func oddShift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:16*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 4*s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
    }

    override func oddShift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:19*s)

        var j = 5*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
    }

    override func oddShift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:18*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 4*s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        HHElem.addElemToHH(hhElem, i:11*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
    }

    override func oddShift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:19*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7+f(j_1,1), leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:-1+2*f(j_1,0))
        }
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7+f(j_1,1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:1-2*f(j_1,0))
        }
        j += 3*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
        HHElem.addElemToHH(hhElem, i:11*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:15*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
    }

    override func oddShift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(20*s, h:18*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+4, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 5*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
    }

    override func oddShift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:20*s)

        var j = 5*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)-f(j_1,0), leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:-1+2*f(j_1,2))
        }
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:1)
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:14*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:12*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
    }

    override func oddShift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:18*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+6, rightTo:8*(j+1), koef:-1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:11*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
    }

    override func oddShift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:19*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7+f(j_1,1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1-2*f(j_1,0))
        }
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7+f(j_1,1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1-2*f(j_1,0))
        }
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:13*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:11*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:12*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
    }

    override func oddShift17(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:18*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 4*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+6, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
    }

    override func oddShift18(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:19*s)

        var j = 4*s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)-f(j_1,0), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1-2*f(j_1,2))
        }
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:14*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:11*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
    }

    override func oddShift19(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:16*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
    }

    override func oddShift20(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:16*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:12*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
    }

    override func oddShift21(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:14*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += 4*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+6, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
        HHElem.addElemToHH(hhElem, i:9*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
    }

    override func oddShift22(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:13*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+1, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+4, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+4, rightTo:8*(j+1)+4, koef:1, noZeroLenR:true)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
    }

    override func oddShift23(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        var j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:-1)
    }

    override func oddShift24(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:11*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+1, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+3, rightTo:8*(j+1)+3, koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1)+4, koef:1, noZeroLenR:true)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        for j_1 in 1 ... 3 {
            HHElem.addElemToHH(hhElem, i:(3+j_1)*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+2+j_1, koef:1-2*f(j_1,1))
        }
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
    }

    override func oddShift25(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:10*s)

        var j = s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        j += 4*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:1)
    }

    override func oddShift26(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+2, rightTo:8*(j+1)+2, koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1)+3, koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        for j_1 in 1 ... 3 {
            HHElem.addElemToHH(hhElem, i:(1+j_1)*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1)+1+j_1, koef:minusDeg(j_1+1), noZeroLenR:true)
        }
        j += 2*s
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+6, rightTo:8*(j+1)+6, koef:1, noZeroLenR:true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        for j_1 in 1 ... 4 {
            HHElem.addElemToHH(hhElem, i:(1+j_1)*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+1+j_1, koef:1-2*f(j_1,2))
        }
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+6, koef:1)
    }

    override func oddShift27(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        let j = 7*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*j+7, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*j+7, koef:1)
    }

    override func oddShift28(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*(j+1), koef:1, noZeroLenR:true)
        HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+7, koef:-1)
        j += s
        for j_1 in 0 ... 3 {
            HHElem.addElemToHH(hhElem, i:j+j_1*s, j:j, leftFrom:8*(j+m)+1+j_1, leftTo:8*(j+m+1)+1, rightFrom:8*j+1, rightTo:8*j+1+j_1, koef:minusDeg(j_1), noZeroLenL:true)
        }
        j += s
        for j_1 in 0 ... 2 {
            HHElem.addElemToHH(hhElem, i:j+j_1*s, j:j, leftFrom:8*(j+m)+2+j_1, leftTo:8*(j+m+1)+2, rightFrom:8*j+2, rightTo:8*j+2+j_1, koef:minusDeg(j_1), noZeroLenL:true)
        }
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*j+3, koef:1, noZeroLenL:true)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*j+4, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+4, rightTo:8*j+4, koef:1, noZeroLenL:true)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+5, rightTo:8*j+5, koef:1, noZeroLenL:true)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m+1)+5, rightFrom:8*j+5, rightTo:8*j+6, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+6, rightTo:8*j+6, koef:1, noZeroLenL:true)
        j = 7*s + myModS(-1)
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+7, koef:1, noZeroLenR:true)
    }

    override func koef29(ell: Int) -> Int {
        return minusDeg(ell)
    }
}
//#endif /* SHIFTS */

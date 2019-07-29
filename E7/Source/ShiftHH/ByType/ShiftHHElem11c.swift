//
//  Created by M on 26/07/2019.
//

import Foundation

final class ShiftHHElem11c : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:7*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j, koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+1, rightFrom:7*j, rightTo:7*j, koef:1)
        j += 9*s - 1
        HHElem.addElemToHH(hhElem, i:j-4*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
    }

    override func oddShift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:7*s)

        var j = myModS(4)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j, koef:1)
        j = 2*s + myModS(4)
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+1, rightFrom:7*j, rightTo:7*j, koef:1)
        j = 10*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j-4*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:8*s)

        var j = 2*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*(j+1)+1, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*(j+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*(j+1)+2, koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+3, rightTo:7*j+3, koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+4, rightTo:7*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+5, rightTo:7*j+6, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
    }

    override func oddShift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:7*s)

        var j = 3*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
        j = 5*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
        j = 7*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:1)
    }

    override func oddShift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:9*s)

        var j = myModS(3)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:1)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+2, koef:-1)
        j = s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+1, rightTo:7*j+1, koef:1)
        j = 5*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+4, rightTo:7*(j+1), koef:-1)
        j = 6*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
        j = 8*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:-1)
    }

    override func oddShift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:10*s)

        var j = myModS(3)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j+1, koef:-1)
        j = s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j, koef:-1)
        j = 3*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
        j = 5*s + myModS(3)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+5, koef:-1)
    }

    override func oddShift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:10*s)

        var j = myModS(3)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:1)
        j = s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
        j += 4*s
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:-1)
    }

    override func oddShift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:12*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+2, rightTo:7*(j+1)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j+3, rightTo:7*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:1)
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1)+5, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:-1)
    }

    override func oddShift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:12*s)

        var j = 2*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:1)
    }

    override func oddShift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:13*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+5, rightTo:7*(j+1)+4, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:1)
    }

    override func oddShift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:12*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j, rightTo:7*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*(j+1), koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
    }

    override func oddShift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:12*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+2, koef:1)
        j = s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        j = 2*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
        j = 4*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+5, rightTo:7*(j+1)+4, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:1)
    }

    override func oddShift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:10*s)

        var j = myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j, rightTo:7*(j+1), koef:1)
        j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j, rightTo:7*j+1, koef:1)
        j = s + myModS(2)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j, rightTo:7*(j+1), koef:1)
        j = 2*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
        j = 3*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+6, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+2, rightTo:7*(j+1)+2, koef:-1)
        j = 4*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2), rightFrom:7*j+3, rightTo:7*(j+1)+1, koef:1)
        j = 5*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+4, rightTo:7*(j+1), koef:-1)
        j = 7*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2)+1, rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:1)
        j = 7*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2)+1, rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2)+1, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:1)
    }

    override func oddShift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        var j = myModS(1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+1, koef:1)
        j = myModS(2)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+1, koef:1)
        j = s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*(j+1), koef:-1)
        j = 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        j = 2*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
        j = 3*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+4, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
        j = 4*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+3, rightTo:7*(j+1)+3, koef:-1)
        j = 5*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+3, rightTo:7*(j+1)+1, koef:-1)
        j = 6*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+1, rightFrom:7*j+4, rightTo:7*(j+1), koef:-1)
        j = 7*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+5, rightTo:7*(j+1)+4, koef:-1)
        j = 9*s
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:1)
        j = 9*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
    }

    override func oddShift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:9*s)

        for j in (s <= 2 ? 0 : 1) ..< min(s, 3) {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+4, rightFrom:7*j, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+4, rightFrom:7*j, rightTo:7*j+5, koef:1)
        }
        for j in s ..< s + min(s, 3) {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j, rightTo:7*(j+1), koef:s == 2 && j == s ? 2 : 1)
        }
        var j = 3*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+6, rightFrom:7*j+1, rightTo:7*(j+1), koef:1)
        j = 4*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+2), rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2), rightFrom:7*j+2, rightTo:7*(j+1)+2, koef:-1)
        j = 6*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+2), rightFrom:7*j+4, rightTo:7*(j+1), koef:-1)
        j = 8*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+2)+2, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+2)+2, rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2)+2, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2)+2, rightFrom:7*j+6, rightTo:7*(j+1)+5, koef:1)
    }

    override func oddShift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:7*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*(j+1), koef:1)
        for j in (s <= 2 ? 0 : 1) ..< min(s, 3) {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+4, koef:1)
        }
        for j in s ..< s + min(s, 2) {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*(j+1), koef:1)
        }
        for j in 2*s ..< 2*s + min(s, 2) {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j+1, rightTo:7*(j+1), koef:1)
        }
        j = 3*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+2, rightTo:7*(j+1)+2, koef:1)
        j = 4*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
        j = 4*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+2, rightTo:7*(j+1)+1, koef:-1)
        j = 5*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+3, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+3, rightTo:7*(j+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+3, rightTo:7*(j+1)+3, koef:-1)
        j = 8*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j+5, rightTo:7*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+5, rightTo:7*(j+1)+4, koef:-1)
        j = 10*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:1)
    }

    override func oddShift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:8*s)

        for j in (s <= 2 ? 0 : 1) ..< min(s, 3) {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j, rightTo:7*j+4, koef:-1)
        }
        for j in 4*s ..< 4*s + myModS(1) {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
        }
        for j in 6*s ..< 6*s + min(s, 3) {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+4, rightTo:7*(j+1), koef:s == 2 && j == 6*s ? -2 : -1)
        }
        for j in 10*s ..< 10*s + min(s, 3) {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+2)+3, rightFrom:7*j+6, rightTo:7*(j+1), koef:s == 2 && j == 10*s ? 2 : 1)
        }
    }

    override func oddShift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:7*s)

        for j in (s <= 2 ? 0 : 1) ..< min(s, 3) {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+5, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+6, koef:-1)
        }
        var j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*(j+1), koef:1)
        j = 2*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*j+3, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*j+6, koef:1)
        for j in 4*s ..< 4*s + min(s, 2) {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*(j+1)+1, koef:-1)
            if j < 4*s + myModS(1) {
                HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
            }
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*(j+1)+2, koef:1)
        }
        j = 4*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*j+3, koef:1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*j+6, koef:-1)
        for j in 5*s ..< 5*s + min(s, 2) {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*(j+1)+2, koef:-1)
        }
        for j in 5*s ..< 5*s + min(s, 3) {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*j+3, koef:s == 2 && j == 5*s ? -2 : -1)
            if j < 5*s + min(s, 2) {
                HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*(j+1)+3, koef:1)
            }
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*j+6, koef:s == 2 && j == 5*s ? 2 : 1)
        }
        for j in 8*s ..< 8*s + min(s, 3) {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*j+5, koef:s == 2 && j == 8*s ? 2 : 1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*j+6, koef:s == 2 && j == 8*s ? -2 : -1)
        }
        for j in 11*s ..< 11*s + min(s, 2) {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+5, koef:1)
        }
        for j in 11*s ..< 11*s + min(s, 3) {
            HHElem.addElemToHH(hhElem, i:j-5*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:s == 2 && j == 11*s ? 2 : 1)
            if j < 11*s + min(s, 2) {
                HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+6, koef:-1)
            }
        }
        for j in 12*s ..< 12*s + min(s, 2) {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+5, koef:1)
            HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+6, koef:-1)
        }
    }

    override func koef17(ell: Int) -> Int {
        return minusDeg(ell)
    }
}

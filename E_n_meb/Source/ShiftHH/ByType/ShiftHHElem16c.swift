//
//  Created by M on 08.07.2018.
//

import Foundation

final class ShiftHHElem16c: ShiftHHElem {
    init() {
        super.init(type:16)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 2*s - 3 + 2*f(s,1)
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+2,
                           rightFrom:4*j, rightTo:4*j, koef:1)
        j = 3*s - 3 + 2*f(s,1)
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:1)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+2,
                           rightFrom:4*j, rightTo:4*j, koef:1)
        j = 2*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:1)
        j = 3*s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:1)
        j = 6*s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*j+3, koef:1, noZeroLenL: true)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        var j = 2*s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        j = 3*s - 1
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        j = 4*s - 1
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        var j = s - 1
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j, koef:1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j+1, koef:1)
        j = 2*s - 1
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        var j = myModS(s - 2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
        j = 2*s - myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        j = 4*s - myModS(2)
        HHElem.addElemToHH(hhElem, i:j+2*s+f(s,1), j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        var j = 2*s - 2
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
        j = 3*s - myModS(2)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:1)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        var j = myModS(s - 2)
        HHElem.addElemToHH(hhElem, i:j+s+2*f(s,1), j:j,
                           leftFrom:4*(j+m+f(s,1))+1, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+f(s,1))+1, koef:1)
        j = 2*s - 3 + 2*f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        if s > 1 {
            j = 6*s - 3
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        }
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
        j = 2*s+myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        j = 7*s+myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+2), leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+2), leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        var j = myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
        j = s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
        j = 2*s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        j = 5*s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+1, koef:1)
        j = 6*s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        j = 8*s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:1, noZeroLenL: true)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 3*s - 3 + 2*f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        j = 5*s - 3 + 2*f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
        j = 6*s - 3 + 2*f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
        j = 7*s - 3 + 2*f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+2,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        var j = myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
        j = s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:1)
        j = 6*s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        j = 7*s + myModS(s - 3)
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:1, noZeroLenL: true)
    }
}

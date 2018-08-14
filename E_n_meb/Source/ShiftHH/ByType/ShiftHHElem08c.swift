//
//  Created by M on 13.05.2018.
//

final class ShiftHHElem08c : ShiftHHElem {
    init() {
        super.init(type:8)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = s - 2
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:1)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 4*s - 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = 4*s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1+s)+1,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 2*s - 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = 3*s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        var j = s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(j, s - 1))+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = 3*s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:1)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        var j = s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(j, s - 1))+2, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j = 4*s - 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+1, rightTo:4*(j+1)+1, koef:1)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        var j = s - 1
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*j+1, koef:1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 2*s - 1
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*j+3, koef:1)
        j += s - 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*j+3, koef:1)
        j += 1
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*j+3, koef:1)
        j += s - 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1)+2, koef:1)
    }
}

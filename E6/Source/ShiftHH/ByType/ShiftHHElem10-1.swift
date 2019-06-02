//
//  Created by M on 13.05.2018.
//

final class ShiftHHElem10 : ShiftHHElem {
    init() {
        super.init(type:10, withTwist: false)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = myModS(-2*ell_0)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:1)
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = myModS(s-1-2*ell_0)
        j = j == s - 1 ? j + 3*s : j + 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j0 = myModS(s-1-2*ell_0)
        let k0 = s * f(j0, s - 1)
        let j = j0 == s - 1 ? j0 + 3*s : j0 + s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1+k0)+1,
                           rightFrom:4*(j+s+k0)+1, rightTo:4*(j+1), koef:1)
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j0 = myModS(s-1-2*ell_0)
        var j = j0 == s - 1 ? s + j0 : j0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j0 = myModS(s-1-2*ell_0)
        let j = j0 == s - 1 ? 2*s + j0 : s+j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        var j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(j, s - 1))+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += j == s - 1 ? 2*s : s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j0 = myModS(s-1-2*ell_0)
        let j = j0 == s - 1 ? 2*s + j0 : s+j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:1)
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        var j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(j, s - 1))+2, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += j == s - 1 ? 2*s : s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j0 = myModS(s-1-2*ell_0)
        let j = j0 == s - 1 ? 3*s + j0 : 2*s+j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+1, rightTo:4*(j+1)+1, koef:1)
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        var j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*j+1, koef:1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
        j += j == s - 1 ? 2*s : s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        let j0 = myModS(s-1-2*ell_0)
        var j = j0 == s - 1 ? j0 + s : j0
        HHElem.addElemToHH(hhElem, i:j+4*s-2*s*f(j0, s-1), j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
        HHElem.addElemToHH(hhElem, i:j+5*s-s*f(j0, s-1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*j+3, koef:1)
        j = 2*s + myModS(s-2-2*ell_0)
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
        j = j0 == s - 1 ? 3*s + j0 : 2*s + j0
        HHElem.addElemToHH(hhElem, i:j%s+5*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*j+3, koef:1)
        j = 4*s + myModS(s-2-2*ell_0)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1)+2, koef:1)


    }
    /*override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
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
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
    }*/
}

//
//  Created by M on 18.02.18.
//

final class ShiftHHElem09 : ShiftHHElem {
    init() {
        super.init(type:9, withTwist: true)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h: 6*s)
        let j = s+myModS(-2*ell_0)
        if j == 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:0, j:j, leftFrom:4*(j+1), leftTo:4*(j+1), rightFrom:4*j, rightTo:4*(j+1), koef:-1)
        } else {
            HHElem.addElemToHH(hhElem, i:j%s, j:j, leftFrom:4*j, leftTo:4*(j+1), right:4*j, koef:1)
        }
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 2*s+myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f2(j, 3*s-1))
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-f2(j, 4*s-1))
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = myModS(s-1-2*ell_0)
        let k1 = f2(j, 2) * f2(j, 0)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k1)//7: f2(j, 2))
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-k1)//7: -f2(j%s, s))
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(j, s-1))
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(j, s-1))+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(j, 0)*f2(j, 2)*f2(j, s-3))
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s-s*f(j, s-1))+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(j, 0)*f2(j, 2)*f2(j, s-3))
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(j, 0))//7: -f2(j, 0)*f2(j, s-3))
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        let j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(j, s-1))+2, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)//7: -f2(j, s-3))
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        var j = myModS(s-1-2*ell_0)
        j += s-s*f(j, s-1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-1)//7: -f2(myModS(s-1-2*ell_0), s-3))
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        let j = myModS(s-1-2*ell_0)
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*j+1, koef:-1)//7: f2(j, s-3))
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)//7: -f2(j, s-3))
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 2*s + myModS(s-2-2*ell_0)
        HHElem.addElemToHH(hhElem, i:s+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1)+1, koef:1)//7: -f2(myModS(s-2-2*ell_0), s-4))
        j += s
        HHElem.addElemToHH(hhElem, i:s+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1)+1, koef:1)//7: -f2(myModS(s-2-2*ell_0), s-4))
        j += s + s*f(myModS(s-2-2*ell_0), s - 1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:-1)//7: -f2(myModS(s-2-2*ell_0), 1))
    }
}

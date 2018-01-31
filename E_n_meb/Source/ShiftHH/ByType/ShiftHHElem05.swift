//
//  Created by M on 20.09.17.
//

final class ShiftHHElem05 : ShiftHHElem {
    init() {
        super.init(type:5, withTwist: true)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = myModS(-3*ell_0)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j+3, right:4*j, koef:1)
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 2*s + myModS(-3*ell_0 - 1)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f2(j%s, s-1))
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-f2(j%s, s-1))
        j += (j % s == s - 1) ? 2*s : s
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*j+3, koef:-PathAlg.kGamma(ell, j: j+1, m: m))
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        var j = myModS(-3*ell_0 - 1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j+1, koef:f2(j%s, s-1) * PathAlg.kGamma(ell, j: j, m: m))
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = myModS(-3*ell_0 - 1)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+s)+1,
                           koef:-PathAlg.k1J(ell, j: j+1, m: m) * PathAlg.kGamma(ell, j: j, m: m) * f2(j%s, s-1))
        j += 3*s - 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f2(j%s, s-2) * PathAlg.kGamma(ell, j: j+1, m: m))
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j0 = myModS(-3*ell_0 - 2)
        var j = j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
        j = (j0 == s - 1) ? 2*s+j0 : 4*s+j0
        let j1 = (j0 == s - 1) ? 0 : s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+j1+1)+2,
                           rightFrom:4*(j+j1)+1, rightTo:4*(j+1),
                           koef:-f1(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m)*PathAlg.k1J(ell, j: j+1, m: m))
        j = 7*s+j0
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+j1+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s-j1+1)+1, koef:-f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+j1+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s-j1+1)+2, koef:f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j0 = myModS(-3*ell_0 - 2)
        let j1 = (j0 == s - 1) ? 0 : s
        var j = j0
        HHElem.addElemToHH(hhElem, i:j1+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m) * f1(j%s, s-2))
        j += s
        HHElem.addElemToHH(hhElem, i:s-j1+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m) * f1(j%s, s-2))
        j = 2*s+j1+j0
        let k0 = f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:k0)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:k0)
        j = 6*s-j1+j0
        let k1 = (j0 == s - 1) ? PathAlg.k1J(ell, j: j, m: m) : PathAlg.kGamma(ell, j: j, m: m) * PathAlg.kGamma(ell, j: j+1, m: m) * f2(j%s, s-2)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+2), leftTo:4*(j+m+s-j1+2)+((j0 == s - 1) ? 1 : 0),
                           rightFrom:4*j+2+((j0 == s - 1) ? 1 : 0), rightTo:4*(j+1)+1, koef:k1)
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j0 = myModS(-3*ell_0 - 2)
        let j1 = (j0 == s - 1) ? 0 : s
        var j = s + j1 + j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1),
                           koef:f1(j%s, s-2) * PathAlg.k1J(ell, j: j+2+s-j1, m: m))
        j = 5*s - j1 + j0
        let k1 = (j0 == s - 1) ? f2(j%s, s-1) : -f2(j%s, s-2) * PathAlg.k1J(ell, j: j+2, m: m)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1+((j0 == s - 1) ? 3 : 0),
                           rightFrom:4*(j+s)+2+((j0 == s - 1) ? 1 : 0), rightTo:4*(j+s+1)+1,
                           koef:k1)
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j0 = myModS(-3*ell_0 - 2)
        let j1 = (j0 == s - 1) ? 0 : s
        var j = j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s-j1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1),
                           koef:-PathAlg.kGamma(ell, j: j+1, m: m) * f1(j%s, s-2))
        j = s+j1+j0
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:f2(j%s, s-2))
        j = 3*s+j1+j0
        HHElem.addElemToHH(hhElem, i:6*s+j1+myModS(j), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*j+3,
                           koef:-f1(j%s, s-2) * PathAlg.k1J(ell, j: j+2+s-j1, m: m))
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j0 = myModS(-3*ell_0 - 2)
        let j1 = (j0 == s - 1) ? 0 : s
        var j = j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f1(j%s, s-2))
        j = s+j1+j0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1,
                           koef:f1(j%s, s-2) * PathAlg.k1J(ell, j: j+1+s-j1, m: m))
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        let j0 = myModS(-3*ell_0 - 3)
        let j1 = (j0 >= s - 2) ? 0 : s
        var j = s + j1 + j0
        let k = -f2(j%s, s-1) * f2(j%s, s-3) * PathAlg.k1J(ell, j: j+2+s-j1, m: m)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:k)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:k)
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j0 = myModS(-3*ell_0 - 3)
        let j1 = (j0 >= s - 2) ? 0 : s
        var j = j1 + j0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1),
                           koef:-f2(j%s, s-1) * f2(j%s, s-3) * PathAlg.k1J(ell, j: j+1+s-j1, m: m))
        j += 4*s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+2, rightTo:4*j+3, koef:f2(j%s, s-3))
    }
}

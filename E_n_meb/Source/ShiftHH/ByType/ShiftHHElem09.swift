//
//  Created by M on 18.02.18.
//

final class ShiftHHElem09 : ShiftHHElem {
    init() {
        super.init(type:9, withTwist: true)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h: 6*s)
        let j = s+myModS(-ell_0)
        HHElem.addElemToHH(hhElem, i:j%s, j:j, leftFrom:4*j, leftTo:4*(j+1), right:4*j, koef:1)
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 2*s + myModS(s-1-ell_0)
        //let k0 = ell_0 % s == 0 ? -1 : 1
        //printK(prefix: "1:", jFrom: 2*s, jTo: 3*s, m: m, ell: ell, f: { j in return j % s == s - 1 ? -1 : 1})
        let k0 = PathAlg.k1J(ell, j:j%s, m:m+2)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-k0)
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:k0)
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = myModS(s-1-ell_0)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = myModS(s-1-ell_0)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j:j%s, m:m+2))
        j += s
        HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j:j%s, m:m+2))
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = myModS(s-1-ell_0)
        //printK(prefix: "4:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in return j % s == s - 1 ? -1 : 1})
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j = myModS(s-1-ell_0)
        //let k0 = ell_0 % s == 1 || ell_0 % s == 3 || ell_0 % s == 4 ? -1 : 1
        //printK(prefix: "5-1:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in
        //    return j % s == s - 2 || j % s == s - 4 || j % s == s - 5 ? -1 : 1})
        let k0 = minusDeg(ell_0%s+1)*PathAlg.k1J(ell, j: j, m: m+3)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = myModS(s-1-ell_0)
        //let k0 = ell_0 % s == 1 || ell_0 % s == 4 ? 1 : -1
        //printK(prefix: "6:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in return j % s == s - 2 || j % s == s - 5 ? 1 : -1})
        let k0 = minusDeg(ell_0%s)*PathAlg.k1J(ell, j: j, m: m+1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        let j = myModS(s-1-ell_0)
        //let k0 = ell_0 % s == 1 ? -1 : 1
        //printK(prefix: "7:", jFrom: 0, jTo: s-1, m: m, ell: ell, f: { j in return j % s == s - 2 ? -1 : 1})
        let k0 = -PathAlg.k1J(ell, j: j, m: m) * f2(j, s - 1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s*f(j, s-1)+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j0 = myModS(s-1-ell_0)
        let j = j0 == s - 1 ? j0 : j0 + s
        //let k0 = ell_0 % s == 1 ? 1 : -1
        //printK(prefix: "8:", jFrom: 0, jTo: s-1, m: m, ell: ell, f: { j in return j % s == s - 2 ? 1 : -1})
        //let k0 = -PathAlg.k1J(ell, j: j%s, m: m+4) * f2(j0, s - 1)
        let k0 = -PathAlg.k1J(ell, j: j, m: m+4)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        let j = myModS(s-1-ell_0)
        //let k0 = ell_0 % s == 1 ? 1 : -1
        //printK(prefix: "9:", jFrom: 0, jTo: s-1, m: m, ell: ell, f: { j in return j % s == s - 2 ? 1 : -1})
        let k0 = -PathAlg.k1J(ell, j: j, m: m+4) * f2(j, s - 1)
        if j == s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        } else {
            HHElem.addElemToHH(hhElem, i:5*s+j, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:-k0)
            HHElem.addElemToHH(hhElem, i:6*s+j, j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:k0)
        }
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = myModS(s-1-ell_0)
        //let k0 = ell_0 % s == 0 || ell_0 % s == 1 ? -1 : 1
        //printK(prefix: "10:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in return j % s == s - 2 || j % s == s - 1 ? -1 : 1})
        let k0 = -PathAlg.k1J(ell, j: j, m: m+3)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
        if j != s - 1 {
            HHElem.addElemToHH(hhElem, i:5*s+j, j:j,
                               leftFrom:4*(j+m+1)-1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1)-1, koef:-k0)
        }
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
        if j != 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:4*s+j, j:j,
                               leftFrom:4*(j+m+1)-1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1)-1, koef:-k0)
            j = 6*s+myModS(s-2-ell_0)+s*f(j%s, 0)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+3, leftTo:4*(j+m+s+1)+5,
                               rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:k0)
        }

    }


}

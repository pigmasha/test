//
//  Created by M on 08.06.2018.
//

final class ShiftHHElem10c : ShiftHHElem {
    init() {
        super.init(type:10)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h: 6*s)
        let j = s
        HHElem.addElemToHH(hhElem, i:j%s, j:j, leftFrom:4*j, leftTo:4*(j+1), right:4*j, koef:PathAlg.k1J(ell, j:0, m:2), noZeroLenL: true)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h: 6*s)
        let j = s+myModS(1)
        HHElem.addElemToHH(hhElem, i:j%s, j:j, leftFrom:4*j, leftTo:4*(j+1), right:4*j, koef:1, noZeroLenL: true)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f2(s, 1))
        j = 3*s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-f2(s, 1))
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1, noZeroLenR: true)
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j:j, m:m+2), noZeroLenR: true)
        j = s
        HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j:j, m:m+2), noZeroLenR: true)
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(s, 1), noZeroLenR: true)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(s, 1)*PathAlg.kGamma(ell, j: j, m: m), noZeroLenR: true)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(s, 1)*PathAlg.kGamma(ell, j: j, m: m), noZeroLenR: true)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(s,1), noZeroLenR: true)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        let j = 0
        let k1 = s == 1 ? -PathAlg.kGamma(ell, j: j, m: m) :
            PathAlg.kGamma(ell, j: j, m: m) * PathAlg.kGamma(ell, j: j, m: m+1) * PathAlg.kGamma(ell, j: j, m: m+2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s*f(j, s-1)+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:k1, noZeroLenR: true)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j = s*(1-f(s,1))
        let k1 = s == 1 ? -PathAlg.k1J(ell, j: j, m: m+4) :
            PathAlg.kGamma(ell, j: j, m: m-1) * PathAlg.kGamma(ell, j: j, m: m) *
            PathAlg.kGamma(ell, j: j, m: m+1) * PathAlg.k1J(ell+1, j: j, m: s)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k1, noZeroLenR: true)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)
        guard s > 1 else {
            let j = 0
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.kGamma(ell, j: j, m: m), noZeroLenR: true)
            return
        }

        let j = 0
        let k1 = -PathAlg.kGamma(ell, j: j, m: m-1) * PathAlg.kGamma(ell, j: j, m: m) * PathAlg.kGamma(ell, j: j, m: m+1)
        HHElem.addElemToHH(hhElem, i:5*s+j, j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*j+3, koef:-k1)
        HHElem.addElemToHH(hhElem, i:6*s+j, j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*j+3, koef:k1)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)
        guard s > 1 else {
            var j = 0
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m+3), noZeroLenR: true)
            j = s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m+3), noZeroLenR: true)
            return
        }

        var j = 0
        let k1 = PathAlg.kGamma(ell, j: j, m: m-2) * PathAlg.kGamma(ell, j: j, m: m-1) * PathAlg.kGamma(ell, j: j, m: m) *
            PathAlg.kGamma(ell, j: j, m: m+1) * PathAlg.k1J(ell+1, j: j, m: 1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k1, noZeroLenR: true)
        HHElem.addElemToHH(hhElem, i:5*s+j, j:j,
                           leftFrom:4*(j+m+1)-1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1)-1, koef:-k1)

        j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k1, noZeroLenR: true)
        HHElem.addElemToHH(hhElem, i:4*s+j, j:j,
                           leftFrom:4*(j+m+1)-1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1)-1, koef:-k1)

        j = 7*s-1+s*f(j%s, 0)
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+3, leftTo:4*(j+m+s+1)+5,
                           rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:k1, noZeroLenR: true)
    }

    override func oddKoef0(s: Int, ell: Int) -> Int {
        return s == 1 ? PathAlg.k1J(ell, j:0, m:2) : -PathAlg.kGamma(ell, j: 2, m: 0) * PathAlg.k1J(ell, j:0, m:2)
    }

    override func koef11(ell: Int) -> Int {
        return minusDeg(ell)
    }
}

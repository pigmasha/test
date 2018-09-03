//
//  Created by M on 20.05.2018.
//

import Foundation

final class ShiftHHElem03c : ShiftHHElem {
    init() {
        super.init(type:3)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j+1, right:4*j, koef:1)
        HHElem.addElemToHH(hhElem, i:j, j:j+s, leftFrom:4*(j+s), leftTo:4*(j+s)+1, right:4*j, koef:1)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j = myModS(2)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j+1, right:4*j, koef:1)
        HHElem.addElemToHH(hhElem, i:j, j:j+s, leftFrom:4*(j+s), leftTo:4*(j+s)+1, right:4*j, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        var j = myModS(1)
        for _ in 0...1 {
            j += s
            HHElem.addElemToHH(hhElem, i:myMod2S(s+j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myMod2S(s+j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:1)
        }

        for _ in 0...1 {
            j += s
            HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
        }

        j += s
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m), noZeroLenL: true)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 2*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f1(j%s, s-1)*PathAlg.k1J(ell, j: j, m: m))
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-f1(j%s, s-1)*PathAlg.k1J(ell, j: j, m: m))

        for _ in 0...1 {
            j += s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m))
        }
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        var j = s + myModS(1)
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:-PathAlg.k1J(ell, j: j, m: m))
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        var j = myModS(1)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m-1)+3, leftTo:4*(j+m)+1,
                           rightFrom:4*j, rightTo:4*j, koef:1)
        j = 2*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f1(j%s, s-1)*PathAlg.k1J(ell, j: j, m: m))
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-f1(j%s, s-1)*PathAlg.k1J(ell, j: j, m: m))
        j += 3*s
        HHElem.addElemToHH(hhElem, i:2*s+myMod2S(s+j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:6*s+myMod2S(s+j+1)-f(j%s,s-1)*s, j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myMod2S(s+j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:5*s+myMod2S(s+j+1)+f(j%s,s-1)*s, j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-1)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        var j = s
        HHElem.addElemToHH(hhElem, i:myMod2S(s+j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(s+j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:myMod2S(s+j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:4*s+myMod2S(s+j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:4*s+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myMod2S(s+j+1), j:j,
                           leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-PathAlg.k1J(ell, j: j, m: m))
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        var j = 5*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m))
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:s+myMod2S(j+1)+f(j%s,s-1)*s, j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:2*s+myMod2S(j+1)-f(j%s,s-1)*s, j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        var j = 0
        for _ in 0...1 {
            j += s
            HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }

        j += 3*s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+f(j%s,s-1)*s)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+s+1+f(j%s,s-1)*s)+1, koef:-PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:4*s+myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:4*s+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:f1(j%s, s-1)*PathAlg.k1J(ell, j: j, m: m), noZeroLenR: true)
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j+f(j%s,s-1)*s,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*(j+s+f(j%s,s-1)*s)+1, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m))
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j+f(j%s,s-1)*s,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1+f(j%s,s-1)*s)+1,
                           rightFrom:4*(j+s+f(j%s,s-1)*s)+2, rightTo:4*(j+1), koef:1)
        HHElem.addElemToHH(hhElem, i:3*s+myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:1)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:f1(j%s, s-1)*PathAlg.k1J(ell, j: j, m: m), noZeroLenR: true)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+s)+2, koef:PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m))
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)

        j = 3*s + myModS(s - 1)
        HHElem.addElemToHH(hhElem, i:3*s+myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:3*s+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:3*s+myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:PathAlg.k1J(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:f1(j%s, s-1)*PathAlg.k1J(ell, j: j, m: m), noZeroLenR: true)
    }
}

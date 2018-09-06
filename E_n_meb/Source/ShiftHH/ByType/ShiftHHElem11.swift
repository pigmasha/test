//
//  Created by M on 11.06.2018.
//

import Foundation

final class ShiftHHElem11: ShiftHHElem {
    init() {
        super.init(type:11)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        for j in 0 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j%s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+1,
                               rightFrom:4*j, rightTo:4*j, koef:1)
        }
        for j in 2*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*j+1, koef:PathAlg.k1JPlus1(ell, j:j, m:m+2))
        }
        for j in 4*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j:j, m:m+2))
        }
        for j in 6*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:f1(j, 7*s))
        }
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:7*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell, j: j, m: m+3)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:k)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:-k)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+3, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 5*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 7*s ..< 8*s {
            let k = -PathAlg.k1J(ell, j: j, m: m+3)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,8*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,8*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,8*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,8*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,8*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,8*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:k)
        }
        for j in 8*s ..< 9*s {
            let k = PathAlg.k1J(ell, j: j, m: m+4)
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*j+3, koef:k, noZeroLenL: true)
        }
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        for j in 0 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:myModS(j), j:j,
                               leftFrom:4*(j+m)-1, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*j, koef:-f1(j, s))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
        }
        for j in 2*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:PathAlg.k1J(ell+1, j: j, m: m+2))
        }
        for j in 4*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+3))
        }
        for j in 6*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-f2(j%s, s-1)*f1(j, 7*s))
            HHElem.addElemToHH(hhElem, i:3*s+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:1)
        }
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        for j in 0 ..< s {
            let k = -PathAlg.k1J(ell, j: j, m: m+2)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:k)
        }
        for j in s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:f2(j%s, s-1) * f1(j, 2*s))
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            let k = -PathAlg.k1J(ell, j: j, m: m+4)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,6*s-1))+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,6*s-1))+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,6*s-1))+1, koef:k)
        }
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:9*s)

        for j in 0 ..< s {
            let k = -PathAlg.k1J(ell, j: j, m: m+2)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)-1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:k, noZeroLenL: true)
            if j < s - 1 {
                HHElem.addElemToHH(hhElem, i:myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*(j+1), koef:-k)
            }
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:k)
        }
        for j in s ..< 3*s {
            let k = -PathAlg.k1J(ell, j: j, m: m+3)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:k*f2(j%s, s-1) * f1(j, 2*s))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-k)
        }
        for j in 3*s ..< 4*s {
            let k = -f2(j%s, s-1)
            if j < 4*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:k)
            }
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 4*s ..< 5*s {
            if j == 5*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            }
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:f2(j,5*s-1))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:2*s+myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
            if j < 6*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
                HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
            } else {
                HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
            }
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:2*s+myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
            if j < 7*s - 1 {
                HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
            } else {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
                HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
            }
        }
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m+3))
        }
        for j in s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        }
        for j in 3*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:6*s+myMod2S(j), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:f1(j,4*s))
        }
        for j in 5*s ..< 6*s {
            let k = PathAlg.k1J(ell, j: j, m: m+3)*f2(j%s, s-1)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,6*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-k)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,6*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-k)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,6*s-1))+2, koef:k)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,6*s-1))+2, koef:k)
        }
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell, j: j, m: m+3)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:k)
            if j == s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+1), koef:k, noZeroLenR: true)
            }
        }
        for j in s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+2*s-s*f0(j, 2*s), j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
            if j >= 2*s - 1 && j < 3*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                                   rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
            }
        }
        for j in 3*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:7*s+myModS(j), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
            if j >= 4*s - 1 && j < 5*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            }
        }
        for j in 5*s ..< 6*s {
            let k = -PathAlg.k1J(ell, j: j, m: m+3) * f2(j,6*s-1)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,6*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,6*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,6*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,6*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,6*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,6*s-1))+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,6*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,6*s-1))+1, koef:-k)
        }
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j, rightTo:4*j+2, koef:1)
        }
        for j in 2*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:1)
        }
        for j in 4*s ..< 6*s {
            let k = PathAlg.k1J(ell, j: j, m: m+3) * f1(j,5*s)
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+2, rightTo:4*j+3, koef:-k)
        }
        for j in 6*s ..< 7*s {
            let k = -PathAlg.k1J(ell, j: j, m: m+4)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,7*s-1))+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,7*s-1))+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,7*s-1))+2, koef:-k)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,7*s-1))+2, koef:-k)
        }
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell, j: j, m: m+2)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)-1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:-k, noZeroLenL: true)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+1), koef:k*f2(j,s-1), noZeroLenR: true)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:k)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:-k)
        }
        for j in s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 3*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 5*s ..< 6*s {
            let k = PathAlg.k1J(ell, j: j, m: m-1) * PathAlg.kGamma(ell+1, j: j, m: m-2)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,6*s-1))+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,6*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,6*s-1))+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,6*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,6*s-1))+1, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,6*s-1))+2, koef:k)
        }
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:-1)
        }

        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+s-s*f0(j,s))+1, koef:1)
        }
        for j in 2*s ..< 4*s {
            let k = PathAlg.k1J(ell+1, j: j, m: m-3)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:k)
            if j < 3*s - 1 || j == 4*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:-k)
            }
        }
        for j in 4*s ..< 6*s {
            let k = f1(j,5*s)*PathAlg.k1J(ell, j: j, m: m-1) * PathAlg.kGamma(ell, j: j, m: m-2)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+2),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:k)
            if j >= 5*s - 1 && j < 6*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                                   rightFrom:4*j+2, rightTo:4*(j+1), koef:-k)
            }
        }
        for j in 6*s ..< 8*s {
            if j <  7*s - 1 || j == 8*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+1,
                                   rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
                HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+2), leftTo:4*(j+m+s+2)+1,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
            } else {
                HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+2), leftTo:4*(j+m+s+2)+1,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-1)
            }
        }
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell+1, j: j, m: m-4)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:k)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:-k)
        }
        for j in s ..< 2*s {
            let k = PathAlg.k1J(ell+1, j: j, m: m-3)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:k, noZeroLenL: true)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:k)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+2, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+3, koef:k)
        }
        for j in 2*s ..< 3*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+2, rightTo:4*j+3, koef:-1)
            if j < 5*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*j+2, rightTo:4*(j+1), koef:-1)
            }
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
            if j == 7*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            }
        }
        for j in 7*s ..< 8*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
        }
        for j in 8*s ..< 9*s {
            let k = -PathAlg.k1J(ell+1, j: j, m: m-3)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,9*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,9*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,9*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,9*s-1))+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,9*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,9*s-1))+2, koef:-k)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,9*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,9*s-1))+2, koef:k)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:-k, noZeroLenR: true)
        }
    }

    override func koef11(s: Int, ell: Int) -> Int {
        return minusDeg(ell)
    }
}

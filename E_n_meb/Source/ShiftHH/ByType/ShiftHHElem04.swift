//
//  Created by M on 08.05.17.
//

import Foundation

final class ShiftHHElem04 : ShiftHHElem {
    init() {
        super.init(type:4)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j%s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j, koef:1)
        }
        for j in 5*s-1 ..< 6*s-1 {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        for j in 0 ..< s {
            let k0 = PathAlg.k1J(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:k0)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:k0)
            if j < s - 1 {
                HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j+2, koef:k0)
                HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*(j+s)+2, koef:-k0)
            }
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            let k0 = PathAlg.k1JPlus2(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*j+3, koef:j == 6*s - 1 ? k0 : -k0, noZeroLenL: true)
            if j == 5*s + myModS(s - 2) {
                HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                                   rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(s,1))+2, koef:s == 1 ? k0 : -k0)
                HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+3, koef:s == 1 ? k0 : -k0, noZeroLenR: true)
            }
        }
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        for j in 0 ..< s - 1 {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*j+2, koef:1)
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)-1, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*j, koef:-1)
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m))
            if j ==  3*s - 1 {
                HHElem.addElemToHH(hhElem, i:j-s, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m))
            if j < 4*s - 1 {
                HHElem.addElemToHH(hhElem, i:j-s, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in 4*s ..< 5*s - 1 {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:-k0)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-k0)
        }
        for j in 6*s - 1 ..< 6*s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:-k0)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-k0)
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
        }
        for j in 8*s - 1 ..< 8*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
        }
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        for j in 0 ..< s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 2*s - 1 ..< 2*s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:k0)
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+2, rightTo:4*j+3, koef:-1)
        }

        if s == 1 {
            for j in 7 ..< 8 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+2, rightTo:4*(j+1), koef:-1)
            }
        } else {
            for j in 6*s - 2 ..< 6*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            }
        }

        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 8*s+myModS(s-2) ... 8*s+myModS(s-2) {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(s,1))+1, koef:PathAlg.k1J(ell, j: j, m: m))
        }
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        for j in 0 ..< s - 1 {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)-1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
        }
        for j in 2*s ..< 3*s - myModS(2) {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:s == 1 ? k0 : -k0)
        }
        for j in 4*s - myModS(2) ..< 4*s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:j == 4*s - 2 ? k0 : -k0)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
        }
        for j in 8*s - 1 ..< 8*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-1)
        }
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        guard s > 1 else {
            var j = 0
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*(j+1)+1, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            j += s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+1)+1, rightTo:4*j, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+1, rightTo:4*j, koef:1)
            j += 4*s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*(j+1)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*j+3, koef:-1)
            j += s
            let k0 = -PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j-7*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j, koef:k0)
            HHElem.addElemToHH(hhElem, i:j-6*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j, koef:k0)
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-k0)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j+2, koef:-k0)
            return
        }

        for j in 0 ..< s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:k0)
            if j == s - 1 {
                HHElem.addElemToHH(hhElem, i:j, j:j,
                                   leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j, koef:k0)
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j, koef:k0)
                HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j+2, koef:-k0)
                HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+s)+2, koef:-k0)
            }
        }
        for j in s ..< 2*s - 2 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 2*s ..< 3*s - 2 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        }
        for j in 4*s - 2 ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        }
        for j in 5*s - 2 ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        }
        for j in 5*s ..< 6*s - 1 {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 8*s - 2 ..< 8*s - 1 {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k0)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k0)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-k0)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-k0)
        }
        for j in 8*s ..< 9*s - 1 {
            let k0 = PathAlg.k1JPlus2(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-k0)
        }
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        guard s > 1 else {
            var j = 0
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1)+1, koef:1)
            j += s
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m))
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m),
                               rightFrom:4*j+2, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m))
            j += s
            HHElem.addElemToHH(hhElem, i:j-6*s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+1,
                               rightFrom:4*j+3, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-5*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+1,
                               rightFrom:4*j+3, rightTo:4*j+1, koef:1)
            return
        }

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
            if j < s - 1 {
                HHElem.addElemToHH(hhElem, i:j+6*s, j:j,
                                   leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                                   rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
            }
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 2*s ..< 3*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 4*s ..< 5*s - 1 {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:k0)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:k0)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+3, koef:-k0)
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        }
        for j in 7*s ..< 8*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        }
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        guard s > 1 else {
            var j = s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+1, rightTo:4*j, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+1, rightTo:4*(j+1)+1, koef:1)
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+1,
                               rightFrom:4*(j+1)+2, rightTo:4*(j+1)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+1,
                               rightFrom:4*(j+1)+2, rightTo:4*j+3, koef:1)
            j += s
            let k0 = -PathAlg.k1J(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j-5*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m),
                               rightFrom:4*j+3, rightTo:4*j, koef:k0)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m),
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-k0)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m),
                               rightFrom:4*j+3, rightTo:4*j+2, koef:-k0)
            return
        }

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 6*s - 2 ..< 6*s - 1 {
            let k0 = PathAlg.k1JPlus2(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-k0)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-k0)
        }
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        guard s > 1 else {
            var j = 0
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+1)+1, koef:PathAlg.k1J(ell, j: j, m: m))
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m),
                               rightFrom:4*(j+1)+1, rightTo:4*(j+1)+1, koef:PathAlg.k1J(ell, j: j, m: m))
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j-4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+1,
                               rightFrom:4*(j+1)+2, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+1,
                               rightFrom:4*(j+1)+2, rightTo:4*j+3, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:j-5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-4*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+2, koef:1)
            j += s
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+2, koef:-1)
            return
        }

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
            if j < s - 1 {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m))
            }
            if j == s - 1 {
                HHElem.addElemToHH(hhElem, i:j, j:j,
                                   leftFrom:4*(j+m-1)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                                   leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*(j+s)+1, koef:PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in s ..< 2*s - 1 {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-k0)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-k0)
        }
        for j in 3*s - 1 ..< 3*s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:-k0)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:k0)
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
        }
        for j in 6*s - 2 ..< 6*s - 1 {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-1)
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
        }
        for j in 7*s - 2 ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:1)
        }
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        guard s > 1 else {
            var j = 2*s
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+1,
                               rightFrom:4*(j+1)+1, rightTo:4*(j+1)+1, koef:-1)
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*j+3, koef:1)
            j += s
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            return
        }

        for j in s - 1 ..< s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:-k0)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-k0)
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 6*s - 2 ..< 6*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
        }
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        guard s > 1 else {
            var j = 0
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*(j+1)+1, koef:k0)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*(j+1)+2, koef:-k0)
            j += s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+1,
                               rightFrom:4*(j+1)+1, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+1,
                               rightFrom:4*(j+1)+1, rightTo:4*j+3, koef:-1)
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*j+3, koef:-1)
            j += 2*s
            let k1 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j+1, koef:-k1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j+2, koef:k1)
            return
        }

        for j in 0 ..< s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:k0)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:k0)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-k0)
            if j == s - 1 {
                HHElem.addElemToHH(hhElem, i:myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+1), koef:k0)
                HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j+3, koef:k0)
            }
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:1)
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 5*s ..< 6*s {
            let k0 = PathAlg.k1JPlus1(ell, j: j, m: m)
            let j0 = j == 6*s - 1 ? s : 0
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-k0)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+j0)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+j0)+1, koef:-k0)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+j0)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+j0)+2, koef:k0)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:j == 6*s - 1 ? -k0 : k0)
            if j == 6*s - 2 {
                HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:-k0)
            }
        }
    }
}

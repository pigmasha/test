//
//  Created by M on 08.05.17.
//

import Foundation

class ShiftHHElem04 : ShiftHHElem {
    init() {
        super.init(type:4, withTwist: true)
    }

    private func inTwistInterval(_ j: Int, j1: Int, s: Int) -> Bool {
        if j1 < s {
            return j <= j1 || j > j1 + s
        } else {
            return j > j1 - s && j <= j1
        }
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

        let j1 = myModS(2*ell_0)
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m))
            if j < j1 {
                HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in s ..< 3*s {
            if j < j1 + s || j >= j1 + 2*s {
                HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                                   leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*(j+s)+1, rightTo:4*(j+s)+4, koef:-1)
            }
        }
        for j in 3*s ..< 5*s {
            if j >= j1 + 3*s && j < j1 + 4*s {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
                HHElem.addElemToHH(hhElem, i:6*s+(j%s), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
            }
        }
        for j in 5*s ..< 6*s {
            let k0 = j == 6*s - 1 ? -PathAlg.k1JPlus2(ell, j: j, m: m) : PathAlg.k1JPlus2(ell, j: j, m: m)
            let j0 = j == 6*s - 1 ? 0 : s
            HHElem.addElemToHH(hhElem, i:myModS(j+1), j:j,
                               leftFrom:4*(j+m+j0+1)+1, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k0)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+j0+1)+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+j0+1)+1, koef:k0)
            if j >= 5*s+j1 && j < 6*s-1 {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                                   rightFrom:4*j+3, rightTo:4*j+3, koef:k0)
            }
            if j < 5*s+j1-1 || j >= 6*s-j1+1 {
                HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                                   rightFrom:4*j+3, rightTo:4*(j+j0+1)+2, koef:k0)
                HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                                   rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:k0)
            }
        }
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        let j1 = myModS(2*ell_0)
        for j in 0 ..< 2*s {
            let k0 = j < s ? 1 : -1
            if j%s < j1 {
                HHElem.addElemToHH(hhElem, i:j%s, j:j,
                                   leftFrom:4*(j+m-1+s)+3, leftTo:4*(j+m+s)+2,
                                   rightFrom:4*j, rightTo:4*j, koef:k0)
            }
            if j < j1 || j >= s + j1 {
                HHElem.addElemToHH(hhElem, i:s+myMod2S(j+s), j:j,
                                   leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                                   rightFrom:4*j, rightTo:4*(j+s)+1, koef:k0)
            }
        }
        for j in 2*s ..< 3*s {
            let k0 = j < 3*s - 1 ? 1 : -1
            if j < 3*s - 1 {
                HHElem.addElemToHH(hhElem, i:j-s, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m))
            }
            if j < 2*s+j1 || j == 3*s - 1 {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                                   rightFrom:4*j+1, rightTo:4*j+2, koef:k0*PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in 3*s ..< 4*s {
            if j < 3*s+j1 || j == 4*s-1 {
                HHElem.addElemToHH(hhElem, i:myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
            if j < 3*s+j1 {
                HHElem.addElemToHH(hhElem, i:j-s, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
        for j in 4*s ..< 6*s {
            if j >= 5*s - 1 && j < 6*s - 1 {
                HHElem.addElemToHH(hhElem, i:j-s, j:j,
                                   leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                                   rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
        for j in 6*s ..< 8*s {
            if j >= 7*s - 1 && j < 8*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
                HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
            }
        }
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        let j1 = myModS(2*ell_0)
        for j in 0 ..< s {
            let k0 = j < s - 1 ? -1 : 1
            if j < j1 || j == s - 1 {
                HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j+1, koef:k0*PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in s ..< 2*s {
            if j < 2*s - 1 {
                HHElem.addElemToHH(hhElem, i:j-s, j:j,
                                   leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            }
            if j < s + j1 {
                HHElem.addElemToHH(hhElem, i:j, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
        for j in 2*s ..< 3*s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        }
        for j in 3*s ..< 4*s {
            if j < 3*s + j1 {
                HHElem.addElemToHH(hhElem, i:j, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                                   rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
            }
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+2, rightTo:4*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            if myModS(j - s + 1 - ell_0) != 0 {
                HHElem.addElemToHH(hhElem, i:j-5*s+1, j:j,
                                   leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:j < 6*s-1 ? -1 : 1)
            }
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 7*s ..< 8*s {
            let k0 = j < 8*s - 1 ? -1 : 1
            if myModS(j-s+1-ell_0) == 0 {
                HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                                   leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+2, rightTo:4*(j+1), koef:k0*PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in 8*s ..< 9*s {
            let j0 = j == 9*s - 1 ? s : 0
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+j0)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            if j == 9*s - 2 {
                HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
            }
            if j < 8*s+j1-1 || j > 9*s-j1 {
                HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1+j0+s)+2, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+1), koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        for j in s - 1 ..< s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)-1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
        }
        for j in 3*s - 2 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-PathAlg.k1JPlus2(ell, j: j, m: m))
        }
        for j in 3*s ..< 4*s - 2 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 5*s ..< 6*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:1)
        }
        for j in 7*s ..< 8*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-1)
        }
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        for j in 0 ..< s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
        }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 2*s - 2 ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 3*s - 2 ..< 3*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        }
        for j in 3*s ..< 4*s - 2 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 4*s ..< 5*s - 2 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 8*s - 2 ..< 8*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
        }
        for j in 9*s - 1 ..< 9*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:1)
        }
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
        }
        for j in 0 ..< s - 1 {
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+3, koef:1)
        }
        for j in 5*s ..< 6*s {
            let k0 = j == 6*s - 1 ? 1 : -1
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:k0*PathAlg.k1JPlus1(ell, j: j, m: m))
            if j < 6*s - 1 {
                HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*j+2, rightTo:4*j+3, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
        for j in 6*s ..< 7*s {
            let k0 = j == 7*s - 1 ? -1 : 1
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-k0)
            if j < 7*s - 1 {
                HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
            }
        }
        for j in 8*s - 1 ..< 8*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        }
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        for j in 0 ..< s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j: j, m: m))
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 2*s ..< 3*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 5*s ..< 6*s {
            let j0 = j == 6*s - 1 ? s : 0
            let k0 = j == 6*s - 1 ? -PathAlg.k1JPlus2(ell, j: j, m: m) : PathAlg.k1JPlus2(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+j0+1)+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-k0)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1+j0)+1, koef:k0)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1+j0)+2, koef:k0)
            if j == 6*s - 2 {
                HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-k0)
                HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:k0)
            }
        }
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        for j in 0 ..< s {
            let k0 = j == s - 2 ? -1 : 1
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+1), koef:-k0*PathAlg.k1J(ell, j: j, m: m))
            if j >= s-2 {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m))
            } else {
                HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                                   leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*(j+s)+1, koef:PathAlg.k1J(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                                   leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
            }
            if j == s - 2 {
                HHElem.addElemToHH(hhElem, i:j, j:j,
                                   leftFrom:4*(j+m)-1, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                                   leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in 2*s - 2 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
            if j == 2*s - 1 {
                HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                                   leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                                   rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:-PathAlg.k1J(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m))
            }
        }
        for j in 2*s ..< 3*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
        }
        for j in 4*s - 2 ..< 4*s {
            let k0 = j == 4*s - 1 ? -1 : 1
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:k0)
            if j == 4*s - 1 {
                HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
            }
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            if j < 6*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
                HHElem.addElemToHH(hhElem, i:j, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*j+3, koef:-1)
            } else {
                HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-1)
            }
            if j < 6*s - 2 {
                HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-1)
            }
        }
        for j in 6*s ..< 7*s {
            if j < 7*s - 1 {
                HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-1)
            } else {
                HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-1)
                HHElem.addElemToHH(hhElem, i:j-s, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*j+3, koef:-1)
            }
            if j >= 7*s - 2 {
                let k0 = j == 7*s - 1 ? -1 : 1
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                                   rightFrom:4*j+3, rightTo:4*(j+1), koef:k0)
            }
        }
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        for j in 0 ..< s {
            let k0 = j < s - 2 ? -PathAlg.k1JPlus1(ell, j: j, m: m) : PathAlg.k1JPlus1(ell, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:k0)
            if j < s - 2 {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j+1, koef:k0)
            } else {
                HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+s)+1, koef:-k0)
            }
        }
        for j in 5*s ..< 6*s {
            let k0 = j >= 6*s - 3 && j <= 6*s - 2 ? 1 : -1
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k0*PathAlg.k1JPlus1(ell, j: j, m: m))
            if j < 6*s - 3 {
                HHElem.addElemToHH(hhElem, i:j, j:j,
                                   leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            } else {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        for j in 0 ..< s {
            let k0 = j < 3 ? -1 : 1
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:k0 * PathAlg.k1J(ell, j: j, m: m))
            if j < s - 2 {
                HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                                   leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+s)+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                                   leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            } else {
                HHElem.addElemToHH(hhElem, i:j+s, j:j,
                                   leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                                   leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
            if j == s - 3 {
                HHElem.addElemToHH(hhElem, i:myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*j+3, koef:-1)
            }
        }
        for j in s ..< 2*s - 3 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
        for j in 3*s - 3 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:j == 3*s-1 ? 1 : -1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:1)
        }
        for j in 3*s ..< 4*s - 3 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        }
        for j in 5*s - 3 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:j==5*s-1 ? 1 : -1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 5*s ..< 6*s {
            let k0 = j < 6*s-3 || j == 6*s-1 ? -1 : 1
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k0 * PathAlg.k1JPlus1(ell, j: j, m: m))
            if j < 6*s-3 || j == 6*s-1 {
                let j0 = j == 6*s - 1 ? s : 0
                HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1+j0)+1, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+1+j0)+1, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1+j0)+2, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+1+j0)+2, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            } else {
                HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
                HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            }
            let k1 = j < 6*s-3 ? 1 : -1
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:k1 * PathAlg.k1JPlus1(ell, j: j, m: m))
            if j == 5*s + 2 {
                HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+3, rightTo:4*(j+s+1)+3, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
    }
}

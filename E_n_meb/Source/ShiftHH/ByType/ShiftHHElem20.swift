//
//  Created by M on 01.07.2018.
//

import Foundation

final class ShiftHHElem20: ShiftHHElem {
    init() {
        super.init(type:20)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j:j, m:m+4))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-PathAlg.k1JPlus1(ell, j:j, m:m+4))
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:1)
        }
    }
    
    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j: j, m: m+5))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+5))
        }
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell, j: j, m: m+5)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:k)
            if j == s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+1), koef:k)
            }
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
        }
        for j in 5*s ..< 6*s {
            let k = -PathAlg.k1J(ell, j: j, m: m+5)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1+s*f(j,6*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,6*s-1))+1, koef:k)
        }
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j, rightTo:4*j+1, koef:1)
        }
        for j in 4*s ..< 6*s {
            let k = PathAlg.k1J(ell, j: j, m: m+5)
            if j < 5*s - 1 || j == 6*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+2, rightTo:4*(j+1), koef:k*f1(j,5*s))
            }
        }
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell, j: j, m: m+4)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:k)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:-k)
            if j < s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j, rightTo:4*(j+1), koef:k)
            }
        }
        for j in s ..< 3*s {
            if j < 2*s - 1 || j == 3*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                                   rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
            }
        }
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
        }
        for j in 2*s ..< 4*s {
            if j < 3*s - 1 || j == 4*s - 1 {
                let k = PathAlg.k1J(ell+1, j: j, m: m-1)
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:k)
                HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:k)
            }
        }
        for j in 4*s ..< 6*s {
            if j < 5*s - 1 || j == 6*s - 1 {
                let k = PathAlg.k1J(ell+1, j: j, m: m)
                HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                                   rightFrom:4*j+2, rightTo:4*(j+1)+1, koef:k)
            }
        }
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        for j in 0 ..< s {
            let k = -PathAlg.k1J(ell+1, j: j, m: m-2)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:k)
        }
        for j in s ..< 2*s - 1 {
            let k = PathAlg.k1J(ell+1, j: j, m: m-1)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+1), koef:k)
        }
        for j in 2*s ..< 4*s {
            if j < 3*s - 1 || j == 4*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
            }
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+2, rightTo:4*(j+1)+1, koef:1)
        }
        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+1, koef:1)
        }
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*j, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 2*s ..< 4*s {
            if j < 3*s - 1 || j == 4*s - 1 {
                let k = PathAlg.k1J(ell+1, j: j, m: m)
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+2),
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:k)
            }
        }
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell+1, j: j, m: m-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-k)
            if j == s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                                   rightFrom:4*j, rightTo:4*(j+1), koef:k)
            }
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        }
        for j in 7*s ..< 8*s {
            let k = -PathAlg.k1J(ell+1, j: j, m: m-1)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,8*s-1))+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+s*f(j,8*s-1))+1, koef:k)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+s*f(j,8*s-1))+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(j,8*s-1))+2, koef:k)
        }
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*j, koef:1)
        }
        for j in 3*s - 1 ..< 4*s - 1 {
            let k = -PathAlg.k1J(ell+1, j: j, m: m-1)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:k)
        }
        for j in 5*s ..< 6*s {
            let k = PathAlg.k1J(ell+1, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:k)
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
        }
        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2)+1, leftTo:4*(j+m+2)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-1)
        }
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        for j in 0 ..< s {
            let k = PathAlg.k1J(ell+1, j: j, m: m-2)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:k)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:k)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:k)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-k)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:k)
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+1, koef:-1)
        }
        for j in 6*s - 1 ..< 6*s {
            let k = PathAlg.k1J(ell+1, j: j, m: m+1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:k)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:k)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:-k)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:k)
        }
    }
}

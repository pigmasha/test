//
//  Created by M on 12.02.18.
//

final class ShiftHHElem08 : ShiftHHElem {
    init() {
        super.init(type:8, withTwist: false)
    }
    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        for j in s..<2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:4*j, leftTo:4*j, right:4*j, koef:PathAlg.k1J(ell, j:j, m:m+2))
        }
        for j in 2*s..<4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+1, right:4*j+1, koef:1)
        }
        for j in 5*s..<6*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:4*(j+s)+2, leftTo:4*(j+s)+2, right:4*(j+s)+2, koef:1)
        }
        for j in 7*s..<8*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:4*j+2, leftTo:4*j+2, right:4*j+2, koef:1)
        }
        for j in 8*s..<9*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:4*j+3, leftTo:4*j+3, right:4*j+3, koef:-PathAlg.k1J(ell, j:j, m:m+2))
        }
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j, rightTo:4*j, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*j+1, koef:PathAlg.k1J(ell, j:j, m:m+3))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j:j, m:m+3))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j:j, m:m+3))
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*j+1, koef:PathAlg.k1J(ell, j:j, m:m+3))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j:j, m:m+3))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+1, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j:j, m:m+3))
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j:j, m:m+2))
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j:j, m:m+2))
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:1)
        }
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)-1, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j:j, m:m+2))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
        }
        for j in 8*s ..< 9*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-1)
        }
    }

}

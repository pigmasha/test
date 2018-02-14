//
//  Created by M on 12.02.18.
//

final class ShiftHHElem08 : ShiftHHElem {
    init() {
        super.init(type:8, withTwist: true)
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
        //printK(prefix: "7-8", jFrom: 7*s, jTo: 8*s-1, m: m, ell: ell) { j in return j % s == 1 || j % s == 2 ? 1 : -1 }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m+2) * f2(j, 8*s - 1))
        }
        //printK(prefix: "8-9", jFrom: 8*s, jTo: 9*s, m: m, ell: ell) { j in return j % s == 0 || j % s == s-1 ? 1 : -1 }
        for j in 8*s ..< 9*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m+3))
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m+3))
        }
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*j, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*j, rightTo:4*j, koef:1)
        }
        //printK(prefix: "2-3", jFrom: 2*s, jTo: 3*s, m: m, ell: ell) { j in return j % s == 0 ? 1 : -1 }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m+2))
        }
        //printK(prefix: "3-4", jFrom: 3*s, jTo: 4*s, m: m, ell: ell) { j in return j % s == 0 ? -1 : 1 }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m+2))
        }
        //printK(prefix: "4-5", jFrom: 4*s, jTo: 5*s, m: m, ell: ell) { j in return j % s == 0 || j % s == s-1 ? 1 : -1 }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+3))
        }
        //printK(prefix: "5-6", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { j in return j % s == 0 || j % s == s-1 ? -1 : 1 }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+3))
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:1)
        }
    }
    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        //printK(prefix: "0-1", jFrom: 0, jTo: s, m: m, ell: ell) { j in return j % s == 0 ? 1 : -1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+2)-1, leftTo:4*(j+2)-1,
                               rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j: j, m: m+1))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
        }
        //printK(prefix: "5-6", jFrom: 5*s, jTo: 6*s-1, m: m, ell: ell) { j in return f1(j, 6*s - 2) }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m+3)*f1(j, 6*s - 1))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m+3))
        }
    }
    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        //printK(prefix: "0-1", jFrom: 0, jTo: s, m: m, ell: ell) { j in return j % s == 0 || j % s == s - 1 ? -1 : 1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m+2))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m+2))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+2))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:PathAlg.k1J(ell, j: j, m: m+2))
        }
        //printK(prefix: "1-2", jFrom: s, jTo: 2*s, m: m, ell: ell) { j in return j % s == s - 1 ? 1 : -1 }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:PathAlg.k1J(ell, j: j, m: m+3))
        }
        //printK(prefix: "2-3", jFrom: 2*s, jTo: 3*s, m: m, ell: ell) { j in return j % s == s - 1 ? -1 : 1 }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:PathAlg.k1J(ell, j: j, m: m+3))
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:1)
        }
    }
    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        //printK(prefix: "0-1", jFrom: 0, jTo: s, m: m, ell: ell) { j in return j % s == s - 1 ? 1 : -1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j: j, m: m+2))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
        }
        //printK(prefix: "5-6", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { j in return j % s == s - 1 ? 1 : -1 }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+2))
        }
    }
    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        //printK(prefix: "0-1", jFrom: 0, jTo: s, m: m, ell: ell) { j in return j % s == s - 1 || j % s == s - 2 ? -1 : 1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:PathAlg.k1J(ell, j: j, m: m+3))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:1)
        }
        //printK(prefix: "5-6", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { j in return j % s == s - 1 || j % s == s - 2 ? 1 : -1 }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s-f0(j, 6*s-1)*s+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+f0(j, 6*s-1)*s+1)+1, koef:-PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m+3))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m+3))
        }
    }
    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+1,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)-1, leftTo:4*(j+m)+1,
                               rightFrom:4*j, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+1,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        }
        //printK(prefix: "4-5", jFrom: 4*s, jTo: 5*s, m: m, ell: ell) { j in return j % s == s - 1 || j % s == s - 2 ? 1 : -1 }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m+2))
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+2))
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m+2))
        }
        //printK(prefix: "5-6", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { j in return j % s == s - 1 || j % s == s - 2 ? 1 : -1 }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+2))
        }
        //printK(prefix: "6-7", jFrom: 6*s, jTo: 7*s-1, m: m, ell: ell) { j in return j % s == 1 || j % s == 2 ? -1 : 1 }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1J(ell, j: j, m: m+3) * f2(j, 7*s - 1))
        }
    }
    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        //printK(prefix: "0-1", jFrom: 0, jTo: s, m: m, ell: ell) { j in return j % s == s - 1 || j % s == s - 2 ? -1 : 1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m+2))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m+s-2))
        }
        //printK(prefix: "5-6", jFrom: 5*s, jTo: 6*s-1, m: m, ell: ell) { j in return j % s == 0 || j % s == 2 || j % s == 4 || j % s == 5 ? -1 : 1 }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+f0(j, 6*s-1)*s+1)+1, koef:PathAlg.k1J(ell, j: j, m: m+s-2))
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+s-2))
        }
    }
    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        }
        //printK(prefix: "2-3", jFrom: 2*s, jTo: 3*s-1, m: m, ell: ell) { j in return j % s == 1 || j % s == 2 ? 1 : -1 }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:PathAlg.k1J(ell, j: j, m: m+2) * f2(j, 3*s - 1))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+2) * f2(j, 3*s - 1))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+2) * f2(j, 3*s - 1))
        }
        //printK(prefix: "3-4", jFrom: 3*s, jTo: 4*s-1, m: m, ell: ell) { j in return j % s == 1 || j % s == 2 ? 1 : -1 }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m+2) * f2(j, 4*s - 1))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+2) * f2(j, 4*s - 1))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+2) * f2(j, 4*s - 1))
        }
        //printK(prefix: "4-5", jFrom: 4*s, jTo: 5*s, m: m, ell: ell) { j in return j % s == 0 || j % s == 2 ? 1 : -1 }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m+s-3))
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+s-3))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+s-3))
        }
        //printK(prefix: "5-6", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { j in return j % s == 0 || j % s == 2 ? 1 : -1 }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m+s-3))
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1J(ell, j: j, m: m+s-3))
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:s+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:1)
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s-f0(j, 7*s-1)*s+1), koef:1)

        }
        for j in 8*s - 1 ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:s+myMod2S(j+s+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        }
    }
}

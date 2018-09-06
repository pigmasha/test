//
//  Created by M on 31.01.18.
//

final class ShiftHHElem06 : ShiftHHElem {
    init() {
        super.init(type:6)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j+2, right:4*j, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+3, right:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m+1))
        }
        for j in 4*s..<6*s {
            if j < 5*s-1 || j == 6*s-1 {
                HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:4*j+2, leftTo:4*(j+1), right:4*j+2,
                                   koef:-PathAlg.k1JPlus1(ell, j:j, m:m+1))
            }
        }
        for j in 6*s..<8*s {
            if j < 7*s-1 || j == 8*s-1 {
                HHElem.addElemToHH(hhElem, i:5*s+(j%s), j:j, leftFrom:4*j+3, leftTo:4*(j+1)+1, right:4*j+3, koef:1)
            }
        }
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:7*s)

        //printK(prefix:"1.", jFrom: 0, jTo: s, m: m, ell: ell) { _ in -1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1J(ell, j: j, m: m+1))
        }
        //printK(prefix:"2.", jFrom: s, jTo: 2*s, m: m, ell: ell) { f1($0, 2*s-1) }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+2, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:1)
        }
        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in 7*s ..< 8*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:1)
        }
        //printK(prefix:"3.", jFrom: 8*s, jTo: 9*s, m: m, ell: ell) { f1($0, 9*s-1) }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
    }
    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)-1, leftTo:4*(j+m)+1,
                               rightFrom:4*j, rightTo:4*j, koef:-1)
        }
        //printK(prefix:"1.", jFrom: 2*s, jTo: 3*s-1, m: m, ell: ell) { -f1($0, 3*s-2) }
        for j in 2*s ..< 4*s {
            if j < 3*s - 1 || j == 4*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
            }
        }
        //printK(prefix:"3.", jFrom: 4*s, jTo: 5*s, m: m, ell: ell) { -f1($0, 5*s-1) }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
        }
        //printK(prefix:"4.", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { f1($0, 6*s-1) }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
        }
    }
    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:8*s)

        //printK(prefix:"1.", jFrom: 0, jTo: s, m: m, ell: ell) { f1($0, s-2) }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
        for j in 3*s - 1 ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
        }
        for j in 2*s ..< 3*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:-1)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-1)
        }
        //printK(prefix:"2.", jFrom: 7*s, jTo: 8*s, m: m, ell: ell) { j in f2(j, 8*s-2) }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s-f(j, 8*s-1)*s+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1),
                               koef:PathAlg.k1JPlus1(ell, j: j, m: m+1) * f1(j, 8*s-1))
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s-f(j, 8*s-1)*s+1)+1,
                               koef:PathAlg.k1JPlus1(ell, j: j, m: m+1) * f1(j, 8*s-1))
        }
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:9*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)-1, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        }
        //printK(prefix:"1.", jFrom: 2*s, jTo: 3*s - 1, m: m, ell: ell) { j in -f1(j, 3*s-2) }
        for j in 2*s ..< 4*s {
            if j < 3*s-1 || j == 4*s-1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                                   rightFrom:4*j+1, rightTo:4*(j+1), koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            }
        }
    }
    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        //printK(prefix:"1.", jFrom: 0, jTo: s, m: m, ell: ell) { j in f1(j, s-2) }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
        }
        //printK(prefix:"2.", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { j in f2(j, 5*s)*f2(j, 6*s-1) }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+s-f(j, 6*s-1)*s+1)+1,
                               koef:PathAlg.k1JPlus2(ell, j: j, m: m+1)*f1(j, 6*s-1))
        }
    }
    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:9*s)

        //printK(prefix:"1.", jFrom: 0, jTo: s, m: m, ell: ell) { j in f1(j, s-3) }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:-PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m))
        }
        //printK(prefix:"2.", jFrom: s, jTo: 2*s-1, m: m, ell: ell) { j in -f2(j, s) }
        for j in s ..< 3*s {
            if j < 2*s - 1 || j == 3*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                                   rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
            }
        }
        for j in 3*s ..< 5*s {
            if j < 4*s - 1 || j == 5*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                                   rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            }
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:f1(j, 6*s-1))
        }
        for j in 6*s - 1 ..< 6*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        }
        for j in 5*s ..< 6*s - 1 {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-f1(j, 7*s-1))
        }
        for j in 6*s ..< 7*s - 1 {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:1)
        }
        for j in 7*s - 1 ..< 7*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:1)
        }
    }
    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        //printK(prefix:"1.", jFrom: 0, jTo: s, m: m, ell: ell) { j in f2(j, 0) }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
        }
        //printK(prefix:"2.", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { j in -f2(j, 5*s) }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s-f(j, 6*s-1)*s+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
    }
    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        //printK(prefix:"1.", jFrom: 0, jTo: s, m: m, ell: ell) { _ in -1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1JPlus1(ell, j: j, m: m+1), noZeroLenR: true)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+3, koef:PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
        for j in s ..< 3*s {
            if j < 2*s - 1 || j == 3*s - 1 {
                HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                                   leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                                   rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
            }
        }
        for j in 3*s ..< 4*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        }
        for j in 4*s - 1 ..< 4*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        }
        for j in 5*s - 1 ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        }
        for j in 4*s ..< 5*s - 1 {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        }
        //printK(prefix:"2.", jFrom: 5*s, jTo: 6*s, m: m, ell: ell) { _ in -1 }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1), noZeroLenL: true)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+f(j, 6*s-1)*s)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1+f(j, 6*s-1)*s)+1, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1+f(j, 6*s-1)*s)+1, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+s-f(j, 6*s-1)*s+1)+2, koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
    }
    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j, rightTo:4*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j, rightTo:4*j+1, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
        }
        //printK(prefix:"1.", jFrom: 5*s-1, jTo: 5*s, m: m, ell: ell) { _ in 1 }
        //printK(prefix:"2.", jFrom: 5*s, jTo: 6*s - 1, m: m, ell: ell) { _ in 1 }
        for j in 5*s - 1 ..< 6*s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+2, rightTo:4*(j+1),
                               koef:(j == 5*s-1 ? -1 : 1) * PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
        //printK(prefix:"3.", jFrom: 6*s, jTo: 7*s-1, m: m, ell: ell) { _ in 1 }
        //printK(prefix:"4.", jFrom: 7*s-1, jTo: 7*s, m: m, ell: ell) { _ in 1 }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                               rightFrom:4*j+3, rightTo:4*(j+1+f(j, 7*s-1)*s)+1,
                               koef:(j == 7*s-1 ? 1 : -1) * PathAlg.k1JPlus2(ell, j: j, m: m+1))
        }
    }
    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        //printK(prefix:"1.", jFrom: 0, jTo: s, m: m, ell: ell) { _ in 1 }
        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j, koef:PathAlg.k1J(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+1, koef:PathAlg.k1J(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-PathAlg.k1J(ell, j: j, m: m+1))
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:PathAlg.k1J(ell, j: j, m: m+1))
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:f1(j, 2*s-1))
        }
        for j in s ..< 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:-1)
        }
        for j in 2*s - 1 ..< 2*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+1, rightTo:4*j+3, koef:-1)
        }
    }

}

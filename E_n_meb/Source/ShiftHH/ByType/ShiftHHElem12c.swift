//
//  Created by M on 04.07.2018.
//

import Foundation

final class ShiftHHElem12c: ShiftHHElem {
    init() {
        super.init(type:12)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                           rightFrom:4*j+2, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+2))
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                           rightFrom:4*j+2, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+2))
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 4*s+myModS(3)
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                           rightFrom:4*j+2, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+2))
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                           rightFrom:4*j+2, rightTo:4*j+2, koef:PathAlg.k1J(ell, j: j, m: m+2))
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:7*s)

        var j = myModS(3)
        var k = PathAlg.k1J(ell, j: j, m: m+3)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j, koef:-k)
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j, koef:k)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j+1, koef:-k)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:k)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
        j += 3*s - myModS(1)
        k = -PathAlg.k1J(ell, j: j, m: m)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:-k)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:k)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-k)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1)+1, koef:k)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 2*s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-f2(s,1)*PathAlg.k1J(ell, j: j, m: m+2))
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f2(s,1)*PathAlg.k1J(ell, j: j, m: m+2))
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        var j = s + myModS(2)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-f2(s,1))
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:f2(s,1))
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:9*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m+2), noZeroLenR: true)
        j = s+myModS(2)+f(s,1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-f2(s,1)*PathAlg.k1J(ell, j: j, m: m+2))
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:f2(s,1)*PathAlg.k1J(ell, j: j, m: m+2))
        j = 2*s+myModS(2)-f(s,1)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:-f2(s,1)*PathAlg.k1J(ell, j: j, m: m+2))
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        var j = s + myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1)+f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1)-f(s,1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:1)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m+3), noZeroLenR: true)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:1)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        var j = myModS(2)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*j+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*j+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*j, koef:1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*j+2, koef:-1)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        if s == 2 {
            var j = s + 1
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+2)+1, rightTo:4*(j+2)+1, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*(j+2)+1, rightTo:4*(j+s+1)+1, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m),
                               rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m),
                               rightFrom:4*j+3, rightTo:4*(j+1)+2, koef:-1)
            return
        }
        var j = s + 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s+1)+1, koef:-1)
        j = 2*s - f2(s,1)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1, koef:-1)
        j = 3*s + 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:-1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:-1)
        j = 4*s - f2(s,1)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:-1)
        j = 5*s + myModS(1)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(s,1))+2, leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+1+s*f(s,1))+1, koef:-f2(s,1)*PathAlg.k1J(ell+1, j: j, m: m-1))
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1+s*f(s,1))+1, leftTo:4*(j+m+2),
                           rightFrom:4*j+3, rightTo:4*(j+s+1+s*f(s,1))+2, koef:-f2(s,1)*PathAlg.k1J(ell+1, j: j, m: m-1))
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        guard s > 1 else {
            var j = 0
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1)+1, koef:-1)
            j += 3*s
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j+1, rightTo:4*j, koef:PathAlg.k1J(ell+1, j: j, m: m))
            j += s
            HHElem.addElemToHH(hhElem, i:j-4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m),
                               rightFrom:4*j+2, rightTo:4*j, koef:PathAlg.k1J(ell+1, j: j, m: m))
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j-6*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+1,
                               rightFrom:4*j+3, rightTo:4*j, koef:-1)
            return
        }
        if s == 2 {
            var j = 1
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                               rightFrom:4*j, rightTo:4*(j+2)+1, koef:-1)
            j += 3*s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+1, rightTo:4*(j+1), koef:1)
            j += s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m),
                               rightFrom:4*j+2, rightTo:4*(j+1), koef:1)
            j += 2*s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2)+1,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
            return
        }
        var j = s + 1
        HHElem.addElemToHH(hhElem, i:j+f(s,1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:1)
        HHElem.addElemToHH(hhElem, i:j+s+f(s,1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*j+1, koef:-1)
        j = 2*s + 1
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:-PathAlg.k1J(ell+1, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:s == 1 ? 5 : j+3*s, j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*j+3, koef:PathAlg.k1J(ell+1, j: j, m: m))
        j = 5*s + 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1), koef:-PathAlg.k1J(ell+1, j: j, m: m-1))
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+2)+1,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:-1)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        guard s > 1 else {
            var j = 0
            let k0 = -PathAlg.k1J(ell+1, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:-k0)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+1)+1, koef:k0)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:k0)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+1)+2, koef:-k0)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:k0)
            j += s
            let k1 = -PathAlg.k1J(ell+1, j: j, m: m)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*(j+1)+1, koef:-k1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*j+1, koef:k1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*(j+1)+2, koef:k1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*j+2, koef:-k1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m),
                               rightFrom:4*j, rightTo:4*j+3, koef:k1)
            j += s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m)+1,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m)+1,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+1,
                               rightFrom:4*j+1, rightTo:4*j+3, koef:-1)
            j += 3*s
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*(j+1)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+1)+2, rightTo:4*j+3, koef:-1)
            j += 2*s
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m)+2,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+2,
                               rightFrom:4*j+2, rightTo:4*j+3, koef:1)
            j += s
            HHElem.addElemToHH(hhElem, i:j-8*s, j:j,
                               leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                               rightFrom:4*j+3, rightTo:4*j, koef:-PathAlg.k1J(ell+1, j: j, m: m))
            return
        }
        if s == 2 {
            var j = 1
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+2)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+2)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+2)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+2)+1, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                               rightFrom:4*j, rightTo:4*j+3, koef:-1)
            j += s
            HHElem.addElemToHH(hhElem, i:j-s, j:j,
                               leftFrom:4*(j+m+2)+1, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                               rightFrom:4*j+1, rightTo:4*j+3, koef:-1)
            j += 3*s
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                               rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
            j += 2*s - 1
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+2, rightTo:4*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+2, rightTo:4*(j+1)+2, koef:1)
            j += s - 1
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j+2, rightTo:4*j+3, koef:1)
            j += s - 1
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:-1)
            j += s - 1
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                               leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j+3, rightTo:4*j+3, koef:1)
            return
        }
        var j = 1
        var k = PathAlg.k1J(ell+1, j: j, m: m-1)//1,-2
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:-k)
        HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+s)+2, koef:k)
        j += s
        k = PathAlg.k1J(ell+1, j: j, m: m-2)//0,1,-1,2,3
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+s)+1, koef:-k)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+s)+2, koef:k)
        HHElem.addElemToHH(hhElem, i:j+4*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j+3, koef:k)
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+3, koef:-1)
        j += s
        HHElem.addElemToHH(hhElem, i:j-s, j:j,
                           leftFrom:4*(j+m+s)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+1, koef:1)
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j+1, rightTo:4*j+3, koef:1)
        j += 2*s - 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+2, koef:1)
        j += 1
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s)+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*j+3, koef:-1)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j+2, rightTo:4*j+2, koef:-1)
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j+2, rightTo:4*j+3, koef:1)
        j += s - 1
        k = PathAlg.k1J(ell+1, j: j, m: m)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+1), koef:-k)
        HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+1, koef:-k)
        HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s+1)+2, koef:k)
        HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:k)
        j += 1
        HHElem.addElemToHH(hhElem, i:j-3*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:-PathAlg.k1J(ell+1, j: j, m: m-2))//0,1,-1,2,3
    }

    override func koef11(s: Int, ell: Int) -> Int {
        return minusDeg(ell)
    }
}

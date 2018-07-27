//
//  ShiftHHElem05c.swift
//  E_n_meb
//
//  Created by M on 08.06.2018.
//

import Foundation

final class ShiftHHElem05c : ShiftHHElem {
    init() {
        super.init(type:5)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j+3, right:4*j, koef:1)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = myModS(3)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j+3, right:4*j, koef:1)
    }
    
    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 2*s + 2
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f2(j%s, s-1))
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-f2(j%s, s-1))
        j += (j % s == s - 1) ? 2*s : s
        HHElem.addElemToHH(hhElem, i:6*s+myModS(j), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*j+3, koef:-PathAlg.kGamma(ell, j: j+1, m: m))
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        var j = 2
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
        j += s
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*j+1, koef:f2(j%s, s-1) * PathAlg.kGamma(ell, j: j, m: m))
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 2
        HHElem.addElemToHH(hhElem, i:j+3*s, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+s)+1,
                           koef:-PathAlg.k1J(ell, j: j+1, m: m) * PathAlg.kGamma(ell, j: j, m: m) * f2(j%s, s-1))
        j += 3*s - 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:f2(j%s, s-2) * PathAlg.kGamma(ell, j: j+1, m: m))
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        var j = 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
        j = 4*s+1
        let j1 = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+j1+1)+2,
                           rightFrom:4*(j+j1)+1, rightTo:4*(j+1),
                           koef:-f1(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m)*PathAlg.k1J(ell, j: j+1, m: m))
        j = 7*s+1
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+j1+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s-j1+1)+1, koef:-f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+j1+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+3, rightTo:4*(j+s-j1+1)+2, koef:f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m))
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j: j, m: m) * f1(j%s, s-2))
        j += s
        HHElem.addElemToHH(hhElem, i:myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j: j, m: m) * f1(j%s, s-2))
        j = 3*s+1
        let k0 = f2(j%s, s-2)*PathAlg.kGamma(ell, j: j, m: m)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:k0)
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:k0)
        j = 5*s+1
        let k1 = PathAlg.kGamma(ell, j: j, m: m) * PathAlg.kGamma(ell, j: j+1, m: m) * f2(j%s, s-2)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+2), leftTo:4*(j+m+2),
                           rightFrom:4*j+2, rightTo:4*(j+1)+1, koef:k1)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        var j = 2*s + 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+2,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1),
                           koef:f1(j%s, s-2) * PathAlg.k1J(ell, j: j+2, m: m))
        j = 4*s + 1
        let k1 = -f2(j%s, s-2) * PathAlg.k1J(ell, j: j+2, m: m)
        HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+s+1)+1,
                           koef:k1)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        var j = 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1),
                           koef:-PathAlg.kGamma(ell, j: j+1, m: m) * f1(j%s, s-2))
        j = 2*s+1
        HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:f2(j%s, s-2))
        j = 4*s+1
        HHElem.addElemToHH(hhElem, i:7*s+myModS(j), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*(j+s)+2, rightTo:4*j+3,
                           koef:-f1(j%s, s-2) * PathAlg.k1J(ell, j: j+2, m: m))
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        var j = 1
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:-f1(j%s, s-2))
        j = 2*s+1
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m+s)+2, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+s)+1,
                           koef:f1(j%s, s-2) * PathAlg.k1J(ell, j: j+1, m: m))
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        var j = 2*s
        let k = -f2(j%s, s-1) * f2(j%s, s-3) * PathAlg.k1J(ell, j: j+2, m: m)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+1,
                           rightFrom:4*(j+s)+1, rightTo:4*(j+1), koef:k)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+s+2)+2,
                           rightFrom:4*(j+s)+2, rightTo:4*(j+1), koef:k)
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        var j = s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1),
                           koef:-f2(j%s, s-1) * f2(j%s, s-3) * PathAlg.k1J(ell, j: j+1, m: m))
        j += 4*s
        HHElem.addElemToHH(hhElem, i:5*s+myModS(j), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j+2, rightTo:4*j+3, koef:f2(j%s, s-3))
    }

    override func oddKoef0(degree: Int, n: Int, s: Int, m: Int, ell: Int) -> Int {
        return PathAlg.k1J(ell, j: 0, m: 0) * PathAlg.k1J(ell, j: myModS(3), m: 0)
    }

    override func mainKoef(ell: Int) -> Int {
        return -PathAlg.k1J(ell, j:PathAlg.s, m:2)
    }
}

//
//  Created by M on 08.06.2018.
//

final class ShiftHHElem10c : ShiftHHElem {
    init() {
        super.init(type:10)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h: 6*s)
        let j = s
        HHElem.addElemToHH(hhElem, i:j%s, j:j, leftFrom:4*j, leftTo:4*(j+1), right:4*j, koef:1)
    }

    override func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h: 6*s)
        let j = s+1
        HHElem.addElemToHH(hhElem, i:j%s, j:j, leftFrom:4*j, leftTo:4*(j+1), right:4*j, koef:1)
    }

    override func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:7*s)

        var j = 2*s
        let k0 = -f2(j%s, s - 1)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:-k0)
        j += s
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+s+2),
                           rightFrom:4*j+1, rightTo:4*(j+1), koef:k0)
    }

    override func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:1)
    }

    override func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.k1J(ell, j:j%s, m:m+2))
        j += s
        HHElem.addElemToHH(hhElem, i:+myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:PathAlg.k1J(ell, j:j%s, m:m+2))
    }

    override func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = 0
        //printK(prefix: "4:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in return j % s == s - 1 ? -1 : 1})
        let k0 = -f2(j%s, s - 1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:8*s)

        let j = 0
        //let k0 = ell_0 % s == 1 || ell_0 % s == 3 || ell_0 % s == 4 ? -1 : 1
        //printK(prefix: "5-1:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in
        //    return j % s == s - 2 || j % s == s - 4 || j % s == s - 5 ? -1 : 1})
        let k0 = j % s == s - 1 ? -PathAlg.kGamma(ell, j: j, m: m) : PathAlg.kGamma(ell, j: j, m: m+1)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+s+1), j:j,
                           leftFrom:4*(j+m+s+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
        HHElem.addElemToHH(hhElem, i:myMod2S(j+1), j:j,
                           leftFrom:4*(j+m+1)+1, leftTo:4*(j+m+1)+3,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:9*s)

        let j = 0
        //let k0 = ell_0 % s == 1 || ell_0 % s == 4 ? 1 : -1
        //printK(prefix: "6:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in return j % s == s - 2 || j % s == s - 5 ? 1 : -1})
        let k0 = j % s == s - 1 ? -1 : PathAlg.kGamma(ell, j: j, m: m) * PathAlg.kGamma(ell, j: j, m: m+1)

        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+1),
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:8*s)

        let j = 0
        //let k0 = ell_0 % s == 1 ? -1 : 1
        //printK(prefix: "7:", jFrom: 0, jTo: s-1, m: m, ell: ell, f: { j in return j % s == s - 2 ? -1 : 1})
        let k0 = j % s == s - 1 ? -PathAlg.kGamma(ell, j: j, m: m) :
            PathAlg.kGamma(ell, j: j, m: m) * PathAlg.kGamma(ell, j: j, m: m+1) * PathAlg.kGamma(ell, j: j, m: m+2)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+s*f(j, s-1)+1)+2, leftTo:4*(j+m+2),
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:6*s)

        let j0 = 0
        let j = j0 == s - 1 ? j0 : j0 + s
        //printK(prefix: "8:", jFrom: 0, jTo: s-1, m: m, ell: ell, f: { j in return j % s == s - 2 ? 1 : -1})
        let k0 = j % s == s - 1 ? PathAlg.k1J(ell, j: j, m: m+4) * PathAlg.kGamma(ell, j: j, m: m) :
            PathAlg.kGamma(ell, j: j, m: m-1) * PathAlg.kGamma(ell, j: j, m: m) *
            PathAlg.kGamma(ell, j: j, m: m+1) * PathAlg.k1J(ell+1, j: j, m: s)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m+s+1)+1,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
    }

    override func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:7*s)

        let j = 0
        //printK(prefix: "9:", jFrom: 0, jTo: s-1, m: m, ell: ell, f: { j in return j % s == s - 2 ? 1 : -1})
        let k0 = j == s - 1 ? -PathAlg.k1J(ell, j: j, m: m+4) :
            -PathAlg.kGamma(ell, j: j, m: m-1) * PathAlg.kGamma(ell, j: j, m: m) * PathAlg.kGamma(ell, j: j, m: m+1)
        if j == s - 1 {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                               leftFrom:4*(j+m+1)+3, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j, rightTo:4*(j+1), koef:-PathAlg.kGamma(ell, j: j, m: m))
        } else {
            HHElem.addElemToHH(hhElem, i:5*s+j, j:j,
                               leftFrom:4*(j+m+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:-k0)
            HHElem.addElemToHH(hhElem, i:6*s+j, j:j,
                               leftFrom:4*(j+m+s+1)+2, leftTo:4*(j+m+1)+3,
                               rightFrom:4*j, rightTo:4*j+3, koef:k0)
        }
    }

    override func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        var j = 0
        //let k0 = ell_0 % s == 0 || ell_0 % s == 1 ? -1 : 1
        //printK(prefix: "10:", jFrom: 0, jTo: s, m: m, ell: ell, f: { j in return j % s == s - 2 || j % s == s - 1 ? -1 : 1})
        let k0 = j == s - 1 ? PathAlg.k1J(ell, j: j, m: m+3) * PathAlg.kGamma(ell, j: j, m: m) :
            PathAlg.kGamma(ell, j: j, m: m-2) * PathAlg.kGamma(ell, j: j, m: m-1) * PathAlg.kGamma(ell, j: j, m: m) *
            PathAlg.kGamma(ell, j: j, m: m+1) * PathAlg.k1J(ell + 1, j: j, m: 1)
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
        if j != s - 1 {
            HHElem.addElemToHH(hhElem, i:5*s+j, j:j,
                               leftFrom:4*(j+m+1)-1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1)-1, koef:-k0)
        }
        j += s
        HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j,
                           leftFrom:4*(j+m+1), leftTo:4*(j+m+s+1)+2,
                           rightFrom:4*j, rightTo:4*(j+1), koef:k0)
        if j != 2*s - 1 {
            HHElem.addElemToHH(hhElem, i:4*s+j, j:j,
                               leftFrom:4*(j+m+1)-1, leftTo:4*(j+m+s+1)+2,
                               rightFrom:4*j, rightTo:4*(j+1)-1, koef:-k0)
            j = 7*s-1+s*f(j%s, 0)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j,
                               leftFrom:4*(j+m+s+1)+3, leftTo:4*(j+m+s+1)+5,
                               rightFrom:4*j+3, rightTo:4*(j+1)+3, koef:k0)
        }
    }

    override func oddKoef0(degree: Int, n: Int, s: Int, m: Int, ell: Int) -> Int {
        return -PathAlg.kGamma(ell, j: 2, m: 0)
    }

    override func mainKoef(ell: Int) -> Int {
        return PathAlg.k1J(ell, j:0, m:2)
    }
}

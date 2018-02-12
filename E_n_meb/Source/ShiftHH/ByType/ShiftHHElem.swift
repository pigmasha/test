//
//  ShiftHHElem.swift
//  E_n_meb
//
//  Created by M on 09.04.16.
//
//

import Foundation

public struct ShiftVars {
    public let n: Int
    public let s: Int
    public let ell_0: Int
    public let m: Int
    public let ell: Int
    public let r_0: Int

    public init(shift: Int, degree: Int) {
        n = PathAlg.n
        s = PathAlg.s
        ell_0 = shift / PathAlg.twistPeriod
        m = (shift % PathAlg.twistPeriod) / 2
        ell = degree / PathAlg.twistPeriod
        r_0 = shift % PathAlg.twistPeriod
    }
}

class ShiftHHElem {
    let type: Int
    var withTwist : Bool

    init(type: Int, withTwist: Bool) {
        self.type = type
        self.withTwist = withTwist
    }

    class func shiftForType(_ type: Int) -> ShiftHHElem? {
        switch type {
        case 1: return ShiftHHElem01()
        case 2: return ShiftHHElem02()
        case 3: return ShiftHHElem03()
        case 4: return ShiftHHElem04()
        case 5: return ShiftHHElem05()
        case 6: return ShiftHHElem06()
        case 7: return ShiftHHElem07()
        case 8: return ShiftHHElem08()
        default: return nil
        }
    }

    func shift(degree: Int, shift: Int) -> HHElem {
        let hh_shift = HHElem()
        let V = ShiftVars(shift: shift, degree: degree)

        switch (V.r_0) {
            case 0: shift0(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 1: shift1(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 2: shift2(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 3: shift3(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 4: shift4(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 5: shift5(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 6: shift6(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 7: shift7(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 8: shift8(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 9: shift9(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            case 10: shift10(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell_0: V.ell_0, ell: V.ell)
            default: break
        }
        hh_shift.twist(shift)
        if withTwist {
            typealias TryGetKoefFunction = (_ s: Int, _ ell: Int) -> Int
            let koefFunc: TryGetKoefFunction = { s, ell in
                if s % 3 == 0 {
                    return minusDeg(3*(1-ell-s)/s)
                } else {
                    if ell % s == 0 {
                        return minusDeg(ell / s)
                    } else {
                        return -PathAlg.sigmaDeg(ell%s, i: -9*(ell%s), isGamma: false) * minusDeg(ell / s)
                    }
                }
            }
            let kk: Int
            switch type {
            case 5:
                kk = koefFunc(PathAlg.s, V.ell_0)
            case 2:
                kk = PathAlg.sigmaDeg(V.ell_0, i: -6*V.ell_0, isGamma: true)
            default:
                kk = minusDeg(V.ell_0)
            }
            hh_shift.compKoef(kk)
        }
        return hh_shift
    }

    func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
    }

    func printK(prefix: String, jFrom: Int, jTo: Int, m: Int, ell: Int, f: (Int) -> Int) {
        let m1 = 5
        var checks = Array(repeating: true, count: 6 * m1)
        for j in jFrom ..< jTo {
            for m0 in 0..<m1 {
                if f(j) != PathAlg.k1J(ell, j: j, m: m+m0) { checks[m0] = false }
                if f(j) != -PathAlg.k1J(ell, j: j, m: m+m0) { checks[m1+m0] = false }
                if f(j) != PathAlg.k1JPlus1(ell, j: j, m: m+m0) { checks[2*m1+m0] = false }
                if f(j) != -PathAlg.k1JPlus1(ell, j: j, m: m+m0) { checks[3*m1+m0] = false }
                if f(j) != PathAlg.k1JPlus2(ell, j: j, m: m+m0) { checks[4*m1+m0] = false }
                if f(j) != -PathAlg.k1JPlus2(ell, j: j, m: m+m0) { checks[5*m1+m0] = false }
            }
            print(prefix + " j=\(j), k=\(f(j))\t"
                + "j_m=\(PathAlg.k1J(ell, j: j, m: m))\t"
                + "j_m1=\(PathAlg.k1J(ell, j: j, m: m+1))\t"
                + "j1_m=\(PathAlg.k1JPlus1(ell, j: j, m: m))\t"
                + "j1_m1=\(PathAlg.k1JPlus1(ell, j: j, m: m+1))")
        }
        for m0 in 0..<m1 {
            let ss = m0 == 0 ? "" : "+\(m0)"
            if checks[m0] { print("OK: PathAlg.k1J(ell, j: j, m: m\(ss))") }
            if checks[m1+m0] { print("OK: -PathAlg.k1J(ell, j: j, m: m\(ss))") }
            if checks[2*m1+m0] { print("OK: PathAlg.k1JPlus1(ell, j: j, m: m\(ss))") }
            if checks[3*m1+m0] { print("OK: -PathAlg.k1JPlus1(ell, j: j, m: m\(ss))") }
            //if checks[4*m1+m0] { print("OK: PathAlg.k1JPlus2(ell, j: j, m: m\(ss))") }
            //if checks[5*m1+m0] { print("OK: -PathAlg.k1JPlus2(ell, j: j, m: m\(ss))") }
        }
        print("")
    }
}

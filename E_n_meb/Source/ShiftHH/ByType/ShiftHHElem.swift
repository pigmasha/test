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


class ShiftHHElem: NSObject {
    let type: Int
    var withTwist : Bool

    init(type: Int, withTwist: Bool) {
        self.type = type
        self.withTwist = withTwist
        super.init()
    }

    class func shiftForType(_ type: Int) -> ShiftHHElem? {
        switch type {
            case 1: return ShiftHHElem01()
            case 2: return ShiftHHElem02()
            case 3: return ShiftHHElem03()
            default: return nil
        }
    }

    func shift(_ hh_shift: HHElem, degree: Int, shift: Int) {
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
        hh_shift.twist(shift, type: type)
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
}

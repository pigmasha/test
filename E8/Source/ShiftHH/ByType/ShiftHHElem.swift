//
//  Created by M on 09.04.16.
//

import Foundation

struct ShiftVars {
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
    class func shiftForType(_ type: Int) -> ShiftHHElem {
        switch type {
//#if SHIFTS
        case  1: return ShiftHHElem01()
        case  2: return ShiftHHElem02c()
        case  3: return ShiftHHElem03()
        case  4: return ShiftHHElem04c()
        case  5: return ShiftHHElem05()
        case  6: return ShiftHHElem06c()
        case  7: return ShiftHHElem07c()
        case  8: return ShiftHHElem08c()
        case  9: return ShiftHHElem09c()
        case 10: return ShiftHHElem10()
        case 11: return ShiftHHElem11c()
        case 12: return ShiftHHElem12c()
        case 13: return ShiftHHElem13()
        case 14: return ShiftHHElem14c()
        case 15: return ShiftHHElem15c()
        case 16: return ShiftHHElem16c()
        case 17: return ShiftHHElem17c()
        case 18: return ShiftHHElem18c()
        case 19: return ShiftHHElem19c()
        case 20: return ShiftHHElem20c()
        case 21: return ShiftHHElem21()
        case 22: return ShiftHHElem22c()
        case 23: return ShiftHHElem23()
        case 24: return ShiftHHElem24c()
        case 25: return ShiftHHElem25()
        case 26: return ShiftHHElem26c()
        case 27: return ShiftHHElem27()
        case 28: return ShiftHHElem28c()
        case 29: return ShiftHHElem29()
        case 30: return ShiftHHElem30()
        case 31: return ShiftHHElem31()
        case 32: return ShiftHHElem32()
        case 33: return ShiftHHElem33()
        case 34: return ShiftHHElem34()
        case 35: return ShiftHHElem35()
        case 36: return ShiftHHElem36()
//#endif /* SHIFTS */
        default: return ShiftHHElem()
        }
    }

    func oddShift(degree: Int, shift: Int) -> HHElem {
        let hh_shift = justOddShift(degree: degree, shift: shift)
        let V = ShiftVars(shift: shift, degree: degree)
        if shift == PathAlg.twistPeriod {
            hh_shift.twist(shift)
            hh_shift.compKoef(koef29(ell: 1))
        } else {
            hh_shift.compKoef(oddKoef0(s: V.s, ell: V.ell))
        }
        return hh_shift
    }

    func shift(degree: Int, shift: Int) -> HHElem {
        let V = ShiftVars(shift: shift, degree: degree)

        guard oddShift(degree: degree, shift: 0).isZero else {
            let hh_shift: HHElem
            if V.r_0 == 0 {
                hh_shift = HHElem()
                shift0(hh_shift, s:V.s, m: V.m, ell: V.ell)
                hh_shift.compKoef(koef29(ell: V.ell_0))
            } else {
                hh_shift = justOddShift(degree: degree, shift: V.r_0)
                hh_shift.compKoef(koef29(ell: V.ell_0) * oddKoef0(s: V.s, ell: V.ell))
            }
            hh_shift.twist(shift)
            return hh_shift
        }

        let hh_shift = HHElem()
        switch (V.r_0) {
            case 0: shift0(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 1: shift1(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 2: shift2(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 3: shift3(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 4: shift4(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 5: shift5(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 6: shift6(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 7: shift7(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 8: shift8(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 9: shift9(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 10: shift10(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 11: shift11(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 12: shift12(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 13: shift13(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 14: shift14(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 15: shift15(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 16: shift16(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 17: shift17(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 18: shift18(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 19: shift19(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 20: shift20(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 21: shift21(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 22: shift22(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 23: shift23(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 24: shift24(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 25: shift25(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 26: shift26(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 27: shift27(hh_shift, s:V.s, m: V.m, ell: V.ell)
            case 28: shift28(hh_shift, s:V.s, m: V.m, ell: V.ell)
            default: break
        }
        hh_shift.twist(shift)
        hh_shift.compKoef(koef29(ell: V.ell_0))

        return hh_shift
    }

    func justOddShift(degree: Int, shift: Int) -> HHElem {
        let hh_shift = HHElem()
        let V = ShiftVars(shift: shift, degree: degree)

        switch (shift) {
        case 0: oddShift0(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 1: oddShift1(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 2: oddShift2(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 3: oddShift3(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 4: oddShift4(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 5: oddShift5(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 6: oddShift6(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 7: oddShift7(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 8: oddShift8(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 9: oddShift9(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 10: oddShift10(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 11: oddShift11(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 12: oddShift12(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 13: oddShift13(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 14: oddShift14(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 15: oddShift15(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 16: oddShift16(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 17: oddShift17(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 18: oddShift18(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 19: oddShift19(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 20: oddShift20(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 21: oddShift21(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 22: oddShift22(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 23: oddShift23(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 24: oddShift24(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 25: oddShift25(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 26: oddShift26(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 27: oddShift27(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 28: oddShift28(hh_shift, s:V.s, m: V.m, ell: V.ell)
        case 29:
            let V0 = ShiftVars(shift: 0, degree: degree)
            shift0(hh_shift, s:V0.s, m: V0.m, ell: V0.ell)
        default: break
        }
        return hh_shift
    }

    func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift17(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift18(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift19(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift20(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift21(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift22(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift23(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift24(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift25(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift26(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift27(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func shift28(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}

    func koef29(ell: Int) -> Int {
        return 1
    }

    func oddShift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift17(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift18(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift19(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift20(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift21(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift22(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift23(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift24(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift25(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift26(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift27(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}
    func oddShift28(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {}

    func oddKoef0(s: Int, ell: Int) -> Int {
        return 1
    }
}

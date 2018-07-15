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
    let type: Int

    init(type: Int) {
        self.type = type
    }

    class func shiftForType(_ type: Int) -> ShiftHHElem {
        switch type {
        case  1: return ShiftHHElem01()
        case  2: return ShiftHHElem02()
        case  3: return ShiftHHElem03c()
        case  4: return ShiftHHElem04()
        case  5: return ShiftHHElem05c()
        case  6: return ShiftHHElem06()
        case  7: return ShiftHHElem07()
        case  8: return ShiftHHElem08()
        case  9: return ShiftHHElem09c()
        case 10: return ShiftHHElem10c()
        case 11: return ShiftHHElem11()
        case 12: return ShiftHHElem12c()
        case 13: return ShiftHHElem13()
        case 14: return ShiftHHElem14()
        case 16: return ShiftHHElem16c()
        case 17: return ShiftHHElem17c()
        case 18: return ShiftHHElem18()
        case 19: return ShiftHHElem19c()
        case 20: return ShiftHHElem20()
        case 21: return ShiftHHElem21()
        default: return ShiftHHElem(type: 0)
        }
    }

    func oddShift(degree: Int, shift: Int) -> HHElem {
        let hh_shift = HHElem()
        let V = ShiftVars(shift: shift, degree: degree)

        switch (shift) {
        case 0: oddShift0(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 1: oddShift1(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 2: oddShift2(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 3: oddShift3(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 4: oddShift4(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 5: oddShift5(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 6: oddShift6(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 7: oddShift7(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 8: oddShift8(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 9: oddShift9(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 10: oddShift10(hh_shift, degree: degree, shift:shift, n:V.n, s:V.s, m: V.m, ell: V.ell)
        case 11:
            let V0 = ShiftVars(shift: 0, degree: degree)
            shift0(hh_shift, degree: degree, shift:0, n:V0.n, s:V0.s, m: V0.m, ell_0: V0.ell_0, ell: V0.ell)
        default: break
        }
        hh_shift.twist(shift)
        if shift == 11 {
            hh_shift.compKoef(-1 * koef11(s: PathAlg.s, ell: V.ell_0))
        } else {
            hh_shift.compKoef(oddKoef0(degree: degree, n:V.n, s:V.s, m: V.m, ell: V.ell))
        }
        return hh_shift
    }

    func shift(degree: Int, shift: Int) -> HHElem {
        let V = ShiftVars(shift: shift, degree: degree)

        guard oddShift(degree: degree, shift: 0).isZero else {
            let hh_shift: HHElem
            if V.r_0 == 0 {
                hh_shift = HHElem()
                shift0(hh_shift, degree: degree, shift:0, n:V.n, s:V.s, m: V.m, ell_0: 0, ell: V.ell)
            } else {
                hh_shift = oddShift(degree: degree, shift: V.r_0)
            }
            hh_shift.twist(shift)
            hh_shift.compKoef(minusDeg(V.ell_0) * koef11(s: PathAlg.s, ell: V.ell_0))
            return hh_shift
        }

        let hh_shift = HHElem()
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
        hh_shift.compKoef(koef11(s: PathAlg.s, ell: V.ell_0))

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

    func koef11(s: Int, ell: Int) -> Int {
        return 1
    }

    func oddShift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddShift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {
    }

    func oddKoef0(degree: Int, n: Int, s: Int, m: Int, ell: Int) -> Int {
        return 1
    }

    func printLastK(f: (Int, Int) -> Int) {
        defer { print("") }
        let kStr: (Int) -> String = { k in return k < 0 ? "\(k)" : " \(k)" }
        let s = PathAlg.s
        print("S=\(s)")
        for ell in 0 ..< s {
            let x1 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17].map{ PathAlg.sigmaDeg(ell, i: ell + $0, isGamma: true) }
            print("ell=\(ell < 10 ? " " : "")\(ell) \(kStr(f(s, ell))) | " + x1.map(kStr).joined(separator: " | "))
        }

        for x0 in 0 ..< s {
            var isOk = true
            var isOk2 = true
            for ell in 0 ..< s {
                if PathAlg.sigmaDeg(ell, i: ell + x0, isGamma: true) != f(s, ell) { isOk = false }
                if PathAlg.sigmaDeg(ell, i: ell + x0, isGamma: true) * minusDeg(ell) != f(s, ell) { isOk2 = false }
            }
            guard isOk == false else {
                print("k = sigma^ell(ell+\(x0))")
                return
            }
            guard isOk2 == false else {
                print("k = sigma^ell(ell+\(x0)) * (-1)^ell")
                return
            }
        }
        for x0 in 0 ..< s {
            for x1 in 0 ..< s {
                var isOk = true
                var isOk2 = true
                for ell in 0 ..< s {
                    if PathAlg.sigmaDeg(ell, i: ell + x0, isGamma: true) *
                        PathAlg.sigmaDeg(ell, i: ell + x1, isGamma: true) != f(s, ell) { isOk = false }
                    if PathAlg.sigmaDeg(ell, i: ell + x0, isGamma: true) *
                        PathAlg.sigmaDeg(ell, i: ell + x1, isGamma: true) * minusDeg(ell) != f(s, ell) { isOk2 = false }
                }
                guard isOk == false else {
                    print("k = sigma^ell(ell+\(x0)) * sigma^ell(ell+\(x1))")
                    return
                }
                guard isOk2 == false else {
                    print("k = sigma^ell(ell+\(x0)) * sigma^ell(ell+\(x1)) * (-1)^ell")
                    return
                }
            }
        }
        for x0 in 0 ..< s {
            for x1 in 0 ..< s {
                for x2 in 0 ..< s {
                    var isOk = true
                    var isOk2 = true
                    for ell in 0 ..< s {
                        if PathAlg.sigmaDeg(ell, i: ell + x0, isGamma: true) *
                            PathAlg.sigmaDeg(ell, i: ell + x1, isGamma: true) *
                            PathAlg.sigmaDeg(ell, i: ell + x2, isGamma: true) != f(s, ell) { isOk = false }
                        if PathAlg.sigmaDeg(ell, i: ell + x0, isGamma: true) *
                            PathAlg.sigmaDeg(ell, i: ell + x1, isGamma: true) *
                            PathAlg.sigmaDeg(ell, i: ell + x2, isGamma: true) * minusDeg(ell) != f(s, ell) { isOk2 = false }
                    }
                    guard isOk == false else {
                        print("k = sigma^ell(ell+\(x0)) * sigma^ell(ell+\(x1)) * sigma^ell(ell+\(x2))")
                        return
                    }
                    guard isOk2 == false else {
                        print("k = sigma^ell(ell+\(x0)) * sigma^ell(ell+\(x1)) * sigma^ell(ell+\(x2)) * (-1)^ell")
                        return
                    }
                }
            }
        }
    }

    func printK(prefix: String, jFrom: Int, m: Int, ell: Int, f: @escaping (Int) -> Int) {
        printK(prefix: prefix, jFrom: jFrom, jTo: jFrom + PathAlg.s, m: m, ell: ell, f: f)
    }

    func printK(prefix: String, jFrom: Int, jTo: Int, m: Int, ell: Int, f: @escaping (Int) -> Int) {
        //for j in jFrom ..< jTo { print(prefix + " j=\(j), k=\(f(j))") }
        print(prefix)
        let checkF: (String, (Int) -> Int) -> Void = { name, f2 in
            var ch1 = true
            var ch2 = true
            for j in jFrom ..< jTo {
                if f(j) != f2(j) { ch1 = false }
                if f(j) != -f2(j) { ch2 = false }
            }
            if ch1 { print("s=\(PathAlg.s) ell=\(ell) OK: \(name)") }
            if ch2 { print("s=\(PathAlg.s) ell=\(ell) OK: -\(name)") }
        }

        for m0 in -1 ..< PathAlg.s - 1 {
            let mS = m0 == 0 ? "" : (m0 < 0 ? "\(m0)" : "+\(m0)")
            checkF("PathAlg.k1J(ell, j: j, m: m\(mS))", { j in PathAlg.k1J(ell, j: j, m: m+m0) })
            //checkF("PathAlg.kGamma(ell, j: j, m: m\(mS))", { j in PathAlg.kGamma(ell, j: j, m: m+m0) })
            checkF("PathAlg.k1J(ell+1, j: j, m: m\(mS))", { j in PathAlg.k1J(ell+1, j: j, m: m+m0) })
            //checkF("PathAlg.kGamma(ell+1, j: j, m: m\(mS))", { j in PathAlg.kGamma(ell+1, j: j, m: m+m0) })
            /*for m1 in -1 ..< PathAlg.s - 1 {
                let mS1 = m1 == 0 ? "" : (m1 < 0 ? "\(m1)" : "+\(m1)")
                checkF("PathAlg.k1J(ell, j: j, m: m\(mS)) * PathAlg.kGamma(ell, j: j, m: m\(mS1))",
                    { j in PathAlg.k1J(ell, j: j, m: m+m0) * PathAlg.kGamma(ell, j: j, m: m+m1)})
                checkF("PathAlg.k1J(ell, j: j, m: m\(mS)) * PathAlg.kGamma(ell+1, j: j, m: m\(mS1))",
                    { j in PathAlg.k1J(ell, j: j, m: m+m0) * PathAlg.kGamma(ell+1, j: j, m: m+m1)})
                checkF("PathAlg.k1J(ell+1, j: j, m: m\(mS)) * PathAlg.kGamma(ell, j: j, m: m\(mS1))",
                    { j in PathAlg.k1J(ell+1, j: j, m: m+m0) * PathAlg.kGamma(ell, j: j, m: m+m1)})
                checkF("PathAlg.k1J(ell+1, j: j, m: m\(mS)) * PathAlg.kGamma(ell+1, j: j, m: m\(mS1))",
                    { j in PathAlg.k1J(ell+1, j: j, m: m+m0) * PathAlg.kGamma(ell+1, j: j, m: m+m1)})
            }*/
        }
        print("")
    }
}

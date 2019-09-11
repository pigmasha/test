//
//  Created by M on 22.07.2018.
//

import Foundation

struct Step_14_mult {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")

        let type = PathAlg.alg.currentType
        for type1 in 1 ... Dim.typeMax {
            if type > 0 && type1 != type { continue }
            for type2 in type1 ... Dim.typeMax {
                if process(type1: type1, type2: type2) {
                    return true
                }
            }
        }
        return false
    }

    private static func process(type1: Int, type2: Int) -> Bool {
        if type1 == 11 && PathAlg.s == 1 {
            return false
        }
        OutputFile.writeLog(.bold, "Types \(type1) * \(type2)")
        let kk = PathAlg.s == 1 ? 25 : 5
        for deg1 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
            guard Dim.deg(deg1, hasType: type1) else {
                continue
            }
            for deg2 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
                guard Dim.deg(deg2, hasType: type2) else {
                    continue
                }
                let mm = multRes(type1, type2, deg1, deg2)
                if let type = mm?.type, !Dim.deg(deg1 + deg2, hasType: type) {
                    OutputFile.writeLog(.bold, "k=\(type1) * \(type2) has no type \(type) (degs \(deg1) & \(deg2))")
                    return true
                }
                guard process(type1: type1, type2: type2, type: mm?.type ?? 0, deg1: deg1, deg2: deg2, koef: mm?.koef ?? 0) else {
                    continue
                }
                if let mm = mm {
                    let koefs = PathAlg.charK == 2 ? [0, 1] : [0, 1, -1, 3, -3]
                    koefs.forEach { kk in
                        if mm.koef != kk && !process(type1: type1, type2: type2, type: mm.type, deg1: deg1, deg2: deg2, koef: kk) {
                            OutputFile.writeLog(.bold, "k=\(kk) is ok")
                        }
                    }
                } else {
                    for t in 1 ... Dim.typeMax {
                        if Dim.deg(deg1 + deg2, hasType: t) {
                            OutputFile.writeLog(.bold, "k=\(type1) * \(type2) has type \(t)")
                            return true
                        }
                    }
                }
                return true
            }
        }
        return false
    }

    private static func multRes(_ type1: Int, _ type2: Int, _ deg1: Int, _ deg2: Int) -> (type: Int, koef: Int)? {
        let s = PathAlg.s
        let charK = PathAlg.charK
        if type1 == 1 {
            if type2 >= 22 && type2 <= 25 {
                if deg1 == 0 { return (type2, 1) }
                if deg1 > 0 && charK == 2 { return (2, 1) }
                return nil
            }
            if (type2 == 19 || type2 == 20 || type2 == 21) {
                return deg1 == 0 ? (type2, 1) : nil
            }
            return (type2, 1)
        }
        if type1 == 2 {
            switch type2 {
            case 9: return (10, 1)
            case 17: return (18, -1)
            default: return nil
            }
        }
        if type1 == 3 {
            switch type2 {
            case 4: return (5, 1)
            case 8: return (10, 1)
            case 9: return (11, 1)
            case 14: return (15, 1)
            case 16: return (18, 1)
            case 17: return (2, 3)
            default: return nil
            }
        }
        if type1 == 4 {
            switch type2 {
            case 4: return charK == 3 ? (7, -s) : nil
            case 6: return (10, -s)
            case 9: return charK == 3 ? (13, -s) : nil
            case 12: return (15, -s)
            case 14: return (16, 1)
            case 15: return (18, 1)
            default: return nil
            }
        }
        if type1 == 5 {
            return type2 == 14 ? (18, 1) : nil
        }
        if type1 == 6 {
            switch type2 {
            case 9: return (15, s)
            case 13: return (18, -1)
            case 14: return (2, -s)
            case 17: return (5, s)
            default: return nil
            }
        }
        if type1 == 7 {
            return type2 == 12 ? (18, 1) : nil
        }
        if type1 == 8 {
            switch type2 {
            case 9: return (16, -1)
            case 11: return (18, -1)
            case 12: return (2, -s)
            case 17: return charK == 3 ? (7, s) : nil
            default: return nil
            }
        }
        if type1 == 9 {
            switch type2 {
            case 9: return (17, 1)
            case 10: return (18, -1)
            case 11: return (2, 3)
            case 12: return (3, -s)
            case 14: return (4, 1)
            case 15: return (5, 1)
            case 16: return charK == 3 ? (7, -s) : nil
            case 17: return (8, 3)
            case 22, 23, 24, 25: return charK == 2 ? (10, 1) : nil
            default: return nil
            }
        }
        if type1 == 11 {
            switch type2 {
            case 14: return (5, 1)
            case 17: return (10, 3)
            default: return nil
            }
        }
        if type1 == 12 {
            switch type2 {
            case 13: return (5, 1)
            case 14: return (6, -1)
            case 16: return (10, s)
            case 17: return (11, -s)
            default: return nil
            }
        }
        if type1 == 13 {
            return type2 == 14 ? (7, 1) : nil
        }
        if type1 == 14 {
            switch type2 {
            case 14: return (8, -1)
            case 15: return (10, -1)
            case 17: return charK == 3 ? (13, -s) : nil
            default: return nil
            }
        }
        if type1 == 17 {
            switch type2 {
            case 17: return (16, -3)
            case 22, 23, 24, 25: return charK == 2 ? (18, 1) : nil
            default: return nil
            }
        }
        return nil
    }

    private static func process(type1: Int, type2: Int, type: Int, deg1: Int, deg2: Int, koef: Int) -> Bool {
        guard type == 0 || Dim.deg(deg1 + deg2, hasType: type) else {
            OutputFile.writeLog(.error, "\(deg1) + \(deg2) not type \(type)")
            return true
        }
        let multRes = Matrix(mult: HHElem(deg: deg2, type: type2),
                             and: ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))

        if koef != 0 {
            let hh = HHElem(deg: deg1 + deg2, type: type)
            hh.compKoef(-koef)
            multRes.addMatrix(hh)
        }

        let r = CheckHH.checkForIm(multRes, degree: deg1 + deg2, shouldBeInIm: true, logError: false)
        switch r {
        case .inIm:
            OutputFile.writeLog(.normal, "\(deg1) * \(deg2) OK")
        case .notInIm:
            //PrintUtils.printMatrix("hh", HHElem(deg: deg2, type: type2))
            //PrintUtils.printMatrix("shift", ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))
            //PrintUtils.printMatrix("multRes", multRes)
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) not in im (koef=\(koef))")
        case .failed:
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) failed")
        }
        return r != .inIm
    }
}

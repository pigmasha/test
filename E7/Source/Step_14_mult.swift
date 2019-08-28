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
        OutputFile.writeLog(.bold, "Types \(type1) * \(type2)")
        let kk = PathAlg.s == 1 ? 25 : 5
        for deg1 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg1, hasType: type1) {
                for deg2 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
                    if Dim.deg(deg2, hasType: type2) {
                        let type = typeMult(type1, type2, deg1, deg2)
                        if type == 0 && PathAlg.s > 1 {
                            for t in 1 ... Dim.typeMax {
                                if Dim.deg(deg1 + deg2, hasType: t) {
                                    OutputFile.writeLog(.bold, "k=\(type1) * \(type2) has type \(t)")
                                    return true
                                }
                            }
                        } else {
                            if !Dim.deg(deg1 + deg2, hasType: type) {
                                OutputFile.writeLog(.bold, "k=\(type1) * \(type2) has no type \(type)")
                                return true
                            }
                            let k = type == 0 ? 0 : koef(type1, type2, deg1, deg2)
                            if process(type1: type1, type2: type2, type: type, deg1: deg1, deg2: deg2, koef: k) {
                                [0, 1, -1, 3, -3].forEach { kk in
                                    if k != kk && !process(type1: type1, type2: type2, type: type, deg1: deg1, deg2: deg2, koef: kk) {
                                        OutputFile.writeLog(.bold, "k=\(kk) is ok")
                                    }
                                }
                                return true
                            }
                        }
                    }
                }
            }
        }
        return false
    }

    private static func typeMult(_ type1: Int, _ type2: Int, _ deg1: Int, _ deg2: Int) -> Int {
        let s = PathAlg.s
        let charK = PathAlg.charK
        switch (type1, type2) {
        case (1,_): return type2
        case (2, 2): return s <= 2 ? 1 : 0
        case (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8): return s == 1 && charK == 2 ? type2 : 0
        case (2, 9): return 10
        case (2, 10): return s <= 2 ? 9 : 0
        case (2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16): return s == 1 && charK == 2 ? type2 : 0
        case (2, 17): return 18
        case (2, 18): return s <= 2 ? 17 : 0
        case (3, 4): return 5
        case (3, 6): return 7
        case (3, 8): return 10
        case (3, 9): return 11
        case (3, 10): return s == 1 && charK == 2 ? 11 : 0
        case (3, 12): return 13
        case (3, 14): return 15
        case (3, 16): return 18
        case (3, 17): return 2
        case (3, 18): return s <= 2 ? 1 : 0
        case (4, 4): return charK == 3 ? 7 : 0
        case (4, 5): return s == 1 && charK == 2 ? 8 : 0
        case (4, 6): return 10
        case (4, 7): return s == 1 && charK == 2 ? 11 : 0
        case (4, 9): return charK == 3 ? 13 : 0
        case (4, 11): return s == 1 && charK == 2 ? 14 : 0
        case (4, 12): return 15
        case (4, 14): return 16
        case (4, 15): return 18
        case (4, 16): return s == 1 && charK == 2 ? 3 : 0
        case (5, 5): return s <= 2 ? 9 : 0
        case (5, 7): return s <= 2 ? 12 : 0
        case (5, 9): return s == 1 && charK == 2 ? 14 : 0
        case (5, 10): return s <= 2 ? 14 : 0
        case (5, 11): return s == 1 && charK == 2 ? 15 : 0
        case (5, 14): return 18
        case (5, 15): return s <= 2 ? 1 : 0
        case (5, 17): return s == 1 && charK == 2 ? 4 : 0
        case (5, 18): return s <= 2 ? 4 : 0
        case (6, 9): return 15
        case (6, 12): return 16
        case (6, 13): return 18
        case (6, 14): return 2
        case (6, 17): return 5
        case (7, 7): return s <= 2 ? 14 : 0
        case (7, 12): return 18
        case (7, 13): return s <= 2 ? 1 : 0
        case (7, 18): return s <= 2 ? 6 : 0
        case (8, 9): return 16
        case (8, 10): return s == 1 && charK == 2 ? 16 : 0
        case (8, 11): return 18
        case (8, 12): return 2
        case (8, 15): return s == 1 && charK == 2 ? 3 : 0
        case (8, 16): return s == 1 && charK == 2 ? 6 : 0
        case (8, 17): return charK == 3 ? 7 : 0
        case (8, 18): return s == 1 && charK == 2 ? 7 : 0
        case (9, 9): return 17
        case (9, 10): return 18
        case (9, 11): return 2
        case (9, 12): return 3
        case (9, 14): return 4
        case (9, 15): return 5
        case (9, 16): return charK == 3 ? 7 : 0
        case (9, 17): return 8
        case (9, 18): return s == 1 && charK == 2 ? 8 : 0
        case (10, 10): return s <= 2 ? 17 : 0
        case (10, 11): return s <= 2 ? 1 : 0
        case (10, 18): return s <= 2 ? 8 : 0
        case (11, 11): return s == 1 && charK == 2 ? 3 : 0
        case (11, 14): return 5
        case (11, 16): return s == 1 && charK == 2 ? 8 : 0
        case (11, 17): return 10
        case (11, 18): return s <= 2 ? 9 : 0
        case (12, 12): return 4
        case (12, 13): return 5
        case (12, 14): return 6
        case (12, 15): return 7
        case (12, 16): return 10
        case (12, 17): return 11
        case (13, 14): return 7
        case (13, 18): return s <= 2 ? 12 : 0
        case (14, 14): return 8
        case (14, 15): return 10
        case (14, 17): return charK == 3 ? 13 : 0
        case (15, 15): return s == 1 && charK == 2 ? 11 : 0
        case (15, 17): return s == 1 && charK == 2 ? 14 : 0
        case (15, 18): return s <= 2 ? 14 : 0
        case (16, 16): return s == 1 && charK == 2 ? 15 : 0
        case (17, 17): return 16
        case (17, 18): return s == 1 && charK == 2 ? 16 : 0
        case (18, 18): return s <= 2 ? 16 : 0
        default: return 0
        }
    }

    private static func koef(_ type1: Int, _ type2: Int, _ deg1: Int, _ deg2: Int) -> Int {
        switch (type1, type2) {
        case (2,2), (2,10), (2,18), (3, 6), (3, 12), (3, 18), (5, 5), (5, 7), (5, 10), (5, 15), (5, 18),
             (6, 12), (7, 7), (7, 13), (7, 18), (10, 10), (10, 11), (10, 18), (11, 18),
             (12, 12), (12, 15), (13, 18), (15, 18), (18, 18): return 0
        case (2, 17), (6, 13), (8, 9), (8, 11), (9, 10), (12, 14), (14, 14), (14, 15): return -1
        case (3, 17), (9, 11), (9, 17), (11, 17): return 3
        case (17, 17): return -3
        case (4, 4), (4, 6), (4, 9), (4, 12), (6, 14), (8, 12), (9, 12), (9, 16),
             (12, 17), (14, 17): return -PathAlg.s
        case (6, 9), (6, 17), (12, 16), (8, 17): return PathAlg.s
        default: return 1
        }
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
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) not in im")
        case .failed:
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) failed")
        }
        return r != .inIm
    }
}

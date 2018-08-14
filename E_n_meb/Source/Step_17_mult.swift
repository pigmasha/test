//
//  Created by M on 22.07.2018.
//

import Foundation

struct Step_17_mult {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")

        for type1 in 1 ... 22 {
            for type2 in type1 ... 22 {
                if process(type1: type1, type2: type2, type: typeMult(type1: type1, type2: type2)) {
                    return true
                }
            }
        }
        return false
    }

    private static func process(type1: Int, type2: Int, type: Int) -> Bool {
        OutputFile.writeLog(.bold, "Types \(type1) * \(type2)")
        for deg1 in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg1, hasType: type1) {
                for deg2 in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
                    if Dim.deg(deg2, hasType: type2) {
                        if type == 0 {
                            for t in 1 ... 22 {
                                if Dim.deg(deg1 + deg2, hasType: t) { return true }
                            }
                        } else {
                            let k = koef(type1: type1, type2: type2, deg1: deg1, deg2: deg2)
                            if process(type1: type1, type2: type2, type: type, deg1: deg1, deg2: deg2, koef: k) {
                                return true
                            }
                        }
                    }
                }
            }
        }
        return false
    }

    private static func typeMult(type1: Int, type2: Int) -> Int {
        switch (type1, type2) {
        case (1,_): return type2
        case (2,9): return 10
        case (2,15): return 14
        case (2,22): return 21
        case (3,4): return 5
        case (3,6): return 10
        case (3,7): return 8
        case (3,9): return 12
        case (3,11): return 14
        case (3,13): return 16
        case (3,15): return 17
        case (3,18): return 19
        case (3,20): return 21
        case (3,22): return 2
        case (4,6): return PathAlg.charK == 2 ? 8 : 0
        case (4,7): return 10
        case (4,9): return 11
        case (4,12): return 14
        case (4,13): return 17
        case (4,15): return PathAlg.charK == 2 ? 16 : 0
        case (4,18): return 20
        case (4,19): return 21
        case (5,9): return 14
        case (5,18): return 21
        case (6,6): return PathAlg.charK == 3 ? 14 : 0
        case (6,9): return 17
        case (6,13): return 19
        case (6,15): return 20
        case (6,17): return 21
        case (6,18): return PathAlg.charK == 3 ? 2 : 0
        case (6,22): return 5
        case (7,13): return 20
        case (7,15): return 19
        case (7,16): return 21
        case (9,9): return 18
        case (9,11): return 20
        case (9,12): return 19
        case (9,15): return 22
        case (9,14): return 21
        case (9,17): return 2
        case (9,18): return 3
        case (9,20): return 5
        case (9,22): return 6
        case (10,15): return 21
        case (8,13): return 21
        case (11,12): return 21
        case (11,18): return 5
        case (12,15): return 2
        case (12,22): return 10
        case (13,13): return 4
        case (13,15): return 3
        case (13,16): return 5
        case (13,18): return 7
        case (13,19): return 8
        case (13,20): return 10
        case (15,15): return 4
        case (15,17): return 5
        case (15,18): return 6
        case (15,19): return 10
        case (15,20): return PathAlg.charK == 2 ? 8 : 0
        case (15,22): return 11
        case (16,18): return 8
        case (17,18): return 10
        case (17,22): return 14
        case (18,18): return PathAlg.charK == 3 ? 12 : 0
        case (18,20): return PathAlg.charK == 3 ? 14 : 0
        case (18,22): return 17
        case (22,22): return 20
        default: return 0
        }
    }

    private static func koef(type1: Int, type2: Int, deg1: Int, deg2: Int) -> Int {
        switch (type1, type2) {
        case (6,6), (6,18), (18,22): return -PathAlg.s
        case (6,9), (6,22), (9,18), (9,20), (11,18), (18,18), (18,20): return PathAlg.s
        case (2,9), (2,22), (4,7), (6,15), (6,17), (9,15), (10,15), (12,15), (12,22), (15,15), (15,17): return -1
        case (3,7), (3,9), (3,11), (3,13), (3,22), (5,9), (7,13), (9,9), (9,11), (9,17),
             (9,22), (13,13), (13,19), (17,22), (22,22): return 0
        default: return 1
        }
    }

    private static func process(type1: Int, type2: Int, type: Int, deg1: Int, deg2: Int, koef: Int) -> Bool {
        guard Dim.deg(deg1 + deg2, hasType: type) else {
            OutputFile.writeLog(.error, "\(deg1) + \(deg2) not type \(type)")
            return true
        }
        let multRes = Matrix(mult: HHElem(deg: deg2, type: type2),
                             and: ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))

        let hh = HHElem(deg: deg1 + deg2, type: type)
        hh.compKoef(-koef)
        multRes.addMatrix(hh)

        let r = CheckHH.checkForIm(multRes, degree: deg1 + deg2, shouldBeInIm: true, logError: true)
        switch r {
        case .inIm:
            OutputFile.writeLog(.normal, "\(deg1) * \(deg2) OK")
        case .notInIm:
            PrintUtils.printMatrix("hh", HHElem(deg: deg2, type: type2))
            PrintUtils.printMatrix("shift", ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))
            PrintUtils.printMatrix("multRes", multRes)
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) not in im")
        case .failed:
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) failed")
        }
        return r != .inIm
    }
}

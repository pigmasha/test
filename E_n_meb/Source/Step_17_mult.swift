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
        case (2,8): return 9
        case (2,14): return 15
        case (2,21): return 22
        case (3,4): return 5
        case (3,6): return 9
        case (3,7): return 10
        case (3,8): return 12
        case (3,11): return 15
        case (3,13): return 16
        case (3,14): return 17
        case (3,18): return 19
        case (3,20): return 22
        case (3,21): return 2
        case (4,6): return PathAlg.charK == 2 ? 10 : 0
        case (4,7): return 9
        case (4,8): return 11
        case (4,12): return 15
        case (4,13): return 17
        case (4,14): return PathAlg.charK == 2 ? 16 : 0
        case (4,18): return 20
        case (4,19): return 22
        case (5,8): return 15
        case (5,18): return 22
        case (6,6): return PathAlg.charK == 3 ? 15 : 0
        case (6,8): return 17
        case (6,13): return 19
        case (6,14): return 20
        case (6,17): return 22
        case (6,18): return PathAlg.charK == 3 ? 2 : 0
        case (6,21): return 5
        case (7,13): return 20
        case (7,14): return 19
        case (7,16): return 22
        case (8,8): return 18
        case (8,11): return 20
        case (8,12): return 19
        case (8,14): return 21
        case (8,15): return 22
        case (8,17): return 2
        case (8,18): return 3
        case (8,20): return 5
        case (8,21): return 6
        case (9,14): return 22
        case (10,13): return 22
        case (11,12): return 22
        case (11,18): return 5
        case (12,14): return 2
        case (12,21): return 9
        case (13,13): return 4
        case (13,14): return 3
        case (13,16): return 5
        case (13,18): return 7
        case (13,19): return 10
        case (13,20): return 9
        case (14,14): return 4
        case (14,17): return 5
        case (14,18): return 6
        case (14,19): return 9
        case (14,20): return PathAlg.charK == 2 ? 10 : 0
        case (14,21): return 11
        case (16,18): return 10
        case (17,18): return 9
        case (17,21): return 15
        case (18,18): return PathAlg.charK == 3 ? 12 : 0
        case (18,20): return PathAlg.charK == 3 ? 15 : 0
        case (18,21): return 17
        case (21,21): return 20
        default: return 0
        }
    }

    private static func koef(type1: Int, type2: Int, deg1: Int, deg2: Int) -> Int {
        switch (type1, type2) {
        case (6,6), (6,18), (18,21): return -PathAlg.s
        case (6,8), (6,21), (8,18), (8,20), (11,18), (18,18), (18,20): return PathAlg.s
        case (2,8), (2,21), (4,7), (6,14), (6,17), (8,14), (9,14), (12,14), (12,21), (14,14), (14,17): return -1
        case (3,7), (3,8), (3,11), (3,13), (3,21), (5,8), (7,13), (8,8), (8,11), (8,17),
             (8,21), (13,13), (13,19), (17,21), (21,21): return 0
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

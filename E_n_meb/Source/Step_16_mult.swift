//
//  Created by M on 20.05.2018.
//

import Foundation

struct Step_16_mult {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")

        let type1 = 18
        let type2 = 5
        let typeRes = 22
        OutputFile.writeLog(.bold, "Types \(type1) * \(type2)")
        for deg1 in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg1, hasType: type1) {
                for deg2 in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
                    if Dim.deg(deg2, hasType: type2) {
                        let ell = deg1 / PathAlg.twistPeriod
                        let k = PathAlg.k1J(ell, j:0, m:5)
                        if processCommutative(type1: type1, type2: type2, deg1: deg1, deg2: deg2) {
                            return true
                        }
                        if process(type1: type1, type2: type2, type: typeRes, deg1: deg1, deg2: deg2, koef: k) {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }

    private static func process(type1: Int, type2: Int, type: Int, deg1: Int, deg2: Int, koef: Int) -> Bool {
        guard Dim.deg(deg1 + deg2, hasType: type) else {
            OutputFile.writeLog(.error, "\(deg1) + \(deg2) not type \(type)")
            return true
        }
        let multRes = Matrix(mult: HHElem(deg: deg2, type: type2),
                             and: ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))
        let multRes2 = Matrix(mult: HHElem(deg: deg1, type: type1),
                              and: ShiftHHElem.shiftForType(type2).shift(degree: deg2, shift: deg1))
        let hh = HHElem(deg: deg1 + deg2, type: type)
        hh.compKoef(-koef)
        multRes.addMatrix(hh)
        multRes2.addMatrix(hh)

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
        if r == .inIm {
            let r2 = CheckHH.checkForIm(multRes2, degree: deg1 + deg2, shouldBeInIm: true, logError: true)
            if r2 != .inIm {
                OutputFile.writeLog(.error, "\(deg1) * \(deg2) not commutative")
                return true
            }
        }
        return r != .inIm
    }

    private static func processCommutative(type1: Int, type2: Int, deg1: Int, deg2: Int) -> Bool {
        let multRes = Matrix(mult: HHElem(deg: deg2, type: type2),
                             and: ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))
        let multRes2 = Matrix(mult: HHElem(deg: deg1, type: type1),
                              and: ShiftHHElem.shiftForType(type2).shift(degree: deg2, shift: deg1))
        multRes.subtractMatrix(multRes2)
        let r2 = CheckHH.checkForIm(multRes, degree: deg1 + deg2, shouldBeInIm: true, logError: false)
        if r2 != .inIm {
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) not commutative")
            PrintUtils.printMatrix("multRes", multRes)
            PrintUtils.printMatrix("multRes2", multRes2)
        } else {
            OutputFile.writeLog(.normal, "\(deg1) * \(deg2) commutative")
        }
        return r2 != .inIm
    }
}

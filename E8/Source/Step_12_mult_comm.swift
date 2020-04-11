//
//  Created by M on 20.05.2018.
//

import Foundation

struct Step_12_mult_comm {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        for type in 1 ... Dim.typeMax2 {
            if processCommutativeType(type) {
                return true
            }
        }
        return false
    }

    private static func processCommutativeType(_ type: Int) -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")

        let kk = PathAlg.s == 1 ? 25 : 5
        for deg1 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
            guard Dim.deg(deg1, hasType: type) else { continue }

            for type2 in 1 ... Dim.typeMax2 {
                for deg2 in 1...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
                    guard Dim.deg(deg2, hasType: type2) else { continue }
                    var tt = false
                    for type3 in 1 ... Dim.typeMax2 {
                        if Dim.deg(deg1 + deg2, hasType: type3) { tt = true }
                    }
                    guard tt else { continue }
                    if processCommutative(type1: type, type2: type2, deg1: deg1, deg2: deg2) {
                        return true
                    }
                }
            }
        }
        return false
    }

    private static func processCommutative(type1: Int, type2: Int, deg1: Int, deg2: Int) -> Bool {
        let multRes = Matrix(mult: HHElem(deg: deg2, type: type2),
                             and: ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))
        let multRes2 = Matrix(mult: HHElem(deg: deg1, type: type1),
                              and: ShiftHHElem.shiftForType(type2).shift(degree: deg2, shift: deg1))
        multRes.subtractMatrix(multRes2)
        let r2 = CheckHH.checkForIm(multRes, degree: deg1 + deg2, shouldBeInIm: true, logError: false)
        let ss = "\(deg1) * \(deg2) (types \(type1) * \(type2))"
        if r2 != .inIm {
            OutputFile.writeLog(.error, "\(ss) not commutative")
            PrintUtils.printMatrix("multRes", multRes)
            PrintUtils.printMatrix("multRes2", multRes2)
        } else {
            OutputFile.writeLog(.normal, "\(ss) commutative")
        }
        return r2 != .inIm
    }
}

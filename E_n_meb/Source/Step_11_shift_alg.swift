//
//  Created by M on 15.10.17.
//
//

import Foundation

struct Step_11_shift_alg {
    static func runCase() -> Bool {
        let kCurrentType = 5

        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let type = kCurrentType
        if (process(type: type)) { return true }
        return false
    }

    private static func process(type: Int) -> Bool {
        for deg in 1...30 * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) { return true }
                return false
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool {
        let ell = deg / PathAlg.twistPeriod

        var hh = HHElem(deg: deg, type: type)
        PrintUtils.printMatrixKoefs(hh)
        OutputFile.writeLog(.time, "HH (ell=%d, type=%d)", ell, type)

        for shift in 1...3 * PathAlg.twistPeriod + 2 {
            let shiftHH = HHElem()
            let res = ShiftHHAlg.shiftHHElem(hh, type: type, degree: deg, shift: shift, result: shiftHH)
            PrintUtils.printMatrixKoefs(shiftHH)
            if res != 0 {
                OutputFile.writeLog(.error, "Differents \(res)")
                return true
            } else {
                hh = shiftHH
            }
        }
        return false
    }
}

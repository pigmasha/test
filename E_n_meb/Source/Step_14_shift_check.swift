//
//  Created by M on 07.06.17.
//
//

import Foundation

struct Step_14_shift_check {
    static func runCase() -> Bool {
        let kCurrentType = 6
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let type = kCurrentType
        for deg in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (type == kCurrentType && process(type: type, deg: deg)) { return true }
                //if (type == kCurrentType && processCheck(type: type, deg: deg)) { return true }
                //return false
            }
        }
        return false
    }

    private static func processCheck(type: Int, deg: Int) -> Bool {
        let ell = Int(deg / PathAlg.twistPeriod)
        OutputFile.writeLog(.time, "N=\(PathAlg.n), S=\(PathAlg.s), ell=\(ell)")
        for shift in 1 ... 2 * PathAlg.s * PathAlg.twistPeriod + 1 {
            //guard (shift % PathAlg.twistPeriod) == PathAlg.alg.dummy1 else { continue }
            let hh = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift - 1)
            let hh_shift = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift)
            if !ShiftCheck.checkHH(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                PrintUtils.printMatrix("My HH, shift \(shift) (\(shift % PathAlg.twistPeriod))", hh_shift)
                let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                PrintUtils.printMatrix("Right HH", ShiftHHAlgAll.select(from: allVariants!, type: type, shift: shift)!)
                return true
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool {
        var hh = HHElem(deg: deg, type: type)

        for shift in 1 ... /*3 **/ PathAlg.s * PathAlg.twistPeriod + 1 {
            OutputFile.writeLog(.time, "Shift \(shift)")
            let hh_shift = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift)
            if !ShiftCheck.checkHH(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                return true
            }
            hh = hh_shift
        }
        return false
    }
}

//
//  Created by M on 07.06.17.
//
//

import Foundation

struct Step_14_shift_check {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let type = RunCase.kCurrentType
        for deg in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) { return true }
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool {
        let startShift = PathAlg.alg.dummy1
        let ell = deg / PathAlg.twistPeriod

        var shifts: [Int] = []
        if startShift > 0 {
            var x = startShift
            while x > 0 {
                shifts = [x] + shifts
                x -= PathAlg.twistPeriod
            }
        } else {
            for i in 1 ... PathAlg.s * PathAlg.twistPeriod + 1 { shifts += [i] }
        }

        OutputFile.writeLog(.time, "HH (type=\(type), ell=\(ell))")
        for shift in shifts {
            let hh = shift > 1 ? ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift - 1) : HHElem(deg: deg, type: type)
            OutputFile.writeLog(.time, "Shift \(shift) (\(shift % PathAlg.twistPeriod))")
            let hh_shift = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift)
            if !ShiftCheck.checkHH(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                //let allVariants = ShiftAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                //PrintUtils.printMatrix("Right HH", ShiftAllSelect.select(from: allVariants!, type: type, shift: shift))
                //let _ = allVariants!.writeToFile(pathWithShift(shift))
                return true
            }
        }
        return false
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).txt"
    }
}

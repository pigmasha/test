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
        var hh = HHElem(deg: deg, type: type)
        let startShift = PathAlg.alg.dummy1 > 2 ? PathAlg.alg.dummy1 - 1 : 1
        if startShift > 1 {
            hh = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: startShift - 1)
            OutputFile.writeLog(.time, "HH Shift \(startShift) (type=\(type))")
            //PrintUtils.printMatrix("HH Shift \(startShift) (type=\(type))", hh)
        } else {
            OutputFile.writeLog(.time, "HH Shift (type=\(type))")
            //PrintUtils.printMatrix("HH (type=\(type))", hh)
        }

        for shift in startShift ... 2 {// * PathAlg.s * PathAlg.twistPeriod + 1 {
            OutputFile.writeLog(.time, "Shift \(shift) (\(shift % PathAlg.twistPeriod))")
            let hh_shift = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift)
            if !ShiftCheck.checkHH(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                let allVariants = ShiftAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                PrintUtils.printMatrix("Right HH", ShiftAllSelect.select(from: allVariants!, type: type, shift: shift))
                let _ = allVariants!.writeToFile(pathWithShift(shift))
                return true
            }
            hh = hh_shift
        }
        return false
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).txt"
    }
}

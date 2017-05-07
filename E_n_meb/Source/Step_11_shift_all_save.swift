//
//  Created by M on 22.01.17.
//

import Foundation

struct Step_11_shift_all_save
{
    static func runCase() -> Bool
    {
        let kCurrentType = 4

        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let type = kCurrentType
        if (process(type: type)) {
            return true
        }
        return false
    }

    private static func process(type: Int) -> Bool
    {
        for deg in 1...30 * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) {
                    return true
                }
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool
    {
        let ell = deg / PathAlg.twistPeriod

        var hh = HHElem(deg: deg, type: type)
        OutputFile.writeLog(.time, "HH (ell=%d, type=%d)", ell, type)
        printMatrix(hh)

        for shift in 0...PathAlg.twistPeriod + 1 {
            if (shift == 0) { continue }
            guard let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift) else {
                OutputFile.writeLog(.bold, "HH ShiftAll failed! Shift=%zd", shift)
                return true
            }
            let path = OutputFile.fileName! + "_allVariants.txt"
            guard allVariants.writeToFile(path) else {
                OutputFile.writeLog(.bold, "allVariants writeToFile failed, path=\(path)", shift)
                return true
            }
            guard let savedVariants = ShiftAllVariants(withContentsOf: path) else {
                OutputFile.writeLog(.bold, "Failed to read allVariants, path=\(path)", shift)
                return true
            }
            guard allVariants.isEq(to: savedVariants) else {
                OutputFile.writeLog(.bold, "Variants not equal")
                return true
            }
            guard let hhShift = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift) else {
                OutputFile.writeLog(.bold, "HH ShiftAll error %d", shift)
                return true
            }
            guard ShiftHHAlg.checkHHMatrix(hh, hhShift: hhShift, degree: deg, shift: shift) else {
                OutputFile.writeLog(.error, "Shift %zd (%zd) checkHHMatrix failed!", shift, shift % PathAlg.twistPeriod)
                let nDifferences = ShiftHHAlg.shiftHHElem(hh, type: type, degree: deg, shift: shift, result: hhShift)
                OutputFile.writeLog(.error, "Differences count = %d", nDifferences)
                return true
            }
            hh = HHElem(matrix: hhShift)
        }
        return false
    }
}

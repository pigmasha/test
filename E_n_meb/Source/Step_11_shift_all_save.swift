//
//  Created by M on 22.01.17.
//

import Foundation

struct Step_11_shift_all_save
{
    static func runCase() -> Bool
    {
        let kCurrentType = 4

        OutputFile.writeLog(2, "N=%d, S=%d, Char=%d (types %d)",  PathAlg.alg.n, PathAlg.alg.s, PathAlg.alg.charK, 22)

        let type = kCurrentType
        if (process(type: type)) {
            return true
        }
        return false
    }

    private static func process(type: Int) -> Bool
    {
        for deg in 1...30 * PathAlg.alg.twistPeriod + 2 {
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
        let ell = deg / PathAlg.alg.twistPeriod

        var hh = HHElem(deg: deg, type: type)
        OutputFile.writeLog(5, "HH (ell=%d, type=%d)", ell, type)

        var seqNumber = [0 as NSNumber]
        for shift in 0...PathAlg.alg.twistPeriod + 1 {
            if (shift == 0) {
                printMatrix(hh)
                continue
            }
            guard let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift, seqNumber: seqNumber) else {
                OutputFile.writeLog(2, "HH ShiftAll failed! Shift=%zd", shift)
                return true
            }
            let path = OutputFile.fileName! + "_allVariants.txt"
            guard allVariants.writeToFile(path) else {
                OutputFile.writeLog(2, "allVariants writeToFile failed, path=\(path)", shift)
                return true
            }
            guard let savedVariants = ShiftAllVariants(withContentsOf: path) else {
                OutputFile.writeLog(2, "Failed to read allVariants, path=\(path)", shift)
                return true
            }
            guard allVariants.isEq(to: savedVariants) else {
                OutputFile.writeLog(2, "Variants not equal")
                return true
            }
            guard let hhShift = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift) else {
                OutputFile.writeLog(2, "HH ShiftAll error %d", shift)
                return true
            }
            guard ShiftHHAlg.checkHHMatrix(hh, hhShift: hhShift, degree: deg, shift: shift) else {
                OutputFile.writeLog(1, "Shift %zd (%zd) checkHHMatrix failed!", shift, shift % PathAlg.alg.twistPeriod)
                let nDifferences = ShiftHHAlg.shiftHHElem(hh, type: type, degree: deg, shift: shift, result: hhShift)
                OutputFile.writeLog(1, "Differences count = %d", nDifferences)
                return true
            }
            hh = HHElem(matrix: hhShift)
            seqNumber += [ shift as NSNumber ]
        }
        return false
    }
}

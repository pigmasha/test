//
//  Created by M on 22.01.17.
//

import Foundation

struct RunCase_11_shift_all_save
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

        for shift in 0 ... 13 * PathAlg.alg.twistPeriod + 1 {
            if (shift == 0) {
                printMatrix(hh);
                continue;
            }
            let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
            let hh_shift = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift)
            if (hh_shift != nil) {
                OutputFile.writeLog(5, "HH Shift %d", shift);
                printMatrix(hh_shift);
            } else {
                OutputFile.writeLog(2, "HH ShiftAll error %d", shift);
                printMatrix(hh_shift);

                let nDifferences = ShiftHHAlg.shiftHHElem(hh, type: type, degree: deg, shift: shift, result: hh_shift)

                OutputFile.writeLog(2, "HH Shift %d", shift);
                printMatrix(hh_shift);

                if (nDifferences != 0) {
                    OutputFile.writeLog(1, "Differences count = %d", nDifferences);
                    return true
                }
                return true
            }
            if !ShiftHHAlg.checkHHMatrix(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                OutputFile.writeLog(1, "Shift %zd (%zd) checkHHMatrix failed!", shift, shift % PathAlg.alg.twistPeriod);
                return true
            }
            hh = HHElem(matrix: hh_shift!)
        }
        return false
    }
}

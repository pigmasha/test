//
//  Created by M on 22.01.17.
//

import Foundation

struct RunCase_19_shift_all_save
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
        for deg in 1...30 * PathAlg.alg.twistPeriod + 2
        {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) {
                    return true
                }
                return false
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool
    {
        let kTypeWithProof = 3
        let ell = deg / PathAlg.alg.twistPeriod

        var hh = HHElem(deg: deg, type: type)
        OutputFile.writeLog(5, "HH (ell=%d, type=%d)", ell, type)

        let shiftMax = 13*PathAlg.alg.twistPeriod + 1
        for shift in 0...shiftMax {
            var hh_shift: HHElem? = nil
            if (type > kTypeWithProof) {
                if (shift == 0) {
                    printMatrix(hh);
                    continue;
                }

                let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                hh_shift = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift)
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
            } else {
                let sh = ShiftHHElem.shiftForType(type)
                hh_shift = HHElem()
                sh?.shift(hh_shift!, degree: deg, shift: shift)
                //OutputFile.writeLog(2, "Shift %zd", shift);
                //printMatrix(hh_shift);
            }
            if !ShiftHHAlg.checkHHMatrix(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                OutputFile.writeLog(1, "Shift %zd (%zd) checkHHMatrix failed!", shift, shift % PathAlg.alg.twistPeriod);

                if (type <= kTypeWithProof) {
                    OutputFile.writeLog(2, "Wrong HH Shift");
                    printMatrix(hh_shift);

                    OutputFile.writeLog(2, "Right HH Shift");
                    let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                    hh_shift = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift)

                    //[ShiftHHGenProgram printProgram:hh_shift shift:shift];
                }
                return true
            }
            hh = HHElem(matrix: hh_shift!)
        }
        return false
    }
}

//
//  Created by M on 22.01.17.
//

import Foundation

struct Step_19_shift_all_save
{
    static func runCase() -> Bool
    {
        let kCurrentType = 4

        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d (types %d)",  PathAlg.n, PathAlg.s, PathAlg.charK, 22)

        let type = kCurrentType
        if (process(type: type)) {
            return true
        }
        return false
    }

    private static func process(type: Int) -> Bool
    {
        for deg in 1...30 * PathAlg.twistPeriod + 2
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
        /*let kTypeWithProof = 3
        let ell = deg / PathAlg.twistPeriod

        var hh = HHElem(deg: deg, type: type)
        OutputFile.writeLog(.time, "HH (ell=%d, type=%d)", ell, type)

        let shiftMax = 13*PathAlg.twistPeriod + 1
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
                    OutputFile.writeLog(.time, "HH Shift %d", shift);
                    printMatrix(hh_shift);
                } else {
                    OutputFile.writeLog(.bold, "HH ShiftAll error %d", shift);
                    printMatrix(hh_shift);

                    let nDifferences = ShiftHHAlg.shiftHHElem(hh, type: type, degree: deg, shift: shift, result: hh_shift)

                    OutputFile.writeLog(.bold, "HH Shift %d", shift);
                    printMatrix(hh_shift);

                    if (nDifferences != 0) {
                        OutputFile.writeLog(.error, "Differences count = %d", nDifferences);
                        return true
                    }
                    return true
                }
            } else {
                let sh = ShiftHHElem.shiftForType(type)
                hh_shift = HHElem()
                sh?.shift(hh_shift!, degree: deg, shift: shift)
                //OutputFile.writeLog(.bold, "Shift %zd", shift);
                //printMatrix(hh_shift);
            }
            if !ShiftHHAlg.checkHHMatrix(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                OutputFile.writeLog(.error, "Shift %zd (%zd) checkHHMatrix failed!", shift, shift % PathAlg.twistPeriod);

                if (type <= kTypeWithProof) {
                    OutputFile.writeLog(.bold, "Wrong HH Shift");
                    printMatrix(hh_shift);

                    OutputFile.writeLog(.bold, "Right HH Shift");
                    let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                    hh_shift = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift)

                    //[ShiftHHGenProgram printProgram:hh_shift shift:shift];
                }
                return true
            }
            hh = HHElem(matrix: hh_shift!)
        }*/
        return false
    }
}

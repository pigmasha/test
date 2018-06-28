//
//  Created by M on 07.06.17.
//

import Foundation

struct Step_14_shift_check {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")

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
        guard ShiftHHElem.shiftForType(type).oddShift(degree: deg, shift: 0).isZero else {
            return processCheap(type: type, deg: deg)
        }
        guard startShift > 0 else {
            return processAll(type: type, deg: deg)
        }
        let ell = deg / PathAlg.twistPeriod
        var shifts: [Int] = []
        var x = startShift
        while x > -1 {
            shifts = [x] + shifts
            x -= PathAlg.twistPeriod
        }

        OutputFile.writeLog(.time, "HH (type=\(type), ell=\(ell))")
        for shift in shifts {
            let hh = shift > 1 ? ShiftHHElem.shiftForType(type).shift(degree: deg, shift: shift - 1) : HHElem(deg: deg, type: type)
            OutputFile.writeLog(.time, "Shift \(shift) (\(shift % PathAlg.twistPeriod))")
            let hh_shift = ShiftHHElem.shiftForType(type).shift(degree: deg, shift: shift)
            if !ShiftCheck.checkHH(hh, hhShift: hh_shift, degree: deg, shift: shift, detailLog: true) {
                //let allVariants = ShiftAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                //PrintUtils.printMatrix("Right HH", ShiftAllSelect.select(from: allVariants!, type: type, shift: shift))
                //let _ = allVariants!.writeToFile(pathWithShift(shift))
                return true
            }
        }
        return false
    }

    private static func processAll(type: Int, deg: Int) -> Bool {
        let ell = deg / PathAlg.twistPeriod
        OutputFile.writeLog(.time, "HH (type=\(type), ell=\(ell))")
        var hh = HHElem(deg: deg, type: type)
        for shift in 0 ... 2/*PathAlg.s*/ * PathAlg.twistPeriod + 1 {
            OutputFile.writeLog(.time, "Shift \(shift) (\(shift % PathAlg.twistPeriod))")
            let hh_shift = ShiftHHElem.shiftForType(type).shift(degree: deg, shift: shift)
            if !ShiftCheck.checkHH(hh, hhShift: hh_shift, degree: deg, shift: shift, detailLog: false) {
                //let allVariants = ShiftAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                //PrintUtils.printMatrix("Right HH", ShiftAllSelect.select(from: allVariants!, type: type, shift: shift))
                //let _ = allVariants!.writeToFile(pathWithShift(shift))
                return true
            }
            hh = hh_shift
        }
        return false
    }

    private static func processCheap(type: Int, deg: Int) -> Bool {
        let ell = deg / PathAlg.twistPeriod
        OutputFile.writeLog(.time, "HH (type=\(type), ell=\(ell))")
        let hh = HHElem(deg: deg, type: type)
        var hhCheap = ShiftHHElem.shiftForType(type).oddShift(degree: deg, shift: 0)
        let hhZero = Matrix(sum: hh, and: hhCheap, koef2: -1)
        //let s = PathAlg.s
        //OutputFile.writeLog(.normal, "\(Diff(deg: deg - 1).rows[0][s].str) * \(Diff(deg: deg - 1).rows[1][s+1].str)")
        if CheckHH.checkForIm(hhZero, degree: deg, shouldBeInIm: true, logError: true) != .inIm {
            PrintUtils.printMatrix("Diff", Diff(deg: deg - 1))
            OutputFile.writeLog(.error, "Init cheap")
            return true
        }
        OutputFile.writeLog(.normal, "Shift 0 ok :)")

        if PathAlg.charK != 2 && !hh.isEq(ShiftHHElem.shiftForType(type).shift(degree: deg, shift: 0), debug: false) {
            OutputFile.writeLog(.error, "Shift 0 != hh")
            return true
        }

        for shift in 1 ... PathAlg.twistPeriod {
            OutputFile.writeLog(.time, "Shift \(shift)")
            let hhCheap_shift = ShiftHHElem.shiftForType(type).oddShift(degree: deg, shift: shift)
            if !ShiftCheck.checkHH(hhCheap, hhShift: hhCheap_shift, degree: deg, shift: shift, detailLog: false) {
                OutputFile.writeLog(.error, "Shift cheap")
                return true
            }
            hhCheap = hhCheap_shift
        }
        return false
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).txt"
    }
}

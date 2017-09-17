//
//  Created by M on 07.05.17.
//

import Foundation

struct Step_13_select_shift {
    static func runCase() -> Bool {
        let kCurrentType = 4

        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let type = kCurrentType
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
        OutputFile.writeLog(.time, "HH (ell=%d, type=%d)", ell, type)
        if !checkMyShift(type: type, deg: deg, shift: 0, hh: hh) {
            PrintUtils.printMatrix(hh)
            ShiftHHGenProgram.printProgram(hh, shift: 0)
            return true
        }

        var shift = 1
        while true {
            let path = pathWithShift(shift)
            var allVariants: ShiftAllVariants? = nil
            if (FileManager.default.fileExists(atPath: path)) {
                allVariants = ShiftAllVariants(withContentsOf: path)
            } else {
                allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
            }
            guard allVariants != nil else {
                OutputFile.writeLog(.time, "ShiftAll failed! Shift=\(shift)")
                return true
            }
            if shift == PathAlg.twistPeriod {
                hh = ShiftHHAlgAll.lastHH(from: allVariants)
            } else {
                hh = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift)
            }
            OutputFile.writeLog(.time, "Shift \(shift)")
            if !checkMyShift(type: type, deg: deg, shift: shift, hh: hh) {
                OutputFile.writeLog(.bold, "Right Shift \(shift)")
                PrintUtils.printMatrix(hh)
                ShiftHHGenProgram.printProgram(hh, shift: shift)
                return true
            }
            if shift == PathAlg.twistPeriod { break }
            shift += 1
        }
        return false
    }

    private static func checkMyShift(type: Int, deg: Int, shift: Int, hh: HHElem) -> Bool {
        let myShift = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift)
        let nDifferents = myShift.numberOfDifferents(hh, debug: true)
        if nDifferents != 0 {
            OutputFile.writeLog(.error, "<br>Bad my shift, nDiff=\(nDifferents), myMatrix:")
            PrintUtils.printMatrix(myShift)
            return false
        }
        return true
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).txt"
    }
}

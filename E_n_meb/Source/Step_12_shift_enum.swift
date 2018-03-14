//
//  Created by M on 09.04.17.
//

import Foundation

struct Step_12_shift_enum {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let type = RunCase.kCurrentType
        if (process(type: type)) { return true }
        return false
    }

    private static func process(type: Int) -> Bool {
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
        let shiftFrom = PathAlg.alg.dummy1// PathAlg.twistPeriod

        let hh0 = HHElem(deg: deg, type: type)
        var hh = HHElem(deg: deg, type: type)
        OutputFile.writeLog(.time, "HH (ell=%d, type=%d)", ell, type)
        PrintUtils.printMatrix("HH", hh)
        if shiftFrom > 0 {
            hh = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shiftFrom)
            PrintUtils.printMatrix("Shift \(shiftFrom)", hh)
        }

        var shift = 1 + shiftFrom
        while true {
            let path = pathWithShift(shift)
            var allVariants: ShiftAllVariants? = nil
            if (FileManager.default.fileExists(atPath: path)) {
                allVariants = ShiftAllVariants(withContentsOf: path)
                guard allVariants != nil else {
                    OutputFile.writeLog(.bold, "ShiftAllVariants from file failed! Shift=\(shift)")
                    return true
                }
            } else {
                allVariants = ShiftAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                guard allVariants != nil else {
                    OutputFile.writeLog(.time, "ShiftAll failed! Shift=\(shift)")
                    shift = stepBack(shift: shift)
                    guard shift > 0 else { return true }
                    continue
                }
                if shift % PathAlg.twistPeriod != 0 {
                    guard saveVariants(allVariants!, path: path) == false else { return true }
                }
            }
            if shift % PathAlg.twistPeriod == 0 {
                processLastShift(variants: allVariants!, shift: shift, firstHH: hh0)
                //break
                shift = stepBack(shift: shift)
                guard shift > shiftFrom else { break }
                try? FileManager.default.removeItem(atPath: path)
                continue
            } else {
                //hh = ShiftAllSelect.select(from: allVariants, type: type, shift: shift)
                hh = ShiftAllSelect.hhFrom(allVariants!)
            }
            OutputFile.writeLog(.time, "Shift=\(shift)")
            //PrintUtils.printMatrixKoefs(hh)
            shift += 1
        }
        return false
    }

    private static func processLastShift(variants: ShiftAllVariants, shift: Int, firstHH: HHElem) {
        var seqStr = ""
        for sh in shift - PathAlg.twistPeriod + 1 ..< shift {
            if let allVariants = ShiftAllVariants(withContentsOf: pathWithShift(sh)) {
                seqStr += "Shift \(sh): " + seqStringFrom(allVariants) + "<br>\n"
            }
        }
        let hh = ShiftAllSelect.lastHH(from: variants, firstHH: firstHH)
        PrintUtils.printMatrix("RESULT \(seqStr)", hh)
        if hh.maxNonZeroPos.1 < PathAlg.s {
            let path = OutputFile.fileName!
            try? OutputFile.setFileName(fileName: path + "_s\(PathAlg.s).html")
            OutputFile.writeLog(.bold, "RESULT")
            OutputFile.writeLog(.normal, seqStr)
            //PrintUtils.printMatrixKoefs(hh, colsMax: PathAlg.s, rowsMax: PathAlg.s)
            PrintUtils.printMatrix("HH", hh)
            try? OutputFile.setFileName(fileName: path)
        }
    }

    private static func stepBack(shift: Int) -> Int {
        guard shift > 1 else {
            OutputFile.writeLog(.bold, "stepBack failed! can't back to first shift")
            return -1
        }
        var prevShift = shift - 1
        while prevShift > 0 {
            let path = pathWithShift(prevShift)
            guard let allVariants = ShiftAllVariants(withContentsOf: path) else {
                OutputFile.writeLog(.bold, "stepBack failed! Read from file error")
                return -1
            }
            if let nextElement = allVariants.nextElement {
                guard saveVariants(nextElement, path: path) == false else { return -1 }
                var str = ""
                for _ in 0 ... shift { str += "&nbsp;&nbsp;" }
                OutputFile.writeLog(.bold, str + seqStringFrom(nextElement))
                return prevShift
            } else {
                try? FileManager.default.removeItem(atPath: path)
                prevShift -= 1
            }
        }
        return prevShift
    }

    private static func seqStringFrom(_ variants: ShiftAllVariants) -> String {
        return variants.seqNumber.map{ String($0) }.joined(separator: ",")
    }

    private static func saveVariants(_ variants: ShiftAllVariants, path: String) -> Bool {
        guard variants.writeToFile(path) else {
            OutputFile.writeLog(.bold, "saveVariants write failed! Path=\(path)")
            return true
        }
        guard let saved = ShiftAllVariants(withContentsOf: path) else {
            OutputFile.writeLog(.bold, "saveVariants save failed! Path=\(path)")
            return true
        }
        guard saved.isEq(to: variants) else {
            OutputFile.writeLog(.bold, "saveVariants isEq failed! Path=\(path)")
            return true
        }
        return false
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).txt"
    }
}

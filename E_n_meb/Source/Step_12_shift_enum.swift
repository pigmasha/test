//
//  Created by M on 09.04.17.
//

import Foundation

struct Step_12_shift_enum {
    static func runCase() -> Bool {
        let kCurrentType = 4

        OutputFile.writeLog(2, "N=%d, S=%d, Char=%d",  PathAlg.alg.n, PathAlg.alg.s, PathAlg.alg.charK)

        let type = kCurrentType
        if (process(type: type)) { return true }
        return false
    }

    private static func process(type: Int) -> Bool {
        for deg in 1...30 * PathAlg.alg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) { return true }
                return false
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool {
        let ell = deg / PathAlg.alg.twistPeriod

        var hh = HHElem(deg: deg, type: type)
        OutputFile.writeLog(5, "HH (ell=%d, type=%d)", ell, type)
        printMatrix(hh)

        var shift = 1
        while true {
            let path = pathWithShift(shift)
            var allVariants: ShiftAllVariants? = nil
            if (FileManager.default.fileExists(atPath: path)) {
                allVariants = ShiftAllVariants(withContentsOf: path)
                guard allVariants != nil else {
                    OutputFile.writeLog(2, "ShiftAllVariants from file failed! Shift=\(shift)")
                    return true
                }
            } else {
                allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                guard allVariants != nil else {
                    OutputFile.writeLog(5, "ShiftAll failed! Shift=\(shift)")
                    shift = stepBack(shift: shift)
                    guard shift > 0 else { return true }
                    continue
                }
                guard saveVariants(allVariants!, path: path) == false else { return true }
            }
            if shift == PathAlg.alg.twistPeriod {
                hh = ShiftHHAlgAll.lastHH(from: allVariants)
                OutputFile.writeLog(5, "shift \(shift)")
                printMatrix(hh)
                break
            } else {
                hh = ShiftHHAlgAll.hh(from: allVariants)
            }
            shift += 1
        }
        return false
    }

    private static func stepBack(shift: Int) -> Int {
        guard shift > 1 else {
            OutputFile.writeLog(2, "stepBack failed! can't back to first shift")
            return -1
        }
        var prevShift = shift - 1
        while prevShift > 0 {
            let path = pathWithShift(prevShift)
            guard let allVariants = ShiftAllVariants(withContentsOf: path) else {
                OutputFile.writeLog(2, "stepBack failed! Read from file error")
                return -1
            }
            if let nextElement = allVariants.nextElement {
                guard saveVariants(nextElement, path: path) == false else { return -1 }
                var str = ""
                for _ in 0 ... shift { str += "&nbsp;&nbsp;" }
                OutputFile.writeLog(2, str + nextElement.seqNumber.map{ String($0) }.joined(separator: ","))
                return prevShift
            } else {
                try? FileManager.default.removeItem(atPath: path)
                prevShift -= 1
            }
        }
        return prevShift
    }

    private static func saveVariants(_ variants: ShiftAllVariants, path: String) -> Bool {
        guard variants.writeToFile(path) else {
            OutputFile.writeLog(2, "saveVariants write failed! Path=\(path)")
            return true
        }
        guard let saved = ShiftAllVariants(withContentsOf: path) else {
            OutputFile.writeLog(2, "saveVariants save failed! Path=\(path)")
            return true
        }
        guard saved.isEq(to: variants) else {
            OutputFile.writeLog(2, "saveVariants isEq failed! Path=\(path)")
            return true
        }
        return false
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.alg.s).sh\(shift).txt"
    }
}

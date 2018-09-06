//
//  Created by M on 07.05.17.
//

import Foundation

struct Step_13_select_shift {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")

        let type = PathAlg.alg.currentType
        for deg in 0...30 * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) { return true }
                //return false
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool {
        let ell = deg / PathAlg.twistPeriod
        let hh0 = HHElem(deg: deg, type: type)
        var hh = HHElem(deg: deg, type: type)
        let shiftFrom = PathAlg.alg.dummy1
        if shiftFrom > 0 {
            hh = ShiftHHElem.shiftForType(type).shift(degree: deg, shift: shiftFrom)
            OutputFile.writeLog(.time, "HH Shift \(shiftFrom) (ell=\(ell), type=\(type))")
        } else {
            OutputFile.writeLog(.time, "HH (ell=\(ell), type=\(type))")
        }
        if !checkMyShift(type: type, deg: deg, shift: shiftFrom, hh: hh) {
            PrintUtils.printMatrix("hh", hh)
            ShiftHHGenProgram.printProgram(hh, shift: 0)
            return true
        }

        var shift = 1 + shiftFrom
        while true {
            let path = pathWithShift(shift)
            var allVariants: ShiftAllVariants? = nil
            if (FileManager.default.fileExists(atPath: path)) {
                allVariants = ShiftAllVariants(withContentsOf: path)
            } else {
                allVariants = ShiftAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                let _ = allVariants!.writeToFile(pathWithShift(shift))
            }
            guard allVariants != nil else {
                OutputFile.writeLog(.time, "ShiftAll failed! Shift=\(shift)")
                return true
            }

            if shift % PathAlg.twistPeriod == 0 {
                hh = ShiftAllSelect.lastHH(from: allVariants, firstHH: hh0)
            } else {
                hh = ShiftAllSelect.select(from: allVariants!, type: type, shift: shift)
            }
            if !checkMyShift(type: type, deg: deg, shift: shift, hh: hh) {
                PrintUtils.printMatrix("Right Shift", hh)
                ShiftHHGenProgram.printProgram(hh, shift: shift)
                if shift + 1 < PathAlg.twistPeriod {
                    for i in shift + 1 ..< PathAlg.twistPeriod {
                        if (FileManager.default.fileExists(atPath: pathWithShift(i))) {
                            allVariants = ShiftAllVariants(withContentsOf: pathWithShift(i))
                            hh = ShiftAllSelect.select(from: allVariants!, type: type, shift: i)
                            ShiftHHGenProgram.printProgram(hh, shift: i)
                        } else {
                            break
                        }
                    }
                }
                return true
            } else {
                OutputFile.writeLog(.normal, "Shift \(shift) ok!")
            }
            if shift == 2*PathAlg.twistPeriod + shiftFrom { break }
            shift += 1
        }
        return false
    }

    private static func checkMyShift(type: Int, deg: Int, shift: Int, hh: HHElem) -> Bool {
        let myShift = ShiftHHElem.shiftForType(type).shift(degree: deg, shift: shift)
        let nDifferents = myShift.numberOfDifferents(hh, debug: true)
        if nDifferents != 0 {
            OutputFile.writeLog(.error, "<br>Bad my shift \(shift), nDiff=\(nDifferents), myMatrix:")
            PrintUtils.printMatrix("myShift", myShift, redColumns: myShift.differentColumns(hh))
            return false
        }
        return true
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).txt"
    }
}

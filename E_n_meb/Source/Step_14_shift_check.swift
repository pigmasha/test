//
//  Created by M on 07.06.17.
//
//

import Foundation

struct Step_14_shift_check {
    static func runCase() -> Bool {
        let kCurrentType = 5
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let type = kCurrentType
        for deg in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) { return true }
                //return false
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool {
        guard type != 5 else {
            return processCheck(type: type, deg: deg)
        }
        
        var hh = HHElem(deg: deg, type: type)

        let shiftMax = 12
        for shift in 1 ... shiftMax {
            OutputFile.writeLog(.time, "Shift \(shift)")
            var hh_shift: HHElem?
            if shift < shiftMax {
                hh_shift = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift)
            } else {
                guard let allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift) else {
                    OutputFile.writeLog(.error, "allVariants failed")
                    return true
                }
                let _ = allVariants.writeToFile(pathWithShift(shift))
                if shift == PathAlg.twistPeriod {
                    hh_shift = ShiftHHAlgAll.lastHH(from: allVariants)
                } else {
                    hh_shift = ShiftHHAlgAll.select(from: allVariants, type: type, shift: shift)
                }
            }
            if !ShiftHHAlg.checkHHMatrix(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                PrintUtils.printMatrix(hh_shift!)
                return true
            }
            if shift == shiftMax {
                PrintUtils.printMatrix(hh_shift!)
            }
            hh = hh_shift!
        }
        return false
    }

    private static func processCheck(type: Int, deg: Int) -> Bool {
        let ell = Int(deg / PathAlg.twistPeriod)
        OutputFile.writeLog(.time, "N=\(PathAlg.n), S=\(PathAlg.s), ell=\(ell)")
        var hh = HHElem(deg: deg, type: type)
        for shift in 1 ... 20 * PathAlg.twistPeriod + 1 {
            let hh_shift = ShiftHHElem.shiftForType(type)!.shift(degree: deg, shift: shift)
            if !ShiftHHAlg.checkHHMatrix(hh, hhShift: hh_shift, degree: deg, shift: shift) {
                OutputFile.writeLog(.bold, "My HH, shift \(shift) (\(shift % PathAlg.twistPeriod))")
                PrintUtils.printMatrix(hh_shift)
                var allVariants: ShiftAllVariants?
                if (FileManager.default.fileExists(atPath: pathWithShift(shift))) {
                    allVariants = ShiftAllVariants(withContentsOf: pathWithShift(shift))
                } else {
                    allVariants = ShiftHHAlgAll.allVariants(for: hh, degree: deg, shift: shift)
                    let _ = allVariants!.writeToFile(pathWithShift(shift))
                }
                OutputFile.writeLog(.bold, "Right HH")
                PrintUtils.printMatrix(ShiftHHAlgAll.select(from: allVariants!, type: type, shift: shift)!)
                return true
            }
            hh = hh_shift
        }
        return false
    }

    private static func pathWithShift(_ shift: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).txt"
    }
}

//
//  Step_8_shift_enum.swift
//  Created by M on 19/03/2020.
//

import Foundation

struct Step_8_shift_enum {
    static let stopAtLast = false

    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "S=\(PathAlg.s), Char=\(PathAlg.charK)")

        let type = PathAlg.alg.currentType
        if (process(type: type)) { return true }
        return false
    }

    private static func process(type: Int) -> Bool {
        for deg in 0...30 * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                if (process(type: type, deg: deg)) { return true }
                return false
            }
        }
        return false
    }

    private static func process(type: Int, deg: Int) -> Bool {
        let ell = deg / PathAlg.twistPeriod
        let shiftFrom = 0//PathAlg.alg.dummy1
        let onlyOne = PathAlg.alg.dummy1 > 0

        let hh0 = HHElem(deg: deg, type: type)
        var hh = HHElem(deg: deg, type: type)
        OutputFile.writeLog(.time, "HH (ell=\(ell), type=\(type))")

        let hhCheap = ShiftHHElem.shiftForType(type).oddShift(degree: deg, shift: 0)
        if !hhCheap.isZero {
            hh = hhCheap
        }
        PrintUtils.printMatrix("HH", hh)

        let path = OutputFile.fileName!
        try? OutputFile.setFileName(fileName: path + "_s\(PathAlg.s).html")
        PrintUtils.printMatrix("Init HH", hh)
        try? OutputFile.setFileName(fileName: path)

        if shiftFrom > 0 {
            hh = ShiftHHElem.shiftForType(type).shift(degree: deg, shift: shiftFrom)
            PrintUtils.printMatrix("Shift \(shiftFrom)", hh)
        }

        var shift = 1 + shiftFrom
        while true {
            let path = Utils.pathWithShift(shift, type: type)
            var allVariants: ShiftAllVariants? = nil
            if (FileManager.default.fileExists(atPath: path)) {
                allVariants = ShiftAllVariants(withContentsOf: path)
                guard allVariants != nil else {
                    OutputFile.writeLog(.bold, "ShiftAllVariants from file failed! Shift=\(shift)")
                    return true
                }
            } else {
                allVariants = ShiftAlgAll.allVariants(for: hh, degree: deg, shift: shift, onlyOne: onlyOne)
                guard allVariants != nil else {
                    OutputFile.writeLog(.time, "ShiftAll failed! Shift=\(shift)")
                    if onlyOne { return true }
                    shift = stepBack(shift: shift, type: type)
                    guard shift > 0 else { return true }
                    continue
                }
                if shift % PathAlg.twistPeriod != 0 {
                    guard saveVariants(allVariants!, path: path) == false else { return true }
                }
            }
            if shift % PathAlg.twistPeriod == 0 {
                let isGood = processLastShift(variants: allVariants!, shift: shift, firstHH: hh0, type: type)
                if stopAtLast && isGood { break }
                if onlyOne { return false }
                shift = stepBack(shift: shift, type: type)
                guard shift > shiftFrom else { break }
                try? FileManager.default.removeItem(atPath: path)
                continue
            } else {
                hh = ShiftAllSelect.hhFrom(allVariants!)
            }
            OutputFile.writeLog(.time, "Shift=\(shift)")
            //PrintUtils.printMatrixKoefs(hh)
            shift += 1
        }
        return false
    }

    private static func processLastShift(variants: ShiftAllVariants, shift: Int, firstHH: HHElem, type: Int) -> Bool {
        var seqStr = ""
        for sh in shift - PathAlg.twistPeriod + 1 ..< shift {
            if let allVariants = ShiftAllVariants(withContentsOf: Utils.pathWithShift(sh, type: type)) {
                seqStr += "Shift \(sh): " + seqStringFrom(allVariants) + "<br>\n"
            }
        }
        let hh = ShiftAllSelect.lastHH(from: variants, firstHH: firstHH)
        PrintUtils.printMatrix("RESULT \(seqStr)", hh)
        let s = PathAlg.s
        var isGood = true
        switch type {
        case 6, 11: isGood = hh.nonZeroCount == 1
        case 7: isGood = hh.nonZeroCount == 4*s
        case 14: isGood = hh.nonZeroCount == 3
        case 29 ... 36: isGood = !hh.rows[type-29][type-29].isZero
        default: break
        }
        guard isGood else {
            return false
        }
        let path = OutputFile.fileName!
        try? OutputFile.setFileName(fileName: path + "_s\(PathAlg.s).html")
        OutputFile.writeLog(.bold, "RESULT")
        OutputFile.writeLog(.normal, seqStr)
        //PrintUtils.printMatrixKoefs(hh, colsMax: PathAlg.s, rowsMax: PathAlg.s)
        PrintUtils.printMatrix("HH (nonZeroCount=\(hh.nonZeroCount))", hh)
        try? OutputFile.setFileName(fileName: path)
        return isGood
    }

    private static func stepBack(shift: Int, type: Int) -> Int {
        guard shift > 1 else {
            OutputFile.writeLog(.bold, "stepBack failed! can't back to first shift")
            return -1
        }
        var prevShift = shift - 1
        while prevShift > 0 {
            let path = Utils.pathWithShift(prevShift, type: type)
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
}


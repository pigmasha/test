//
//  Step_7_createhh.swift
//  Created by M on 16/03/2020.
//

import Foundation

struct Step_7_createhh {
    static func runCase() -> Bool {
        OutputFile.writeLog(.time, "S=\(PathAlg.s), Char=\(PathAlg.charK) (types \(Dim.typeMax))")
        for deg in 0...10 * PathAlg.s * PathAlg.twistPeriod + 2 {
            if process(deg: deg) {
                return true
            }
        }
        return false
    }

    private static func process(deg: Int) -> Bool {
        var hhElements: [HHElem] = []
        for type in 1...Dim.typeMax2 {
            if PathAlg.alg.currentType > 0 && type != PathAlg.alg.currentType { continue }
            guard Dim.deg(deg, hasType: type) else { continue }
            let ell = deg / PathAlg.twistPeriod
            let hh = HHElem(deg: deg, type: type)
            if !CheckHH.checkHHElem(hh, degree: deg, logError: true) {
                OutputFile.writeLog(.error, "type=\(type), ell=\(ell)")
                PrintUtils.printMatrix("Bad HH", hh)
                calcHH(deg: deg, type: type)
                return true
            } else {
                OutputFile.writeLog(.normal, "type=\(type): HH (ell=\(ell)): checked :)")
                //PrintUtils.printMatrix("HH", hh)
            }
            hhElements += [hh]
        }
        if hhElements.count < 2 { return false }
        for i in 0 ..< hhElements.count - 1 {
            for j in i + 1 ..< hhElements.count {
                guard let checkResult = CheckHH.checkHHElemNotSame(hhElements[i], hhElements[j], degree: deg) else {
                    OutputFile.writeLog(.error, "Check same error, deg=\(deg)")
                    PrintUtils.printMatrix("HH1", hhElements[i])
                    PrintUtils.printMatrix("HH2", hhElements[j])
                    return true
                }
                if checkResult == false {
                    OutputFile.writeLog(.error, "Same elements, deg=\(deg)")
                    PrintUtils.printMatrix("HH1", hhElements[i])
                    PrintUtils.printMatrix("HH2", hhElements[j])
                    return true
                }
            }
        }
        return false
    }

    private static func calcHH(deg: Int, type: Int) {
        PrintUtils.printMatrix("Ker", Diff(deg: deg))
        PrintUtils.printIm("Im", ImMatrix(diff: Diff(deg: deg - 1)), deg: deg - 1)
        let path = Utils.pathWithShift(0, type: type)
        var variants: ShiftAllVariants? = nil
        if FileManager.default.fileExists(atPath: path) {
            variants = ShiftAllVariants(withContentsOf: path)
            guard variants != nil else {
                OutputFile.writeLog(.error, "ShiftAllVariants from file failed!")
                return
            }
        } else {
            variants = CreateAlgAll.kerVariants(for: deg, onlyOne: true)
            guard variants != nil else {
                OutputFile.writeLog(.time, "kerVariants failed!")
                return
            }
            guard variants!.writeToFile(path) else {
                OutputFile.writeLog(.bold, "saveVariants write failed! Path=\(path)")
                return
            }
        }
        let colsTenzors = CreateAlgAll.colsTenzors(deg: deg)

        for variant in variants!.variants[0] {
            let hh = variant.hh
            PrintUtils.printMatrix("hh", hh)
            let hh2 = HHElem()
            hh2.makeZeroMatrix(colsTenzors.count, h: 8*PathAlg.s)
            for j in 0..<colsTenzors.count {
                guard colsTenzors[j].row > -1 else { continue }
                guard !hh.rows[0][j].isZero else { continue }
                hh2.rows[colsTenzors[j].row][j].addComb(Comb(tenzor: colsTenzors[j].t, koef: hh.rows[0][j].terminateKoef(isLast: true)))
            }
            if CheckHH.checkHHElem(hh2, degree: deg, logError: true) {
                PrintUtils.printMatrix("HH2 (d=\(deg))", hh2)
                HHProgram(hhElem: hh2, deg: deg, type: type).printProgram()
            }
        }
    }

    private static func calcHH2(deg: Int, type: Int) {
        let colsTenzors = CreateAlgAll.colsTenzors(deg: deg)
        let nonZeros = colsTenzors.filter { $0.row > -1 }.count
        print("colsTenzors \(colsTenzors.count)/\(nonZeros): \(colsTenzors.map { $0.t.str })")
        PrintUtils.printMatrix("Ker", Diff(deg: deg))
        PrintUtils.printIm("Im", ImMatrix(diff: Diff(deg: deg - 1)), deg: deg - 1)
        for lim in 1 ... nonZeros {
            OutputFile.writeLog(.bold, "Limit \(lim) (nonZeros=\(nonZeros))")
            if calcOnePerBlock(deg: deg, type: type, colsTenzors: colsTenzors, nonZeros: nonZeros, cardLimit: lim) {
                break
            }
        }
        /*if PathAlg.alg.dummy1 == 0 &&
            calcOnePerBlock(deg: deg, type: type, colsTenzors: colsTenzors, nonZeros: nonZeros, cardLimit: 3) {
            return
        }
        if PathAlg.s == 1 {
            _ = calcOnePerBlock(deg: deg, type: type, colsTenzors: colsTenzors, nonZeros: nonZeros, cardLimit: -4)
        } else {
            _ = calcBlocks(deg: deg, type: type, colsTenzors: colsTenzors)
        }*/
    }

    private static let char5 = 5

    private static func calcOnePerBlock(deg: Int, type: Int, colsTenzors: [(row: Int, t: Tenzor)],
                                        nonZeros: Int, cardLimit: Int) -> Bool {
        var hasResults = false
        let r = PathAlg.charK == char5 ? char5 : 3
        var dd = 1
        for _ in 0 ..< nonZeros { dd *= r }
        var lastPer = -1
        for d in 1 ... dd {
            let per = d * 100 / dd
            if lastPer != per {
                lastPer = per
                OutputFile.writeLog(.normal, "\(Date()) one per block: (\(per)%)")
            }
            if cardLimit > 0 && card(d) != cardLimit { continue }
            if cardLimit < 0 && card(d) < -cardLimit { continue }
            if !isOk(d) { continue }
            let hh2 = HHElem()
            hh2.makeZeroMatrix(colsTenzors.count, h: 8*PathAlg.s)
            var kk = d
            for j in 0..<colsTenzors.count {
                if colsTenzors[j].row < 0 { continue }
                let k = r == char5 ? (kk % r) : (kk % 3 == 2 ? -1 : (kk % 3))
                kk /= r
                guard k != 0 else { continue }
                if colsTenzors[j].row > -1 {
                    hh2.rows[colsTenzors[j].row][j].addComb(Comb(tenzor: colsTenzors[j].t, koef: Double(k)))
                }
            }
            if CheckHH.checkHHElem(hh2, degree: deg, logError: false) {
                PrintUtils.printMatrix("HH2 (d=\(d))", hh2)
                HHProgram(hhElem: hh2, deg: deg, type: type).printProgram()
                hasResults = true
            }
        }
        return hasResults
    }

    private static func calcBlocks(deg: Int, type: Int, colsTenzors: [(row: Int, t: Tenzor)]) -> Bool {
        let s = PathAlg.s
        var hasResults = false
        let r = PathAlg.charK == char5 ? char5 : 3
        var dd = 1
        var isZeroBlocks: [Bool] = []
        for j in 0 ..< colsTenzors.count / s {
            var isZeroBlock = true
            for i in 0 ..< s {
                if colsTenzors[j*s+i].row > -1 { isZeroBlock = false; break }
            }
            isZeroBlocks.append(isZeroBlock)
            if !isZeroBlock { dd *= r }
        }
        var lastPer = -1
        for d in 1 ... dd {
            let per = d * 100 / dd
            if lastPer != per {
                lastPer = per
                OutputFile.writeLog(.normal, "\(Date()) blocks: (\(per)%)")
            }
            if PathAlg.alg.dummy1 > 0 && card(d) != PathAlg.alg.dummy1 { continue }
            if !isOk(d) { continue }
            let hh2 = HHElem()
            hh2.makeZeroMatrix(colsTenzors.count, h: 8*PathAlg.s)
            var kk = d
            for j in 0..<colsTenzors.count / s {
                if isZeroBlocks[j] { continue }
                let k = r == char5 ? (kk % r) : (kk % 3 == 2 ? -1 : (kk % 3))
                kk /= r
                guard k != 0 else { continue }
                for i in 0 ..< s {
                    let col = j*s + i
                    if colsTenzors[col].row > -1 {
                        hh2.rows[colsTenzors[col].row][col].addComb(Comb(tenzor: colsTenzors[col].t, koef: Double(k)))
                    }
                }
            }
            if CheckHH.checkHHElem2(hh2, degree: deg, logError: false) {
                PrintUtils.printMatrix("HH2", hh2)
                HHProgram(hhElem: hh2, deg: deg, type: type).printProgram()
                hasResults = true
            }
        }
        return hasResults
    }

    private static func card(_ d: Int) -> Int {
        let r = PathAlg.charK == char5 ? char5 : 3
        var kk = d
        var c = 0
        while kk > 0 {
            let k = kk % r
            kk /= r
            if k != 0 { c += 1 }
        }
        return c
    }

    private static func isOk(_ d: Int) -> Bool {
        let r = PathAlg.charK == char5 ? char5 : 3
        var kk2 = d
        while kk2 > 0 {
            let k = r == char5 ? (kk2 % r) : (kk2 % 3 == 2 ? -1 : (kk2 % 3))
            if k != 0 {
                return r == char5 ? k != char5 - 1 : k != -1
            }
            kk2 /= r
        }
        return true
    }
}


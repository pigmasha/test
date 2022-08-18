//
//  Step_6_shift.swift
//  Created by M on 25.05.2022.
//

import Foundation

struct Step_6_shift {
    private static var printSh = true

    static func runCase() -> Bool {
        //return check(labels: ["t"])
        let ee = GenCreate.allElements
        for e in ee {
            if e.label != "v1" { continue }
            OutputFile.writeLog(.normal, e.str)
            let s0 = ShiftHH(gen: e)
            if let err = s0.check() {
                s0.print()
                OutputFile.writeLog(.error, "Check shift 0 error: " + err)
                return true
            }
            let myS0 = ShiftHH(gen: e, shiftDeg: 0)
            if s0.matrix.numberOfDifferents(with: myS0.matrix) != 0 {
                s0.print()
                PrintUtils.printMatrix("M", myS0.matrix)
                //s0.printProgram()
                OutputFile.writeLog(.error, "numberOfDifferents \(s0.matrix.numberOfDifferents(with: myS0.matrix))")
                return true
            }
            var ss = s0
            for d in 1 ... PathAlg.alg.someNumber {
                //OutputFile.writeLog(.bold, "Shift \(d)")
                let myS1 = ShiftHH(gen: e, shiftDeg: d)
                if printSh { PrintUtils.printMatrix("My Shift \(d)", myS1.matrix) }
                let s1 = ShiftHH(nextAfter: ss)
                if let err = s1.check() {
                    s1.print()
                    if !printSh { PrintUtils.printMatrix("My Shift", myS1.matrix) }
                    //s1.printProgram()
                    OutputFile.writeLog(.error, "Check shift \(d) error: " + err)
                    return true
                }
                if s1.matrix.numberOfDifferents(with: myS1.matrix) != 0 {
                    s1.print()
                    //s1.printProgram(diffWith: myS1.matrix)
                    OutputFile.writeLog(.error, "numberOfDifferents \(s1.matrix.numberOfDifferents(with: myS1.matrix)), my shift:")
                    //myS1.print()
                    //return true
                } else {
                    OutputFile.writeLog(.normal, "Shift \(d) checked :)")
                }
                ss = s1
            }
        }
        return false
    }

    private static func check(labels: [String]) -> Bool {
        let ee = GenCreate.allElements
        for e in ee {
            if !labels.contains(e.label) { continue }
            if check(elem: e) { return true }
        }
        return false
    }

    private static func check() -> Bool {
        let ee = GenCreate.allElements
        for e in ee {
            if e.label == "1" { continue }
            if check(elem: e, log: true) { return true }
        }
        return false
    }

    private static func check(deg: Int) -> Bool {
        let ee = GenCreate.allElements
        for e in ee {
            if e.deg != deg || e.label == "1" { continue }
            if check(elem: e) { return true }
        }
        return false
    }

    private static func check(elem e: Gen, log: Bool = true) -> Bool {
        OutputFile.writeLog(.normal, e.str)
        let s0 = ShiftHH(gen: e, shiftDeg: 0)
        if printSh { s0.print() }
        if let err = s0.check() {
            s0.print()
            OutputFile.writeLog(.error, "Check shift 0 error: " + err)
            return true
        }
        let s01 = ShiftHH(gen: e)
        if s01.matrix.numberOfDifferents(with: s0.matrix) != 0 {
            s0.print()
            OutputFile.writeLog(.error, "Check shift 0 matrix error")
            return true
        }
        var ss = s0
        let M = PathAlg.alg.someNumber
        for d in 1 ... M {
            let s1 = ShiftHH(gen: e, shiftDeg: d)
            if s1.matrix.isZero { break }
            if let err = s1.check() {
                s1.print()
                OutputFile.writeLog(.error, "Check shift \(d) error: " + err)
                return true
            }
            if printSh { s1.print() }
            let m1 = Matrix(mult: ss.matrix, and: Diff(deg: ss.hhDeg + ss.shiftDeg))
            let m2 = Matrix(mult: Diff(deg: ss.shiftDeg), and: s1.matrix)
            let n = m2.numberOfDifferents(with: m1)
            if n != 0 {
                s1.print()
                let cc = m1.diffColumns(with: m2)
                PrintUtils.printMatrix("Mult", m1)
                PrintUtils.printMatrix("Our Mult", m2, redColumns: cc)
                OutputFile.writeLog(.error, "numberOfDifferents \(n), diffColumns: \(cc)")
                return true
            }
            if log && !PathAlg.isTex { OutputFile.writeLog(.normal, "Shift \(d) checked :)") }
            ss = s1
        }
        return false
    }
}

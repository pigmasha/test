//
//  Step_2_diff.swift
//  Created by M on 16.05.2022.
//

import Foundation

struct Step_2_diff {
    static func runCase() -> Bool {
        //let err = Diff.checkRelations()
        //if err != 0 { OutputFile.writeLog(.error, "Diff.checkRelations error=\(err)"); return true }
        //return false
        if PathAlg.isTex {
            for deg in 0 ... 7 {
                PrintUtils.printMatrix("d_\(deg)=", Diff(deg: deg))
            }
            Diff.printTex()
            return false
        }
        var prevDiff = Diff(deg: 0)
        //PrintUtils.printMatrix("Diff 0", prevDiff)
        for deg in 1 ..< PathAlg.alg.someNumber {
            OutputFile.writeLog(.time, "Deg \(deg) (m=\(deg % 8), n=\(deg / 8))")
            let d1 = Diff(deg: deg)
            let d: Diff
            if !d1.isZero {
                d = d1
                //PrintUtils.printMatrix("Diff \(deg) (m=\(deg % 8), n=\(deg / 8))", d)
            } else {
                d = Diff(emptyForDeg: deg)
                if let err = CreateDiff.create(diff: d, deg: deg, prevDiff: prevDiff) {
                    OutputFile.writeLog(.error, "CreateDiff.create error: " + err)
                    return true
                }
                PrintUtils.printMatrix("New Diff \(deg)", d)
            }

            if let err = CreateDiff.check(diff: d, deg: deg, prevDiff: prevDiff) {
                OutputFile.writeLog(.error, "CreateDiff.check error (m=\(deg % 8), n=\(deg / 8)): " + err)
                /*PrintUtils.printPMatrix("", PDiff(deg: deg))
                if let err = CreateDiff.tryFix(diff: d, deg: deg, prevDiff: prevDiff, column: 1, rows: (0, 2), searchAll: false) {
                    OutputFile.writeLog(.error, "CreateDiff.tryFix error: " + err)
                }
                PrintUtils.printMatrix("Fixed diff", d)*/
                return true
            }

            prevDiff = d
        }
        return false
    }
}

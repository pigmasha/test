//
//  Created by M on 26.02.2023.
//

import Foundation

struct Step_3_calc_dn {
    static func runCase() -> Bool {
        var prevDiff: Diff?
        for deg in 0 ... PathAlg.alg.someNumber {
            //let prevDiff = deg == 0 ? nil : Diff(deg: deg - 1)
            let diff = Diff(emptyForDeg: deg)
            let res = CalcDiff.calcDiffWithNumber(diff, prevDiff: prevDiff)
            PrintUtils.printDiffMatrix("Diff \(deg)", diff)
            if !CheckDiff.checkElem(diff, degFrom: deg + 1, degTo: deg) { return true }
            if res != 0 {
                OutputFile.writeLog(.error, "CalcDiff.calcDiffWithNumber: deg=\(deg): error \(res)!")
                return true
            }
            prevDiff = diff
            continue
            if let prevDiff = prevDiff {
                let multRes = Matrix(mult: prevDiff, and: diff)
                if multRes.isNil {
                    OutputFile.writeLog(.error, "deg=\(deg): mult is nil!")
                    return true
                }
                if !multRes.isZero {
                    OutputFile.writeLog(.error, "deg=\(deg): mult no zero!")
                    return true
                }
            }
        }
        return false
    }
}

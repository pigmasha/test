//
//  Created by M on 02.07.17.
//

struct Step_1_calc_dn {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)
        for deg in 0...7 * PathAlg.twistPeriod + 2 {
            let prevDiff = deg == 0 ? nil : Diff(deg: deg - 1)
            let diff = Diff(deg: deg)
            let err = CalcDiff.calcDiffWithNumber(diff, deg: deg, prevDiff: prevDiff)
            if err != 0 {
                OutputFile.writeLog(.error, "Err %d", err)
                return true
            }
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

            let lenErr = CalcDiff.checkDiffLen(diff, deg: deg)
            if lenErr != 0 {
                OutputFile.writeLog(.error, "deg=\(deg): ERROR= \(lenErr)!")
                return true
            }
        }
        return false
    }
}

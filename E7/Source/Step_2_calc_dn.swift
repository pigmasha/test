//
//  Created by M on 02.07.17.
//

struct Step_2_calc_dn {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        let degTo = PathAlg.alg.dummy1 == 0 ? 7 * PathAlg.twistPeriod + 3 : PathAlg.alg.dummy1
        for deg in 0 ..< degTo {
            let prevDiff = deg == 0 ? nil : Diff(deg: deg - 1)
            let diff = Diff(deg: deg)
            let err = CalcDiff.calcDiffWithNumber(diff, deg: deg, prevDiff: prevDiff)
            if err != 0 {
                OutputFile.writeLog(.error, "Err \(err)")
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

            /*let lenErr = CalcDiff.checkDiffLen(diff, deg: deg)
            if lenErr != 0 {
                OutputFile.writeLog(.error, "deg=\(deg): ERROR= \(lenErr)")
                return true
            }*/
        }
        return false
    }
}

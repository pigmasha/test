//
//  Created by M on 26.02.2023.
//

import Foundation

struct Step_3_calc_dn {
    static func runCase() -> Bool {
        var prevDiff: Diff?
        for deg in 0 ... PathAlg.alg.someNumber {
            let myDiff = Diff(deg: deg)
            if !myDiff.isZero {
                if !CheckDiff.checkDiff(myDiff, prevDiff) { return true }
                PrintUtils.printDiffMatrix("Diff \(deg)", myDiff)
                OutputFile.writeLog(.normal, "deg=\(deg) checked :)")
                prevDiff = myDiff
                continue
            }
            let diff = Diff(emptyForDeg: deg)
            let res = CalcDiff.calcDiffWithNumber(diff, prevDiff: prevDiff)
            if !CheckDiff.checkElem(diff, degFrom: deg + 1, degTo: deg) { return true }
            if res != 0 {
                OutputFile.writeLog(.error, "CalcDiff.calcDiffWithNumber: deg=\(deg): error \(res)!")
                return true
            }
            PrintUtils.printDiffMatrix("Diff \(deg)", diff)
            printProgram(diff)
            prevDiff = diff
            return true
        }
        return false
    }

    private static func printProgram(_ diff: Diff) {
        OutputFile.writeLog(.simple, "<pre>private func createDiff4\(diff.deg)() {\n")
        for j in 0 ..< diff.width {
            for i in 0 ..< diff.height {
                let e = diff.rows[i][j]
                if e.isZero { continue }
                let t = e.contents[0].1
                OutputFile.writeLog(.simple, "    rows[\(i)][\(j)].add(left: \(t.leftComponent.strProg), right: \(t.rightComponent.strProg), koef: \(e.contents[0].0.n))\n")
            }
        }
        OutputFile.writeLog(.simple, "}\n</pre>")
    }
}

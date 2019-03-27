//
//  Created by M on 25.02.18.
//

import Foundation

struct CalcDiff {
    static func calcDiffWithNumber(_ diff: Diff, deg: Int, prevDiff: Diff?) -> Int {
        OutputFile.writeLog(.simple, "deg=\(deg) ")
        let d = deg % PathAlg.twistPeriod

        let qFrom = BimodQ(deg: d + 1)
        let qTo = BimodQ(deg: d)
        let checkDiff = Diff(zeroMatrix: qFrom.pij.count, h: qTo.pij.count)
        if CalcDiffAll.fillCheckMatrix(deg: deg, checkDiff: checkDiff) != 0 { return 1 }

        let onError: (Int) -> Int = { code in
            PrintUtils.printMatrixDeg("check diff", checkDiff, deg + 1, deg)
            PrintUtils.printMatrixDeg("my diff", diff, deg + 1, deg)
            //DiffProgram.diffProgram(checkDiff, deg: deg)
            return code
        }

        if deg == 0 {
            let res = createZeroDiff(checkDiff, qFrom: qFrom, qTo: qTo)
            if res != 0 {
                PrintUtils.printMatrixDeg("diff", diff, deg + 1, deg)
                PrintUtils.printMatrixDeg("check diff", checkDiff, deg + 1, deg)
                return res
            }
        } else {
            let multRes = Diff(mult: prevDiff!, and: diff)
            if !multRes.isZero {
                PrintUtils.printMatrixDeg("Prev diff", prevDiff!, deg, deg - 1)
                PrintUtils.printMatrixDeg("multRes", multRes, deg + 1, deg)
                return onError(9)
            }
        }
        checkDiff.twist(deg)
        
        if checkDiff.height != diff.rows.count { return onError(10) }
        if checkDiff.width != diff.rows.last!.count { return onError(11) }

        for i in 0 ..< checkDiff.height {
            for j in 0 ..< checkDiff.width {
                let c1 = checkDiff.rows[i][j]
                let c2 = diff.rows[i][j]
                if c1.isOnlyZero && !c2.isZero { return onError(12) }
                if c1.isZero || !c1.isFirstStep { continue; }
                if !c2.hasSummand(c1) {
                    OutputFile.writeLog(.error, "i=\(i), j=\(j)")
                    return onError(13)
                }
            }
        }
        OutputFile.writeLog(.normal, "OK!")
        return 0
    }

    static func checkDiffLen(_ diff: Diff, deg: Int) -> Int {
        /*let lens = DiffLen(deg: deg)
        if lens.items.count == 0 { return 0 }

        let items = lens.items
        let rows = diff.rows
        if items.count != rows.count { return 1 }
        if items[0].count != rows[0].count { return 2 }

        for i in 0 ..< rows.count {
            for j in 0 ..< rows[0].count {
                let c = rows[i][j]
                let n = items[i][j]
                if c.isZero {
                    if n.n0 != 0 || n.n1 != 0 { return 3 }
                } else {
                    let t = c.content.last!.tenzor
                    if t.leftComponent.len != n.n0 {
                        OutputFile.writeLog(.error, "deg=\(deg):(\(i),\(j)): left \(t.leftComponent.len) != \(n.n0) - my")
                        return 4
                    }
                    if t.rightComponent.len != n.n1 {
                        OutputFile.writeLog(.error, "deg=\(deg):(\(i),\(j)): right \(t.rightComponent.len) != \(n.n1) - my")
                        return 5
                    }
                }
            }
        }*/
        return 0
    }

    static func createZeroDiff(_ diff: Diff, qFrom: BimodQ, qTo: BimodQ) -> Int {
        for i in 0 ..< qTo.pij.count {
            for j in 0 ..< qFrom.pij.count {
                let c1 = diff.rows[i][j]
                if !c1.isZero || c1.isOnlyZero { continue }
                let wL = Way(from: qTo.pij[i].0, to: qFrom.pij[j].0)
                let wR = Way(from: qFrom.pij[j].1, to:qTo.pij[i].1)
                guard !wL.isZero && !wR.isZero else { continue }

                if wL.len + wR.len != 1 {
                    if PathAlg.s == 1 {
                        if wL.len + wR.len < 5 { return 1 }
                    } else {
                        return 1
                    }
                } else {
                    c1.addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: -1))
                }
            }
        }
        for j in 0 ..< qFrom.pij.count {
            var hasPos = false
            var hasNeg = false
            for i in 0 ..< qTo.pij.count {
                let c1 = diff.rows[i][j]
                if c1.isZero { continue; }

                let k = c1.terminateKoef(isLast: false)
                if k > 0 {
                    if hasPos { return 2 }
                    hasPos = true
                }
                if k < 0 {
                    if hasNeg { return 3 }
                    hasNeg = true
                }
                if k == 0 { return 4 }
            }
            if !hasPos { return 5 }
            if !hasNeg { return 6 }
        }
        return 0
    }
}

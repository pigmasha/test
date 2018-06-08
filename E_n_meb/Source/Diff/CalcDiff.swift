//
//  Created by M on 25.02.18.
//

import Foundation

struct CalcDiff {
    static func calcDiffWithNumber(_ diff: Diff, deg: Int, prevDiff: Diff?) -> Int {
        OutputFile.writeLog(.simple, "deg=\(deg)")
        let s = PathAlg.s
        let d = deg % PathAlg.twistPeriod

        let qFrom = BimodQ(deg: d + 1)
        let qTo = BimodQ(deg: d)
        let checkDiff = Diff(zeroMatrix: qFrom.pij.count, h: qTo.pij.count)

        var col = 0
        var row = 0
        for nSq in 0 ..< qFrom.sizes.count {
            var sq1 = false
            for i in 0 ..< qTo.sizes[nSq].intValue {
                for j in 0 ..< qFrom.sizes[nSq].intValue {
                    for k in 0 ..< s {
                        let ii = row + i * s + k
                        let jj = col + j * s + k

                        let fromSz = qFrom.sizes[nSq].intValue
                        let toSz   = qTo.sizes[nSq].intValue

                        let wL = Way(from: qTo.pij[ii].n0, to: qFrom.pij[jj].n0, noZeroLen: true)
                        let wR = Way(from: qFrom.pij[jj].n1, to: qTo.pij[ii].n1)

                        if fromSz == 2 && toSz == 2 {
                            if i == 0 && j == 0 {
                                if wL.isZero { return 1 }
                                sq1 = (wL.len == 1)
                            }
                            if j == 1 && ((i == 1 && sq1) || (i == 0 && !sq1)) {
                                checkDiff.rows[ii][jj].isOnlyZero = true
                                continue
                            }
                        }
                        if wL.isZero || wR.isZero {
                            OutputFile.writeLog(.error, "deg=\(deg), row=\(ii), col=\(jj), fromSz=\(fromSz), toSz=\(toSz)")
                            PrintUtils.printMatrixDeg("", checkDiff, deg + 1, deg)
                            return 1
                        }
                        let t = Tenzor(left: wL, right: wR)
                        let c = Comb(tenzor: t, koef: 1)

                        if (toSz == 2 && fromSz == 1 && i == 1 && wL.len < 3) { c.compKoef(-1) }
                        if (toSz == 2 && fromSz == 2 && i == 1 && j == 0) { c.compKoef(-1) }

                        checkDiff.rows[ii][jj].addComb(c)
                    }
                }
            }
            col += s * qFrom.sizes[nSq].intValue
            row += s * qTo.sizes[nSq].intValue
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
                PrintUtils.printMatrixDeg("diff", diff, deg + 1, deg)
                PrintUtils.printMatrixDeg("check diff", checkDiff, deg + 1, deg)
                return 9
            }
        }
        checkDiff.twist(deg)
        
        if checkDiff.height != diff.rows.count { return 10 }
        if checkDiff.width != diff.rows.last!.count { return 11 }

        for i in 0 ..< checkDiff.height {
            for j in 0 ..< checkDiff.width {
                let c1 = checkDiff.rows[i][j]
                let c2 = diff.rows[i][j]
                if c1.isOnlyZero && !c2.isZero { return 12 }
                if c1.isZero { continue; }
                if !c2.hasSummand(c1) {
                    OutputFile.writeLog(.error, "i=\(i), j=\(j)")
                    return 13
                }
            }
        }
        OutputFile.writeLog(.normal, "OK!")
        return 0
    }

    static func checkDiffLen(_ diff: Diff, deg: Int) -> Int {
        let lens = DiffLen(deg: deg)
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
        }
        return 0
    }

    private static func createZeroDiff(_ diff: Diff, qFrom: BimodQ, qTo: BimodQ) -> Int {
        for i in 0 ..< qTo.pij.count {
            for j in 0 ..< qFrom.pij.count {
                let c1 = diff.rows[i][j]
                if !c1.isZero { continue }

                let wL = Way(from: qTo.pij[i].n0, to: qFrom.pij[j].n0)
                let wR = Way(from: qFrom.pij[j].n1, to:qTo.pij[i].n1)

                if !wL.isZero && !wR.isZero {
                    if wL.len + wR.len != 1 {
                        return 1
                    }
                    let t = Tenzor(left: wL, right: wR)
                    c1.addComb(Comb(tenzor: t, koef: -1))
                }
            }
        }
        for j in 0 ..< qFrom.pij.count {
            var hasPos = false
            var hasNeg = false
            for i in 0 ..< qTo.pij.count {
                let c1 = diff.rows[i][j]
                if (c1.isZero) { continue; }

                let k = c1.firstKoef
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
            if (!hasPos) { return 5 }
            if (!hasNeg) { return 6 }
        }
        return 0
    }
}

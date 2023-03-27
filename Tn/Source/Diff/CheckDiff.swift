//
//  Created by M on 26.02.2023.
//

import Foundation

struct CheckDiff {
    static func checkElem(_ matrix: Matrix, degFrom: Int, degTo: Int) -> Bool {
        let qFrom = BimodQ(deg: degFrom)
        let qTo = BimodQ(deg: degTo)
        guard matrix.height == qTo.pij.count else {
            OutputFile.writeLog(.error, "checkElem: wrong number of rows")
            return false
        }
        guard matrix.width == qFrom.pij.count else {
            OutputFile.writeLog(.error, "checkElem: wrong number of columns")
            return false
        }
        for i in 0 ..< matrix.height {
            for j in 0 ..< matrix.width {
                let c = matrix.rows[i][j]
                guard !c.isZero else { continue }
                let t = c.contents[0].1
                guard t.leftComponent.endVertex == qFrom.pij[j].0 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(left ends in \(t.leftComponent.endVertex), must be \(qFrom.pij[j].0))")
                    return false
                }
                guard t.leftComponent.startVertex == qTo.pij[i].0 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(left starts in \(t.leftComponent.startVertex), must be \(qTo.pij[i].0))")
                    return false
                }
                guard t.rightComponent.endVertex == qTo.pij[i].1 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(right ends in \(t.rightComponent.startVertex), must be \(qTo.pij[i].1))")
                    return false
                }
                guard t.rightComponent.startVertex == qFrom.pij[j].1 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(right starts in \(t.rightComponent.endVertex), must be \(qFrom.pij[j].1))")
                    return false
                }
            }
        }
        return true
    }

    static func checkDiff(_ diff: Diff, _ prevDiff: Diff?) -> Bool {
        let deg = diff.deg
        if !checkElem(diff, degFrom: deg + 1, degTo: deg) { return false }
        let qFrom = BimodQ(deg: diff.deg + 1)
        let qTo = BimodQ(deg: diff.deg)
        if diff.width != qFrom.pij.count || diff.height != qTo.pij.count { return false  }
        var pos = (0, 0)
        var checked = Set<[Int]>()
        for i in 1 ... PathAlg.n + 1 {
            let d = PDiff(deg: diff.deg, i: i)
            for row in d.rows {
                for (j, e) in row.enumerated() {
                    if e.isZero { continue }
                    if !diff.rows[pos.0][pos.1 + j].isEq(
                        Comb(left: e.contents[0].1, right: Way(e: i), koef: e.contents[0].0.n)) {
                        OutputFile.writeLog(.error, "checkDiff: deg=\(deg): bad (\(pos.0), \(pos.1 + j)) element, should be same as in PDiff")
                        return false
                    }
                    checked.insert([pos.0, pos.1 + j])
                }
                pos.0 += 1
            }
            pos.1 += d.width
        }
        for (i, row) in diff.rows.enumerated() {
            for (j, e) in row.enumerated() {
                if e.isZero { continue }
                if e.contents.count != 1 {
                    OutputFile.writeLog(.error, "checkDiff: deg=\(deg): bad (\(i), \(j)) element: more tan one tenzor")
                    return true
                }
                if e.contents[0].1.rightComponent.len != 0 { continue }
                if !checked.contains([i, j]) {
                    OutputFile.writeLog(.error, "checkDiff: deg=\(deg): bad (\(i), \(j)) element, right component is e, no such element in PDiff")
                    return false
                }
            }
        }
        if let prevDiff = prevDiff {
            let multRes = Matrix(mult: prevDiff, and: diff)
            if multRes.isNil {
                OutputFile.writeLog(.error, "checkDiff: deg=\(deg): mult is nil!")
                return false
            }
            if !multRes.isZero {
                OutputFile.writeLog(.error, "checkDiff: deg=\(deg): mult no zero!")
                return false
            }
        }
        return true
    }
}

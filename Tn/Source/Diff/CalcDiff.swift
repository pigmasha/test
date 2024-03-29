//
//  Created by M on 26.02.2023.
//

import Foundation

struct CalcDiff {
    static func calcDiffWithNumber(_ diff: Diff, prevDiff: Diff?) -> Int {
        OutputFile.writeLog(.normal, "deg=\(diff.deg)")
        /*let e = calcDiffWithNumber(diff, prevDiff: prevDiff, all: true)
        if e != 0 { return e }
        for row in diff.rows {
            row.forEach { $0.clear() }
        }*/
        return calcDiffWithNumber(diff, prevDiff: prevDiff, all: false)
    }

    private static func calcDiffWithNumber(_ diff: Diff, prevDiff: Diff?, all: Bool) -> Int {
        let qFrom = BimodQ(deg: diff.deg + 1)
        let qTo = BimodQ(deg: diff.deg)
        if diff.width != qFrom.pij.count || diff.height != qTo.pij.count { return 1 }
        var pos = (0, 0)
        var hasBadColumns = false
        for i in 1 ... PathAlg.n + 1 {
            let d = PDiff(deg: diff.deg, i: i)
            for row in d.rows {
                for (j, e) in row.enumerated() {
                    if e.isZero { continue }
                    diff.rows[pos.0][pos.1 + j].add(left: e.contents[0].1,
                                                    right: Way(e: i),
                                                    koef: e.contents[0].0.n)
                }
                pos.0 += 1
            }
            pos.1 += d.width
        }
        for j in 0 ..< diff.width {
            if !all { OutputFile.writeLog(.time, "Col \(j) of \(diff.width)") }
            if let prevDiff = prevDiff, Matrix(mult: prevDiff, and: diff, column: j).isZero { continue }
            var allVariants: [(Int, Tenzor)] = []
            for i in 0 ..< diff.height {
                if !diff.rows[i][j].isZero { continue }
                let wL = Way(from: qTo.pij[i].0, to: qFrom.pij[j].0)
                let wR = Way(from: qFrom.pij[j].1, to: qTo.pij[i].1)
                guard !wL.isZero && !wR.isZero else { continue }
                guard wR.len > 0 else { continue }
                allVariants.append((i, Tenzor(left: wL, right: wR)))
            }
            if allVariants.isEmpty { return 2 }
            guard let prevDiff = prevDiff else {
                if allVariants.count != 1 { return 4 }
                let v = allVariants[0]
                diff.rows[v.0][j].add(tenzor: v.1, koef: -1)
                continue
            }
            if tryOneFromVariants(j, diff, prevDiff, allVariants, all) { continue }
            if tryTwoFromVariants(j, diff, prevDiff, allVariants, all) { continue }
            var nGoodVariants = 0
            var isOk = false
            var t = 1
            let t1 = (PathAlg.charK == 2) ? 2 : 3
            for _ in 1 ... allVariants.count { t *= t1 }
            for k in 1 ..< t {
                var k2 = k
                var p = 0
                var nonZeroCnt = 0
                while k2 > 0 {
                    let k3 = k2 % t1
                    if k3 != 0 {
                        let v = allVariants[p]
                        diff.rows[v.0][j].add(tenzor: v.1, koef: k3 == 2 ? -1 : 1)
                        nonZeroCnt += 1
                    }
                    p += 1
                    k2 /= t1
                }
                if Matrix(mult: prevDiff, and: diff, column: j).isZero {
                    if nonZeroCnt < 3 && !all {
                        OutputFile.writeLog(.error, "nonZeroCnt=\(nonZeroCnt)")
                        return 5
                    }
                    if all {
                        nGoodVariants += 1
                        //OutputFile.writeLog(.normal, "Col \(j): cnt=\(nonZeroCnt)")
                        //PrintUtils.printMatrixColumn("Col \(j): cnt=\(nonZeroCnt)", diff, j)
                    } else {
                        isOk = true
                        break
                    }
                }
                for v in allVariants {
                    diff.rows[v.0][j].clear()
                }
            }
            if !isOk {
                if !all {
                    OutputFile.writeLog(.error, "Can't find \(j)-th column, variants="
                                        + allVariants.map { "\($0.0): \($0.1.str)" }.joined(separator: ", "))
                    hasBadColumns = true
                } else {
                    //OutputFile.writeLog(.normal, "Col \(j): \(nGoodVariants) variants")
                }
            }
            if all && nGoodVariants != 1 {
                OutputFile.writeLog(.error, "Col \(j): has many variants")
                return 6
            }
        }
        if hasBadColumns { return 3 }
        return 0
    }

    private static func tryOneFromVariants(_ j: Int, _ diff: Diff, _ prevDiff: Diff,
                                           _ allVariants: [(Int, Tenzor)],
                                           _ all: Bool) -> Bool {
        var nGoodVariants = 0
        for v in allVariants {
            for mode in 0 ... 1 {
                diff.rows[v.0][j].add(tenzor: v.1, koef: mode == 0 ? 1 : -1)
                if Matrix(mult: prevDiff, and: diff, column: j).isZero {
                    if all {
                        nGoodVariants += 1
                    } else {
                        return true
                    }
                }
                diff.rows[v.0][j].clear()
            }
        }
        if all {
            if nGoodVariants > 1 {
                OutputFile.writeLog(.error, "Col \(j): many one \(nGoodVariants)!")
            }
        }
        return nGoodVariants == 1
    }

    private static func tryTwoFromVariants(_ j: Int, _ diff: Diff, _ prevDiff: Diff,
                                           _ allVariants: [(Int, Tenzor)], _ all: Bool) -> Bool {
        var nGoodVariants = 0
        for (i, v1) in allVariants.enumerated() {
            if i == allVariants.count - 1 { continue }
            for k in i + 1 ..< allVariants.count {
                let v2 = allVariants[k]
                for mode in 0 ... 3 {
                    diff.rows[v1.0][j].add(tenzor: v1.1, koef: mode < 2 ? 1 : -1)
                    diff.rows[v2.0][j].add(tenzor: v2.1, koef: mode == 0 || mode == 2 ? 1 : -1)
                    if Matrix(mult: prevDiff, and: diff, column: j).isZero {
                        if all {
                            nGoodVariants += 1
                        } else {
                            return true
                        }
                    }
                    diff.rows[v1.0][j].clear()
                    diff.rows[v2.0][j].clear()
                }
            }
        }
        if all {
            if nGoodVariants > 1 {
                OutputFile.writeLog(.error, "Col \(j): many one \(nGoodVariants)!")
            }
        }
        return nGoodVariants == 1
    }
}

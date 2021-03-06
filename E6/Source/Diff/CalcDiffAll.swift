//
//  CalcDiffAll.swift
//  E7
//
//  Created by M on 26/03/2019.
//

import Foundation

class CalcDiffIterator {
    private let deg: Int
    private let prevDiff: Diff
    private var diff: Diff
    private let poses: CalcDiffPoses

    init(deg: Int, prevDiff: Diff, diff: Diff, variants: [[Int]]) {
        self.deg = deg
        self.prevDiff = prevDiff
        self.diff = diff
        poses = CalcDiffPoses(variants: variants)
    }

    var currentDiff: Diff {
        return diff
    }

    var nextDiff: Diff? {
        guard let pp = poses.next else { return nil }
        let resut = CalcDiffAll.calcDiffWithNumber(deg: deg, prevDiff: prevDiff, variants: pp)
        diff = resut.0!
        return diff
    }
}

class CalcDiffPoses {
    private let variants: [[Int]]
    private var current: [Int]

    init(variants: [[Int]]) {
        self.variants = variants
        current = variants.map { _ in 0 }
    }

    var next: [Int: Int]? {
        guard variants.count > 0 else { return nil }
        var i = 0
        while true {
            if current[i] < variants[i].count - 1 {
                current[i] += 1
                break
            }
            current[i] = 0
            if i == variants.count - 1 { return nil }
            i += 1
        }
        var result: [Int: Int] = [:]
        for i in 0 ..< current.count {
            result[i] = variants[i][current[i]]
        }
        return result
    }
}

struct CalcDiffAll {
    private static var diffs: [CalcDiffIterator] = []
    private static var curDiff = 0

    static func calcDiffAllVariants() -> Bool {
        let diff = calcZeroDiff()
        if diff.1 != 0 {
            OutputFile.writeLog(.error, "deg=0: Err \(diff.1)")
            return false
        }
        diffs = [CalcDiffIterator(deg: 0, prevDiff: Diff(), diff: diff.0!, variants: [])]
        //PrintUtils.printMatrix("Diff 0", diffs[0].currentDiff)
        curDiff = 1
        while true {
            DiffProgram.diffProgram(diffs[curDiff - 1].currentDiff, deg: curDiff - 1)
            if curDiff > PathAlg.twistPeriod { break }
            if diffs.count == curDiff {
                let result = calcDiffWithNumber(deg: curDiff, prevDiff: diffs[curDiff - 1].currentDiff, variants: nil)
                if result.2 != 0 {
                    if result.2 != 16 {
                        OutputFile.writeLog(.error, "Err \(result.2)")
                        return false
                    }
                    if curDiff == 1 { return false }
                    OutputFile.writeLog(.normal, "back-1")
                    curDiff -= 1
                } else {
                    //PrintUtils.printMatrix("Diff \(curDiff)", result.0!)
                    let multRes = Diff(mult: diffs[curDiff - 1].currentDiff, and: result.0!)
                    if !multRes.isZero {
                        PrintUtils.printMatrix("multRes", multRes)
                        return false
                    }

                    diffs += [CalcDiffIterator(deg: curDiff, prevDiff: diffs[curDiff - 1].currentDiff,
                                               diff: result.0!, variants: result.1!)]
                    //OutputFile.writeLog(.normal, "push \(result.1!)")
                    curDiff += 1
                }
                continue
            }
            if diffs[curDiff].nextDiff != nil {
                OutputFile.writeLog(.normal, "next")
                curDiff += 1
            } else {
                if curDiff == 1 { return false }
                OutputFile.writeLog(.normal, "back-2")
                _ = diffs.popLast()
                curDiff -= 1
            }
            if curDiff > 7 { break }
        }

        return true
    }

    private static func calcZeroDiff() -> (Diff?, Int) {
        let qFrom = BimodQ(deg: 1)
        let qTo = BimodQ(deg: 0)
        let checkDiff = Diff()
        if fillCheckMatrix(deg: 0, checkDiff: checkDiff) != 0 { return (nil, 1) }

        let res = CalcDiff.createZeroDiff(checkDiff, qFrom: qFrom, qTo: qTo)
        if res != 0 { return (nil, res) }
        return (checkDiff, 0)
    }

    fileprivate static func calcDiffWithNumber(deg: Int, prevDiff: Diff, variants: [Int: Int]?) -> (Diff?, [[Int]]?, Int) {
        let d = deg % PathAlg.twistPeriod

        let qFrom = BimodQ(deg: d + 1)
        let qTo = BimodQ(deg: d)
        let checkDiff = Diff()
        if fillCheckMatrix(deg: deg, checkDiff: checkDiff) != 0 { return (nil, nil, 1) }
        let allVariants = createNonZeroDiff(checkDiff, qFrom: qFrom, qTo: qTo, prevDiff: prevDiff, variants: variants)
        if allVariants == nil { return (nil, nil, 16) }
        let multRes = Diff(mult: prevDiff, and: checkDiff)
        if !multRes.isZero {
            PrintUtils.printMatrixDeg("Prev diff", prevDiff, deg, deg - 1)
            PrintUtils.printMatrixDeg("Diff", checkDiff, deg, deg - 1)
            PrintUtils.printMatrixDeg("multRes", multRes, deg + 1, deg)
            return (nil, nil, 9)
        }
        checkDiff.twist(deg)
        return (checkDiff, allVariants, 0)
    }

    private static func createNonZeroDiff(_ diff: Diff, qFrom: BimodQ, qTo: BimodQ, prevDiff: Diff, variants: [Int: Int]?) -> [[Int]]? {
        let s = PathAlg.s
        var allVariants: [[Int]] = []
        for j in 0 ..< qFrom.pij.count {
            guard j % s == 0 else {
                for i in 0 ..< qTo.pij.count {
                    let c1 = diff.rows[i][j]
                    if !c1.isZero || c1.isOnlyZero { continue }
                    let wL = Way(from: qTo.pij[i].0, to: qFrom.pij[j].0)
                    let wR = Way(from: qFrom.pij[j].1, to:qTo.pij[i].1)
                    guard !wL.isZero && !wR.isZero else { continue }
                    let koefComb = j % s == s - 1 && i % s == 0 ? diff.rows[i+s-1][j-1] : diff.rows[i-1][j-1]
                    if koefComb.isZero { continue }
                    c1.addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: koefComb.content[0].koef))
                }
                continue
            }
            var col: [Comb] = []
            var sz = 0
            for i in 0 ..< qTo.pij.count {
                let c1 = diff.rows[i][j]
                if !c1.isZero || c1.isOnlyZero { col.append(c1); continue }
                let wL = Way(from: qTo.pij[i].0, to: qFrom.pij[j].0)
                let wR = Way(from: qFrom.pij[j].1, to:qTo.pij[i].1)
                if !wL.isZero && !wR.isZero {
                    let c = Comb(tenzor: Tenzor(left: wL, right: wR), koef: 1)
                    let matrix = Diff(zeroMatrix: 1, h: qTo.pij.count)
                    matrix.rows[i][0].addComb(c)
                    if !Diff(mult: prevDiff, and: matrix).isZero {
                        col.append(Comb(tenzor: Tenzor(left: wL, right: wR), koef: 1))
                        sz += 1
                    } else {
                        print("Zero! \(c.htmlStr)\n")
                        col.append(Comb())
                    }
                } else {
                    col.append(Comb())
                }
            }

            var kk: Int
            if let variants = variants {
                kk = variants[j / s]!
            } else {
                var vv: [(Int, Int)] = []
                var count = 1; for _ in 0 ..< sz { count *= 3 }
                var weight = 0
                for k in 0 ..< count {
                    var kk = k
                    for i in 0 ..< col.count {
                        let c = col[i]
                        guard !c.isFirstStep && !c.isZero else { continue }
                        diff.rows[i][j].setComb(c)
                        diff.rows[i][j].compKoef(kk % 3 == 2 ? -1 : Double(kk % 3))
                        if kk % 3 != 0 { weight += 1 }
                        kk /= 3
                    }
                    if Diff(mult: prevDiff, and: diff, col2: j).isZero { vv += [(k, weight)] }
                }
                guard vv.count != 0 else {
                    PrintUtils.printMatrix("Prev diff", prevDiff, redColumns: [j])
                    return nil
                }
                kk = vv[0].0
                allVariants += [vv.map { $0.0 }]
            }
            for i in 0 ..< col.count {
                let c = col[i]
                guard !c.isFirstStep && !c.isZero else { continue }
                diff.rows[i][j].setComb(c)
                diff.rows[i][j].compKoef(kk % 3 == 2 ? -1 : Double(kk % 3))
                kk /= 3
            }
        }
        return allVariants
    }

    static func fillCheckMatrix(deg: Int, checkDiff: Diff) -> Int {
        let s = PathAlg.s
        let d = deg % PathAlg.twistPeriod
        let qFrom = BimodQ(deg: d + 1)
        let qTo = BimodQ(deg: d)
        checkDiff.makeZeroMatrix(qFrom.pij.count, h: qTo.pij.count)

        var col = 0
        var row = 0
        for nSq in 0 ..< qFrom.sizes.count {
            for i in 0 ..< qTo.sizes[nSq] {
                for j in 0 ..< qFrom.sizes[nSq] {
                    for k in 0 ..< s {
                        let ii = row + i * s + k
                        let jj = col + j * s + k

                        let fromSz = qFrom.sizes[nSq]
                        let toSz   = qTo.sizes[nSq]

                        let wL = Way(from: qTo.pij[ii].0, to: qFrom.pij[jj].0, noZeroLen: true)
                        let wR = Way(from: qFrom.pij[jj].1, to: qTo.pij[ii].1)

                        let isOnlyZero = (fromSz == 3 && toSz == 2 && i == 1 && j == 1)
                            || (fromSz == 3 && toSz == 2 && i == 0 && j == 2)
                            || (fromSz == 2 && toSz == 2 && i == 0 && j == 1)
                            || (fromSz == 2 && toSz == 3 && i == 0 && j == 1)
                            || (fromSz == 2 && toSz == 3 && i == 2 && j == 1)
                        if isOnlyZero {
                            checkDiff.rows[ii][jj].isOnlyZero = true
                            continue
                        }
                        if wL.isZero || wR.isZero {
                            OutputFile.writeLog(.error, "deg=\(deg), row=\(ii), col=\(jj), fromSz=\(fromSz), toSz=\(toSz)")
                            PrintUtils.printMatrixDeg("", checkDiff, deg + 1, deg)
                            return 1
                        }
                        if wR.len != 0 {
                            PrintUtils.printMatrixDeg("", checkDiff, deg + 1, deg)
                            return 2
                        }
                        let c = Comb(tenzor: Tenzor(left: wL, right: wR), koef: 1)

                        if (toSz == 2 && fromSz == 1 && i == 1)
                            || (fromSz == 2 && toSz == 3 && i == 1 && j == 0)
                            || (fromSz == 2 && toSz == 3 && i == 2 && j == 0) { c.compKoef(-1) }
                        if fromSz == 2 && toSz == 2 && i == 1 && j == 0 {
                            let w1L = Way(from: qTo.pij[ii].0, to: qFrom.pij[jj + s].0, noZeroLen: true)
                            if w1L.len == 2 { c.compKoef(-1) }
                        }

                        checkDiff.rows[ii][jj].addComb(c)
                        checkDiff.rows[ii][jj].isFirstStep = true
                    }
                }
            }
            col += s * qFrom.sizes[nSq]
            row += s * qTo.sizes[nSq]
        }
        return 0
    }
}


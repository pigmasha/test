//
//  Step_1_calc_s.swift
//  Created by M on 15.05.2022.
//

import Foundation

struct Step_1_calc_s {
    enum PrintMode {
        case none, all, matrix, bimod
    }
    private static let printMode = PrintMode.matrix
    private static let processPDiff = true
    private static let completePDiff = true
    private static let checkPBimod = true

    static func runCase() -> Bool {
        for i in 1 ... PathAlg.n + 1 {
            if processS(i) { return true }
        }
        return false
    }

    private static func matrixFromKer(_ myKer: PElements) -> PMatrix {
        let matrix = PMatrix(w: myKer.items.count, h: myKer.items[0].count)
        for i in 0 ..< myKer.items[0].count {
            for j in 0 ..< myKer.items.count {
                matrix.rows[i][j].add(element: myKer.items[j][i])
            }
        }
        return matrix
    }

    private static func homoFromKer(_ myKer: PElements, _ d: Int, _ lastHomo: PHomo) -> PHomo {
        return PHomo(deg: d,
                     from: myKer.items.map { $0.first{ !$0.isZero }!.contents[0].1.endVertex },
                     to: lastHomo.from,
                     matrix: matrixFromKer(myKer))
    }

    private static func processS(_ i: Int) -> Bool {
        if PathAlg.isTex {
            OutputFile.writeLog(.simple, "\\begin{center}{\\large $\\mathbf{S_{\(i)}}$}\\end{center}\n\n")
        } else {
            OutputFile.writeLog(.bold, "S" + Utils.subStr(i))
        }
        var homos: [PHomo] = []
        var lastHomo = PHomo(deg: -1, from: [i], to: [i], matrix: PMatrix(w: 1, h: 1))
        lastHomo.matrix.rows[0][0].add(way: Way(two: i), koef: 1)
        homos.append(lastHomo)
        for d in 0 ... PathAlg.alg.someNumber {
            let kerSz: Int
            if lastHomo.deg > -1 {
                let im = PKer.im(lastHomo)
                let imRk = KoefIntMatrix(elements: im.items).rank
                let imSz = lastHomo.from.reduce(0, { $0 + PKer.pSize($1) })
                kerSz = imSz - imRk
            } else {
                kerSz = -1
            }
            if completePDiff && kerSz > -1 {
                let diff = PDiff(deg: d, i: i)
                guard let hh = checkAndConvert(diff, lastHomo, kerSz) else { return true }
                lastHomo = hh
                printHomo(lastHomo, deg: d)
                if checkPBimod && !checkP(lastHomo, i) { return true }
                if printMode != .bimod { OutputFile.writeLog(.normal, "\(d): checked :)") }
                continue
            }
            guard let myKer = PKer.ker(lastHomo, kerSz) else { return true }
            let homo = homoFromKer(myKer, d, lastHomo)
            if !checkHomo(homo) { return true }
            if !checkExact(homo, lastHomo, ker: myKer) { return true }
            lastHomo = homo
            if checkPBimod && !checkP(lastHomo, i) { return true }
            homos.append(lastHomo)
            if processPDiff {
                if !checkPDiff(d, i, homo.matrix, lastHomo) { return true }
            } else if d % 4 == 2 {
                 printHomo(lastHomo, deg: d)
            }
        }
        return false
    }

    private static func checkPDiff(_ d: Int, _ i: Int, _ matrix: PMatrix, _ lastHomo: PHomo) -> Bool {
        let diff = PDiff(deg: d, i: i)
        if diff.width != matrix.width || diff.height != matrix.height {
            OutputFile.writeLog(.error, "Bad PDiff size deg \(d): \(diff.width) x \(diff.height)")
            return false
        }
        if !diff.isZero && diff.numberOfDifferents(with: matrix) != 0 {
            PrintUtils.printPMatrix("Diff", diff)
            printHomo(lastHomo, deg: d)
            printHomoDiff(diff, matrix)
            OutputFile.writeLog(.error, "Bad diff, nDifferents=\(diff.numberOfDifferents(with: matrix))")
            return false
        }
        if !diff.isZero {
            OutputFile.writeLog(.normal, "\(d): checked :)")
        }
        if d % 4 == 3 && diff.isZero { printHomo(lastHomo, deg: d) }
        return true
    }

    private static func checkAndConvert(_ diff: PDiff, _ lastHomo: PHomo, _ kerSz: Int) -> PHomo? {
        let mult = PMatrix(mult: lastHomo.matrix, and: diff)
        if !mult.isZero {
            PrintUtils.printPMatrix("Bad diff", diff)
            OutputFile.writeLog(.error, "checkAndConvert: d^2 not zero, columns: \(mult.nonZeroColumns)")
            return nil
        }
        let rk = KoefIntMatrix(matrix: diff).rank
        if rk != diff.width {
            OutputFile.writeLog(.error, "checkAndConvert: bad rank \(rk)")
            return nil
        }
        var bigElements: [[Element]] = []
        for c in 0 ..< diff.width {
            for w in Way.allWays {
                if w.len == 0 { continue }
                var elem: [Element] = []
                for row in diff.rows {
                    let e = Element(element: row[c])
                    e.compLeft(element: Element(way: w))
                    elem.append(e)
                }
                if elem.isZero { continue }
                if bigElements.contains(where: { $0.eqKoef(elem) != 0 }) { continue }
                bigElements.append(elem)
            }
        }
        let bigSz = KoefIntMatrix(elements: bigElements).rank
        if diff.width + bigSz != kerSz {
            OutputFile.writeLog(.error, "Bad ker count, should be \(kerSz); diff has \(diff.width) elements + \(bigSz) big elements")
            return nil
        }
        guard let homo = homoFromPDiff(diff) else { return nil }
        if homo.to.count != lastHomo.from.count {
            OutputFile.writeLog(.error, "checkAndConvert: various counts, homo.to=\(homo.to), lastHomo.from=\(lastHomo.from)")
            return nil
        }
        for (i, j) in zip(homo.to, lastHomo.from) {
            if i != j {
                OutputFile.writeLog(.error, "checkAndConvert: array not equal, homo.to=\(homo.to), lastHomo.from=\(lastHomo.from)")
                return nil
            }
        }
        return homo
    }

    private static func checkP(_ homo: PHomo, _ i: Int) -> Bool {
        let b = PBimodQ(deg: homo.deg, i: i)
        if b.p.isEmpty {
            OutputFile.writeLog(.normal, "\(homo.deg): \(homo.to), count=\(homo.to.count)")
            return true
        }
        if b.p.count != homo.to.count {
            OutputFile.writeLog(.error, "checkP: bad bimod size \(b.p.count), should be \(homo.to.count) (\(homo.to))")
            return false
        }
        for (i, p) in b.p.enumerated() {
            if p != homo.to[i] {
                OutputFile.writeLog(.error, "checkP: bad \(i)-th element, array should be \(homo.to)")
                return false
            }
        }
        return true
    }

    private static func homoFromPDiff(_ diff: PDiff) -> PHomo? {
        var to: [Int] = []
        for row in diff.rows {
            var startVertex = -1
            for e in row {
                if e.isZero { continue }
                if e.contents.count != 1 { OutputFile.writeLog(.error, "homoFromPDiff: complex element: " + e.str); return nil }
                let w = e.contents[0].1
                if w.len != 1 { OutputFile.writeLog(.error, "homoFromPDiff: way length not 1: " + e.str); return nil }
                if startVertex < 0 {
                    startVertex = w.startVertex
                } else if startVertex != w.startVertex {
                    OutputFile.writeLog(.error, "homoFromPDiff: various start vertices: " + e.str)
                    return nil
                }
            }
            if startVertex < 0 { OutputFile.writeLog(.error, "homoFromPDiff: zero line"); return nil }
            to.append(startVertex)
        }
        var from: [Int] = []
        for j in 0 ..< diff.rows[0].count {
            var endVertex = -1
            for row in diff.rows {
                let e = row[j]
                if e.isZero { continue }
                let w = e.contents[0].1
                if endVertex < 0 {
                    endVertex = w.endVertex
                } else if endVertex != w.endVertex {
                    OutputFile.writeLog(.error, "homoFromPDiff: various end vertices: " + e.str)
                    return nil
                }
            }
            if endVertex < 0 { OutputFile.writeLog(.error, "homoFromPDiff: zero column: \(j)"); return nil }
            from.append(endVertex)
        }
        return PHomo(deg: diff.deg, from: from, to: to, matrix: diff)
    }

    private static func checkHomo(_ homo: PHomo) -> Bool {
        if homo.matrix.width != homo.from.count {
            OutputFile.writeLog(.error, "checkHomo: bad matrix width")
            return false
        }
        if homo.matrix.height != homo.to.count {
            OutputFile.writeLog(.error, "checkHomo: bad matrix height")
            return false
        }
        for i in 0 ..< homo.matrix.height {
            for j in 0 ..< homo.matrix.width {
                let c = homo.matrix.rows[i][j]
                if c.isZero { continue }
                if c.contents.count != 1 {
                    OutputFile.writeLog(.error, "checkHomo: more than 1 way at [\(i)][\(j)]: \(c.str)")
                    return false
                }
                let w = c.contents[0].1
                if w.len != 1 {
                    OutputFile.writeLog(.error, "checkHomo: way len not 1 at [\(i)][\(j)]: \(c.str)")
                    return false
                }
                if w.startVertex != homo.to[i] {
                    OutputFile.writeLog(.error, "checkHomo: bad startVertex at [\(i)][\(j)]: \(c.str)")
                    return false
                }
                if w.endVertex != homo.from[j] {
                    OutputFile.writeLog(.error, "checkHomo: bad startVertex at [\(i)][\(j)]: \(c.str)")
                    return false
                }
            }
        }
        let rk = KoefIntMatrix(matrix: homo.matrix).rank
        if rk != homo.matrix.width {
            OutputFile.writeLog(.error, "checkHomo: bad rank \(rk)")
            //PrintUtils.printKoefIntMatrix("KK", KoefIntMatrix(matrix: homo.matrix))
            return false
        }
        return true
    }

    private static func printHomo(_ homo: PHomo, deg: Int) {
        switch printMode {
        case .none: break
        case .all:
            let sep = PathAlg.isTex ? "\\oplus " : "&oplus;"
            let fromStr = homo.from.map { "P" + Utils.subStr($0) }.joined(separator: sep)
            let toStr = homo.to.map { "P" + Utils.subStr($0) }.joined(separator: sep)
            let rArr = PathAlg.isTex ? "\\rightarrow " : "&rarr;"
            PrintUtils.printPMatrix("d" + Utils.subStr(deg) + " (\(homo.matrix.width) x \(homo.matrix.height)): " + fromStr + rArr + toStr, homo.matrix)
        case .matrix:
            PrintUtils.printPMatrix("d" + Utils.subStr(deg) + " (\(homo.matrix.width) x \(homo.matrix.height))", homo.matrix)
        case .bimod:
            OutputFile.writeLog(.normal, "\(deg): " + homo.to.map { "\($0)" }.joined(separator: ", ") + "; count=\(homo.to.count)")
        }
    }

    private static func printHomoDiff(_ m1: PMatrix, _ m2: PMatrix) {
        let minRow: () -> Int = {
            for i in 0 ..< m1.height {
                for j in 0 ..< m1.width {
                    let e1 = m1.rows[i][j]
                    let e2 = m2.rows[i][j]
                    if e1.isZero && e2.isZero { continue }
                    if e1.eqKoef(e2) != 1 { return i }
                }
            }
            return -1
        }
        let minCol: () -> Int = {
            for j in 0 ..< m1.width {
                for i in 0 ..< m1.height {
                    let e1 = m1.rows[i][j]
                    let e2 = m2.rows[i][j]
                    if e1.isZero && e2.isZero { continue }
                    if e1.eqKoef(e2) != 1 { return j }
                }
            }
            return -1
        }
        let pos = (minRow(), minCol())
        OutputFile.writeLog(.simple, "<pre>putD(at: (\(pos.0), \(pos.1)))\n")
        OutputFile.writeLog(.simple, "private func putD(at pos: (Int, Int)) {\n")
        for i in 0 ..< m1.height {
            for j in 0 ..< m1.width {
                let e1 = m1.rows[i][j]
                let e2 = m2.rows[i][j]
                if e1.isZero && e2.isZero { continue }
                if e1.eqKoef(e2) == 1 { continue }
                let e = e2.isZero ? e1 : e2
                let w = e.contents[0].1
                let pos1 = (i - pos.0, j - pos.1)
                OutputFile.writeLog(.simple, "    rows[pos.0" + (pos1.0 == 0 ? "" : " + \(pos1.0)")
                                    + "][pos.1" + (pos1.1 == 0 ? "" : " + \(pos1.1)")
                                    + "].add(way: " + w.strProg + ", koef: 1)\n")
            }
        }
        OutputFile.writeLog(.simple, "}</pre>\n")
    }

    //     h_2      h_1
    // Q_3 ---→ Q_2 ---→ Q_1
    private static func checkExact(_ homo1: PHomo, _ homo2: PHomo, ker: PElements) -> Bool {
        let m1 = PMatrix(mult: homo2.matrix, and: homo1.matrix)
        if !m1.isZero {
            OutputFile.writeLog(.error, "checkExact: d2 != 0")
            return false
        }
        return true
    }
}

struct PHomo {
    let deg: Int
    let from: [Int]
    let to: [Int]
    let matrix: PMatrix
}


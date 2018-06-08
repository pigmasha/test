//
//  Created by M on 04.02.18.
//

struct CheckHH {
    enum CheckImResult { case failed, inIm, notInIm }

    static func checkHHElem(_ hh: HHElem, degree: Int) -> Bool {
        let qFrom = BimodQ(deg: degree)
        let qTo = BimodQ(deg: 0)
        guard hh.height == qTo.pij.count else {
            OutputFile.writeLog(.error, "CheckHHElem error! Wrong number of rows")
            return false
        }
        guard hh.width == qFrom.pij.count else {
            OutputFile.writeLog(.error, "CheckHHElem error! Wrong number of columns")
            return false
        }
        for i in 0..<hh.height {
            for j in 0..<hh.width {
                guard !hh.rows[i][j].isZero else { continue }
                let t = hh.rows[i][j].content.first!.tenzor

                let v1 = Vertex(i: qFrom.pij[j].n0)
                let v2 = Vertex(i: qTo.pij[i].n0)
                guard t.leftComponent.endsWith.isEq(v1) else {
                    OutputFile.writeLog(.error, "CheckHHElem error! Bad way at pos \(i), \(j) "
                        + "(left ends in \(t.leftComponent.endsWith.number), must be \(v1.number),"
                        + "way is \(Way(from: v2.number, to: v1.number).str))")
                    PrintUtils.printMatrixDeg("Diff tr", Matrix(transpose: Diff(deg: degree)), degree, degree - 1)
                    return false
                }
                guard t.leftComponent.startsWith.isEq(v2) else {
                    OutputFile.writeLog(.error, "CheckHHElem error! Bad way at pos \(i), \(j) "
                        + "(left starts in \(t.leftComponent.startsWith.number), must be \(v2.number),"
                        + "way is \(Way(from: v2.number, to: v1.number).str)")
                    PrintUtils.printMatrixDeg("Diff tr", Matrix(transpose: Diff(deg: degree)), degree, degree - 1)
                    return false
                }
                guard t.rightComponent.startsWith.isEq(v2) else {
                    OutputFile.writeLog(.error, "CheckHHElem error! Bad way at pos \(i), \(j) "
                        + "(right starts in \(t.rightComponent.startsWith.number), must be \(v2.number)")
                    PrintUtils.printMatrixDeg("Diff tr", Matrix(transpose: Diff(deg: degree)), degree, degree - 1)
                    return false
                }
            }
        }
        guard checkForKer(hh, degree: degree) else {
            OutputFile.writeLog(.error, "CheckHHForKer error!")
            return false
        }
        guard checkForIm(hh, degree: degree, shouldBeInIm: false, logError: true) == .notInIm else {
            OutputFile.writeLog(.error, "CheckHHForIm error!")
            return false
        }
        return true
    }

    private static func checkForKer(_ hh: HHElem, degree: Int) -> Bool {
        let diff = Diff(deg: degree)
        let multResult = Matrix(mult: hh, and: diff)
        guard !multResult.isZero else { return false }

        let charK = PathAlg.charK
        for i in 0 ..< multResult.width {
            var totalKoef = 0.0
            var columnWay: Way?
            for j in 0 ..< multResult.height {
                let c = multResult.rows[j][i]
                for p in c.content {
                    guard p.koef != 0 && !p.tenzor.isZero else { continue }
                    let w = Way(way: p.tenzor.leftComponent)
                    let wR = Way(from: p.tenzor.leftComponent.startsWith.number, to: p.tenzor.rightComponent.endsWith.number)
                    w.compRight(wR)
                    w.compRight(p.tenzor.rightComponent)
                    guard !w.isZero else { continue }

                    if let columnWay = columnWay {
                        guard columnWay.isEq(w) else {
                            OutputFile.writeLog(.error, "CheckHHForKer error: various ways (\(w.htmlStr) and \(columnWay.htmlStr) in column \(i)!")
                            return false
                        }
                    } else {
                        columnWay = Way(way: w)
                    }
                    totalKoef += p.koef
                }
            }
            if (charK > 0 && (Int(totalKoef) % charK) != 0) || (charK == 0 && totalKoef != 0) {
                PrintUtils.printMatrix("HH", hh)
                PrintUtils.printIm("Im", ImMatrix(diff: diff))
                OutputFile.writeLog(.error, "Error in \(i) column")
                return false
            }
        }
        return true
    }

    static func checkForIm(_ hh: Matrix, degree: Int, shouldBeInIm: Bool, logError: Bool) -> CheckImResult {
        guard degree > 0 else { return .notInIm }
        let s = PathAlg.s
        let diff = Diff(deg: degree - 1)
        let im = ImMatrix(diff: diff)
        var hhElem: [WayPair] = [] // line with koefficients

        for i in 0 ..< hh.width {
            var hhWay: Way?
            var hhKoef = 0
            for j in 0 ..< hh.height {
                guard !hh.rows[j][i].isZero else { continue }
                if hh.rows[j][i].content.count != 1 {
                    PrintUtils.printMatrix("Error: multiple comb at [\(j),\(i)]: \(hh.rows[j][i].str), hh:", hh, redColumns: [i])
                    return .failed
                }
                let w = ImMatrix.wayForTenzor(hh.rows[j][i].content[0].tenzor) ?? Way()
                if hhWay == nil {
                    hhWay = w
                } else {
                    if (hhWay!.isZero != w.isZero) || (!w.isZero && !w.isEq(hhWay!)) {
                        PrintUtils.printMatrix("Error: different ways at column \(i), hh:", hh, redColumns: [i])
                        return .failed
                    }
                }
                hhKoef += Int(hh.rows[j][i].content[0].koef)
            }
            guard let w = hhWay else { hhElem += [ WayPair() ]; continue }

            for j in 0 ..< im.height {
                if im.rows[j][i].koef != 0, let ww = im.rows[j][i].way, !ww.isZero {
                    if !ww.isEq(w) {
                        PrintUtils.printMatrix("Error: different ways at column \(i), hh:", hh, redColumns: [i])
                        return .failed
                    }
                    if s == 1 && ww.len == 4 && w.len == 0 {
                        return .notInIm
                    }
                }
            }
            hhElem += [ WayPair(way: w, koef: Double(hhKoef)) ]
        }
        let dimIm = KoefIntMatrix(im: im).rank
        im.addRow(hhElem)
        if im.rows.count == 0 {
            OutputFile.writeLog(.error, "Error: bad row size \(hhElem.count)")
            return .failed
        }
        let dimImAdd = KoefIntMatrix(im: im).rank
        if logError && ((dimImAdd == dimIm && !shouldBeInIm) || (dimImAdd > dimIm && shouldBeInIm)) {
            PrintUtils.printMatrix("HH", hh)
            PrintUtils.printIm("Im", im)
            OutputFile.writeLog(.normal, "dim=\(dimImAdd)")
        }
        return dimImAdd == dimIm ? .inIm : .notInIm
    }
}

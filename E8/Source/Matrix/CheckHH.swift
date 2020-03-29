//
//  Created by M on 04.02.18.
//

struct CheckHH {
    enum CheckImResult { case failed, inIm, notInIm }

    static func checkHHElem(_ hh: HHElem, degree: Int, logError: Bool) -> Bool {
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

                let v1 = Vertex(i: qFrom.pij[j].0)
                let v2 = Vertex(i: qTo.pij[i].0)
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
        guard checkForKer(hh, degree: degree, logError: logError) else {
            if logError { OutputFile.writeLog(.error, "CheckHHForKer error!") }
            return false
        }
        guard checkForIm(hh, degree: degree, shouldBeInIm: false, logError: logError) == .notInIm else {
            if logError { OutputFile.writeLog(.error, "CheckHHForIm error!") }
            return false
        }
        return true
    }

    static func checkHHElem2(_ hh: HHElem, degree: Int, logError: Bool) -> Bool {
        guard checkForKer(hh, degree: degree, logError: logError) else {
            if logError { OutputFile.writeLog(.error, "CheckHHForKer error!") }
            return false
        }
        guard checkForIm(hh, degree: degree, shouldBeInIm: false, logError: logError) == .notInIm else {
            if logError { OutputFile.writeLog(.error, "CheckHHForIm error!") }
            return false
        }
        return true
    }

    private static func checkForKer(_ hh: HHElem, degree: Int, logError: Bool) -> Bool {
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
                if logError {
                    PrintUtils.printMatrix("HH", hh)
                    PrintUtils.printIm("Im", ImMatrix(diff: diff), deg: degree)
                    OutputFile.writeLog(.error, "Error in \(i) column")
                }
                return false
            }
        }
        return true
    }

    static func checkForIm(_ hh: Matrix, degree: Int, shouldBeInIm: Bool, logError: Bool) -> CheckImResult {
        guard degree > 0 else { return hh.isZero ? .inIm : .notInIm }
        guard let (hhElem, zeroCols) = waysAndZeroCols(for: hh, degree: degree) else {
            return .failed
        }

        let im = ImMatrix(diff: Diff(deg: degree - 1))
        let dimIm = KoefIntMatrix(im: im, zeroCols: zeroCols).rank
        let koefMatrix = KoefIntMatrix(im: im, zeroCols: zeroCols)
        koefMatrix.addRow(hhElem)
        if koefMatrix.rows.count == 0 {
            OutputFile.writeLog(.error, "Error: bad row size \(hhElem.count)")
            return .failed
        }
        let dimImAdd = koefMatrix.rank
        if logError && ((dimImAdd == dimIm && !shouldBeInIm) || (dimImAdd > dimIm && shouldBeInIm)) {
            PrintUtils.printMatrix("HH", hh)
            PrintUtils.printKoefIntMatrix(KoefIntMatrix(im: im), deg: degree - 1, skipLines: 0)
            OutputFile.writeLog(.normal, "dim=\(dimImAdd)")
        }
        return dimImAdd == dimIm ? .inIm : .notInIm
    }

    static func checkHHElemNotSame(_ hh1: HHElem, _ hh2: HHElem, degree: Int) -> Bool? {
        guard degree > 0 else {
            return checkHHElemNotSameZeroDeg(hh1, hh2)
        }
        guard let (hhElem1, zeroCols1) = waysAndZeroCols(for: hh1, degree: degree),
            let (hhElem2, zeroCols2) = waysAndZeroCols(for: hh2, degree: degree) else {
                return nil
        }
        if (zeroCols1 != zeroCols2) {
            //OutputFile.writeLog(.error, "#checkHHElemNotSame: various zero cols \(zeroCols1) and \(zeroCols2)")
            //PrintUtils.printMatrix("HH1", hh1); PrintUtils.printMatrix("HH2", hh2)
            return true
        }
        let im = ImMatrix(diff: Diff(deg: degree - 1))
        let dimIm = KoefIntMatrix(im: im, zeroCols: zeroCols1).rank
        let koefMatrix = KoefIntMatrix(im: im, zeroCols: zeroCols1)
        koefMatrix.addRow(hhElem1)
        koefMatrix.addRow(hhElem2)
        if koefMatrix.rows.count == 0 {
            OutputFile.writeLog(.error, "#checkHHElemNotSame: bad row size \(hhElem1.count)")
            return nil
        }
        return koefMatrix.rank == dimIm + 2
    }

    static func checkHHElemNotSameZeroDeg(_ hh1: HHElem, _ hh2: HHElem) -> Bool? {
        guard let hhElem1 = wayPairs(for: hh1), let hhElem2 = wayPairs(for: hh2) else {
            return nil
        }
        for i in 0 ..< hhElem1.count {
            if let w1 = hhElem1[i].way, let w2 = hhElem2[i].way, !w1.isEq(w2) {
                //OutputFile.writeLog(.error, "#checkHHElemNotSame: Different ways \(w1) & \(w2)")
                return true
            }
        }
        let koefMatrix = KoefIntMatrix(size: 0)
        koefMatrix.addRow(hhElem1)
        koefMatrix.addRow(hhElem2)
        return koefMatrix.rank == 2
    }

    private static func wayPairs(for hh: Matrix) -> [WayPair]? {
        var hhElem: [WayPair] = [] // line with koefficients

        for i in 0 ..< hh.width {
            var hhWay: Way?
            var hhKoef = 0
            for j in 0 ..< hh.height {
                guard !hh.rows[j][i].isZero else { continue }
                let content_ji = hh.rows[j][i].content
                if content_ji.count != 1 && content_ji.count != 2 {
                    PrintUtils.printMatrix("Error: multiple comb at [\(j),\(i)]: \(hh.rows[j][i].str), hh:", hh, redColumns: [i])
                    return nil
                }
                let w: Way
                let k: Double
                if content_ji.count == 2 {
                    let w0 = ImMatrix.wayForTenzor(content_ji[0].tenzor) ?? Way()
                    let w1 = ImMatrix.wayForTenzor(content_ji[1].tenzor) ?? Way()
                    if (w0.isZero != w1.isZero) || (!w0.isZero && !w0.isEq(w1)) {
                        PrintUtils.printMatrix("Error: different ways multiple comb at [\(j),\(i)]: \(hh.rows[j][i].str), hh:", hh, redColumns: [i])
                        return nil
                    }
                    w = w0
                    k = content_ji[0].koef + content_ji[1].koef
                } else {
                    w = ImMatrix.wayForTenzor(content_ji[0].tenzor) ?? Way()
                    k = content_ji[0].koef
                }
                if k == 0 { continue }

                if hhWay == nil {
                    hhWay = w
                } else {
                    if (hhWay!.isZero != w.isZero) || (!w.isZero && !w.isEq(hhWay!)) {
                        PrintUtils.printMatrix("Error: different ways at column \(i), hh:", hh, redColumns: [i])
                        return nil
                    }
                }
                hhKoef += Int(k)
            }
            if let w = hhWay {
                hhElem += [ WayPair(way: w, koef: Double(hhKoef)) ]
            } else {
                hhElem += [ WayPair() ];
            }
        }
        return hhElem
    }

    private static func waysAndZeroCols(for hh: Matrix, degree: Int) -> (hhElem: [WayPair], zeroCols: Set<Int>)? {
        guard degree > 0 else { return nil }
        guard let hhElem = wayPairs(for: hh) else { return nil }

        let s = PathAlg.s
        let im = ImMatrix(diff: Diff(deg: degree - 1))
        var zeroCols = Set<Int>()

        for i in 0 ..< hh.width {
            guard let w = hhElem[i].way, !w.isZero else { continue }
            for j in 0 ..< im.height {
                if im.rows[j][i].koef != 0, let ww = im.rows[j][i].way, !ww.isZero {
                    if s == 1 && ww.len >= 4 && w.len == 0
                        && ww.startsWith.number == w.startsWith.number && ww.endsWith.number == w.endsWith.number {
                        zeroCols.insert(i)
                        continue
                    }
                    if !ww.isEq(w) {
                        PrintUtils.printMatrix("Error: different ways \(ww.str), \(w.str) at column \(i) (deg=\(degree)), hh:", hh, redColumns: [i])
                        PrintUtils.printIm("Im", im, deg: degree - 1)
                        return nil
                    }
                }
            }
        }
        return (hhElem, zeroCols)
    }
}

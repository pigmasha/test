//
//  Created by M on 04.02.18.
//

struct CheckHH {
    static func checkHHElem(_ hh: HHElem, degree: Int) -> Bool {
        let qFrom = BimodQ(forDeg: degree)!
        let qTo = BimodQ(forDeg: 0)!
        guard hh.height == qTo.pij().count else {
            OutputFile.writeLog(.error, "CheckHHElem error! Wrong number of rows")
            return false
        }
        guard hh.width == qFrom.pij().count else {
            OutputFile.writeLog(.error, "CheckHHElem error! Wrong number of columns")
            return false
        }
        for i in 0..<hh.height {
            for j in 0..<hh.width {
                guard !hh.rows[i][j].isZero else { continue }
                let t = hh.rows[i][j].content.first!.tenzor

                let v1 = Vertex(i: qFrom.pij()[j].n0)
                guard t.leftComponent.endsWith.isEq(v1) else {
                    OutputFile.writeLog(.error, "CheckHHElem error! Bad way at pos \(i), \(j) "
                        + "(left ends in \(t.leftComponent.endsWith.number), must be \(v1.number)")
                    PrintUtils.printMatrixDeg("Diff", Diff(deg: degree), degree, degree - 1)
                    return false
                }
                let v2 = Vertex(i: qTo.pij()[i].n0)
                guard t.leftComponent.startsWith.isEq(v2) else {
                    OutputFile.writeLog(.error, "CheckHHElem error! Bad way at pos \(i), \(j) "
                        + "(left starts in \(t.leftComponent.startsWith.number), must be \(v2.number)")
                    PrintUtils.printMatrixDeg("Diff", Diff(deg: degree), degree, degree - 1)
                    return false
                }
                guard t.rightComponent.startsWith.isEq(v2) else {
                    OutputFile.writeLog(.error, "CheckHHElem error! Bad way at pos \(i), \(j) "
                        + "(right starts in \(t.rightComponent.startsWith.number), must be \(v2.number)")
                    PrintUtils.printMatrixDeg("Diff", Diff(deg: degree), degree, degree - 1)
                    return false
                }
            }
        }
        guard checkForKer(hh, degree: degree) else {
            OutputFile.writeLog(.error, "CheckHHForKer error!")
            return false
        }
        guard checkForIm(hh, degree: degree) else {
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
                OutputFile.writeLog(.normal, "Im")
                PrintUtils.printIm(ImMatrix(diff: diff), deg: degree - 1)
                OutputFile.writeLog(.error, "Error in \(i) column")
                return false
            }
        }
        return true
    }

    private static func checkForIm(_ hh: HHElem, degree: Int) -> Bool {
        guard degree > 0 else { return true }
        let s = PathAlg.s
        let diff = Diff(deg: degree - 1)
        let im = ImMatrix(diff: diff)!
        var hhElem: [WayPair] = [] // line with koefficients

        for i in 0 ..< hh.width {
            var j = 0
            while j < hh.height {
                if !hh.rows[j][i].isZero { break }
                j += 1
            }
            if j == hh.height {
                hhElem += [ WayPair(way: nil, koef: 0) ]
                continue
            }
            let tt = hh.rows[j][i].content.first!.tenzor
            let hhKoef = Int(hh.rows[j][i].content.first!.koef)

            let w = Way(way: tt.leftComponent)
            let wR = Way(from: tt.leftComponent.startsWith.number, to: tt.rightComponent.endsWith.number)
            w.compRight(wR)
            w.compRight(tt.rightComponent)

            j = 0
            while j < im.rows().count {
                if im.rows()[j][i].koef != 0, let way = im.rows()[j][i].way, !way.isZero { break }
                j += 1
            }
            if j < im.rows().count {
                let ww = im.rows()[j][i].way!
                let koef = hhKoef * (ww.isEq(w) ? 1 : 0)
                hhElem += [ WayPair(way: ww, koef: Double(koef)) ]
                if s == 1 && ww.len == 4 && w.len == 0 {
                    return true
                }
            } else {
                hhElem += [ WayPair(way: w, koef: Double(hhKoef)) ]
            }
        }
        let dimIm = KoefIntMatrix(im: im)!.rank()
        im.addRow(hhElem)
        if im.rows().count == 0 {
            OutputFile.writeLog(.error, "Error: bad row size \(hhElem.count)")
            return false
        }
        let dimImAdd = KoefIntMatrix(im: im)!.rank()
        if dimImAdd == dimIm {
            OutputFile.writeLog(.normal, "Im")
            PrintUtils.printIm(im, deg: degree - 1)
            OutputFile.writeLog(.normal, "dim=\(dimImAdd)")
        }
        return dimImAdd > dimIm
    }
}

//
//  Created by M on 09.02.18.
//

//
//         d_up
//     Q --------> Q
//     |           |
// hh_s|           |hh
//     |           |
//     v  d_down   V
//     Q --------> Q
//

struct ShiftAlgAll {
    static func allVariants(for hh: HHElem, degree: Int, shift: Int) -> ShiftAllVariants? {
        let multRes = Matrix(mult: hh, and: Diff(deg: degree + shift - 1))
        if multRes.isNil {
            OutputFile.writeLog(.error, "Bad multRes size")
            return nil
        }

        let s = PathAlg.s;
        let width = multRes.width;
        let d_down = Diff(deg: shift - 1)

        var allVariants: [[ShiftVariant]] = []
        for col in stride(from: 0, to: width, by: s) {
            let multRes2 = multRes.submatrixFromCol(col, toCol: col + s)
            let variants = shiftForMultRes(multRes2, dDown: d_down)
            guard variants.count > 0 else { return nil }
            allVariants += [ variants ]
        }

        var seqNumber: [Int] = []
        for variant in allVariants {
            OutputFile.writeLog(.simple, "Count \(variant.count)")
            seqNumber += [0]
        }
        OutputFile.writeLog(.normal, "")
        return ShiftAllVariants(seqNumber: seqNumber, variants: allVariants)
    }

    private static func shiftForMultRes(_ multRes: Matrix!, dDown: Diff) -> [ShiftVariant] {
        let multResW = multRes.width

        var hasNonZeroElements = false
        for i in 0 ..< multRes.height {
            for j in 0 ..< multResW {
                if !multRes.rows[i][j].isZero { hasNonZeroElements = true; break; }
            }
        }

        let s = PathAlg.s
        let height = dDown.width

        if !hasNonZeroElements {
            let hh = HHElem(zeroMatrix: multResW, h: height)
            return [ ShiftVariant(HH: hh, key: nil) ]
        }

        var result: [ShiftVariant] = []

        let rowMask = twoDeg(height / s)

        for r in 1 ..< rowMask {
            let hhElem = HHElem()
            let nDiff = shiftForRowMask(r, multRes: multRes, dDown: dDown, result: hhElem)
            guard nDiff == 0 else { continue }
            var hasHH = false
            for v in result {
                if v.hh.isEq(hhElem, debug: false) {
                    if (v.key!.intValue > r) { v.key!.intValue = r }
                    hasHH = true
                    break
                }
            }
            if !hasHH {
                result += [ ShiftVariant(HH: hhElem, key: NumInt(intValue: r)) ]
            }
        }
        if result.count == 0 {
            PrintUtils.printMatrix("dDown", dDown)
            PrintUtils.printMatrix("multRes", multRes)
        }
        return result
    }

    private static func shiftForRowMask(_ rowMask: Int, multRes: Matrix, dDown: Diff, result hh_shift: HHElem) -> Int {
        let s = PathAlg.s;
        let width = multRes.width
        let height = dDown.width

        var multRes_shift = Matrix(zeroMatrix: width, h: multRes.height)
        hh_shift.makeZeroMatrix(width, h: height)

        var nDifferents = multRes.numberOfDifferents(multRes_shift)
        var step = 0
        while nDifferents > 0 {
            multRes_shift.subtractMatrix(multRes)

            let hh_sub = Matrix(zeroMatrix: width, h: height)
            var cols: [NumInt] = []

            for i in 0 ..< multRes_shift.height {
                for j in 0 ..< multRes_shift.width { // j th column
                    guard !multRes_shift.rows[i][j].isZero else { continue }
                    var goodPos = -1

                    for k in 0 ..< dDown.width {
                        guard !dDown.rows[i][k].isZero && hh_shift.rows[k][j].isZero else { continue }
                        guard rowMask & (1 << Int(k / s)) != 0 else { continue }
                        let div = Tenzor(byDivide: multRes_shift.rows[i][j].firstTenzor!, to: dDown.rows[i][k].firstTenzor!)
                        if !div.isZero { goodPos = k; break; }
                    }
                    // end: find good positions in i th line of d_down
                    guard goodPos > -1 else { continue }

                    let tt = Tenzor(byDivide: multRes_shift.rows[i][j].firstTenzor!, to: dDown.rows[i][goodPos].firstTenzor!)
                    guard !tt.isZero else { continue }

                    let koef = multRes_shift.rows[i][j].firstKoef / dDown.rows[i][goodPos].firstKoef
                    if !cols.contains(NumInt(intValue: j)) {
                        let c = Comb(tenzor: tt, koef: koef)
                        hh_sub.rows[goodPos][j].addComb(c)
                        cols += [ NumInt(intValue: j) ]
                    }
                }
            }
            hh_shift.addMatrix(hh_sub)
            multRes_shift = Matrix(mult: dDown, and: hh_shift)
            nDifferents = multRes.numberOfDifferents(multRes_shift)

            if step > 5 { break }
            step += 1
        }
        return nDifferents
    }
}

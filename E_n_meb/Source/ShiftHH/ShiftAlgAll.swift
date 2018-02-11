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
            var variants = shiftForMultRes(multRes2, dDown: d_down, isLast: false)
            if variants.count == 0 { variants = shiftForMultRes(multRes2, dDown: d_down, isLast: true) }
            guard variants.count > 0 else { return nil }
            allVariants += [ variants ]
        }

        var seqNumber: [Int] = []
        for variant in allVariants {
            OutputFile.writeLog(.simple, "Count \(variant.count) ")
            seqNumber += [0]
        }
        OutputFile.writeLog(.normal, "")
        return ShiftAllVariants(seqNumber: seqNumber, variants: allVariants)
    }

    private static func shiftForMultRes(_ multRes: Matrix!, dDown: Diff, isLast: Bool) -> [ShiftVariant] {
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
            let nDiff = shiftForRowMask(r, multRes: multRes, dDown: dDown, isLast: isLast, result: hhElem)
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
        return result
    }

    private static func shiftForRowMask(_ rowMask: Int, multRes: Matrix, dDown: Diff, isLast: Bool, result hh_shift: HHElem) -> Int {
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
            for j in 0 ..< multRes_shift.width { // j th column
                var goodPositions: [Int]?
                var i = 0
                for i0 in 0 ..< multRes_shift.height {
                    guard !multRes_shift.rows[i0][j].isZero else { continue }
                    var goodPoses: [Int] = []
                    for k in 0 ..< dDown.width {
                        guard !dDown.rows[i0][k].isZero && hh_shift.rows[k][j].isZero else { continue }
                        guard rowMask & (1 << Int(k / s)) != 0 else { continue }
                        let div = Tenzor(byDivide: multRes_shift.rows[i0][j].firstTenzor!, to: dDown.rows[i0][k].firstTenzor!)
                        if !div.isZero { goodPoses += [k] }
                    }
                    guard goodPoses.count > 0 else { continue }
                    if goodPositions == nil || goodPositions!.count > goodPoses.count {
                        goodPositions = goodPoses
                        i = i0
                    }
                    if goodPoses.count == 1 { break }
                }
                guard let goodPos = isLast ? goodPositions?.last : goodPositions?.first else { continue }

                let tt = Tenzor(byDivide: multRes_shift.rows[i][j].firstTenzor!, to: dDown.rows[i][goodPos].firstTenzor!)
                guard !tt.isZero else { continue }

                var koef = multRes_shift.rows[i][j].firstKoef / dDown.rows[i][goodPos].firstKoef
                if PathAlg.charK == 3 && koef == -2 { koef = 1 }
                if PathAlg.charK == 3 && koef == 2 { koef = -1 }
                hh_sub.rows[goodPos][j].addComb(Comb(tenzor: tt, koef: koef))
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

//
//  Created by M on 09.02.18.
//

struct ShiftAllSelect {
    static func hhFrom(_ allVariants: ShiftAllVariants) -> HHElem {
        let s = PathAlg.s
        let width = allVariants.variants.count * s
        let height = allVariants.variants.last!.last!.hh.height
        let hh = HHElem(zeroMatrix: width, h: height)

        for i in 0 ..< allVariants.variants.count {
            let variants = allVariants.variants[i]
            if variants.count > 0 {
                hh.addMatrixX(variants[allVariants.seqNumber[i]].hh, x: i * s)
            }
        }
        return hh
    }

    static func select(from allVariants: ShiftAllVariants, type: Int, shift: Int) -> HHElem {
        guard type != 4 else { return hhFrom(allVariants) }

        let s = PathAlg.s
        let width = allVariants.variants.count * s
        let height = allVariants.variants.last!.last!.hh.height
        let hh = HHElem(zeroMatrix: width, h: height)

        var col = 0
        for variants in allVariants.variants {
            if type == 3 && shift % 11 == 10 && (col >= 5 * s || col < s) {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else if (type == 3 && shift % 11 == 8) || type == 5 {
                var minVar = variants[0]
                for v in variants {
                    if shift % 11 == 1 && v.nonZeroCnt <= minVar.nonZeroCnt {
                        minVar = v
                    } else if shift != 1 && v.nonZeroCnt < minVar.nonZeroCnt {
                        minVar = v
                    }
                }
                hh.addMatrixX(minVar.hh, x: col)
            } else if type == 6 && shift % 11 == 10 && col >= 2 * s {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else {
                hh.addMatrixX(variants[0].hh, x: col)
            }
            col += s
        }
        return hh
    }

    static func lastHH(from allVariants: ShiftAllVariants!, firstHH: HHElem!) -> HHElem {
        let s = PathAlg.s
        let width = allVariants.variants.count * s
        let height = allVariants.variants.last!.last!.hh.height
        let hh = HHElem(zeroMatrix: width, h: height)

        for i in 0 ..< allVariants.variants.count {
            let variants = allVariants.variants[i]
            guard variants.count > 0 else { continue }
            var variant = variants[allVariants.seqNumber[i]]
            for v in variants {
                if width == height && hasNonZeroInSq(i, hhCol: v.hh) {
                    variant = v
                }
                if (width == height + s && hasNonZeroInSq(i - 1, hhCol: v.hh)) {
                    variant = v;
                }
            }
            var firstHHSq = -1
            for j in 0 ..< firstHH.height {
                if !firstHH.rows[j][i * s].isZero { firstHHSq = j / s; break; }
            }
            if firstHHSq < 0 && i > 0 {
                for j in 0 ..< firstHH.height {
                    if !firstHH.rows[j][(i - 1) * s].isZero { firstHHSq = j / s; break; }
                }
            }
            if firstHHSq > -1 {
                for v in variants {
                    if s * (firstHHSq + 1) < firstHH.height && hasNonZeroInSq(firstHHSq + 1, hhCol: v.hh) {
                        variant = v
                    }
                }
                for v in variants {
                    if hasNonZeroInSq(firstHHSq, hhCol: v.hh) {
                        variant = v
                    }
                }
                hh.addMatrixX(variant.hh, x: i * s)
            }
        }
        return hh
    }

    private static func hasNonZeroInSq(_ sq1: Int, hhCol: HHElem) -> Bool {
        let sq = max(sq1, 0)
        for i in 0 ..< PathAlg.s {
            for j in 0 ..< PathAlg.s {
                if !hhCol.rows[sq * PathAlg.s + i][j].isZero { return true }
            }
        }
        return false
    }
}

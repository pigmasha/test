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
        //guard type != 4 else { return hhFrom(allVariants) }

        let s = PathAlg.s
        let width = allVariants.variants.count * s
        let height = allVariants.variants.last!.last!.hh.height
        let hh = HHElem(zeroMatrix: width, h: height)

        var col = 0
        for variants in allVariants.variants {
            if s == 1 {
                if type == 4 && shift == 9 && col == 5 {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 5 && shift == 6 && col == 0 {
                    hh.addMatrixX(variants[7].hh, x: col)
                } else if type == 5 && shift == 9 && col == 2 {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 5 && shift == 9 && col == 4 {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 8 && shift == 9 && col == 0 {
                    hh.addMatrixX(variants[6].hh, x: col)
                } else if type == 8 && shift == 10 && (col == 0 || col == 7) {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 12 && shift == 9 && col == 0 {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 12 && shift == 10 {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 17 && shift == 10 && (col == 2 || col == 4) {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 24 && shift == 9 && col == 0 {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else {
                    hh.addMatrixX(variants[0].hh, x: col)
                }
            } else {
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
            } else if type == 9 && shift % 11 == 9 && col < s {
                hh.addMatrixX(variants[10].hh, x: col)
            } else if type == 9 && shift % 11 == 10 {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else if type == 10 && shift == 10 && ((col >= s && col < 2*s) || (col >= 3*s && col < 5*s)) {
                hh.addMatrixX(variants[1].hh, x: col)
            } else if type == 11 && shift == 9 && col < s {
                hh.addMatrixX(variants[1].hh, x: col)
            } else if (type == 11 || (type == 12 && s > 2) || type == 20 || type == 15) && shift == 10 {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else if type == 17 && shift == 10 && col >= 2*s {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else if type == 20 && shift == 8 && col < s {
                hh.addMatrixX(variants[1].hh, x: col)
            } else if type == 20 && shift == 9 && (col >= 6*s && col < 7*s) {
                hh.addMatrixX(variants[2].hh, x: col)
            } else if type == 12 && shift == 9 && s > 2 && (col >= s && col < 3*s) {
                hh.addMatrixX(variants[1].hh, x: col)
            } else if type == 12 && shift == 9 && s == 2 && col < s {
                hh.addMatrixX(variants[1].hh, x: col)
            } else if type == 12 && s == 2 && shift == 10 && col < 8*s {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else if type == 16 && shift == 10 && col >= 2*s {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else if type == 19 && shift == 9 && s > 2 && (col >= 2*s && col < 3*s) {
                hh.addMatrixX(variants[1].hh, x: col)
            } else if type == 19 && shift == 9 && s == 2 && (col >= s && col < 2*s) {
                hh.addMatrixX(variants[1].hh, x: col)
            } else if type == 19 && shift == 10 && s == 2 && col < 4*s {
                hh.addMatrixX(variants.last!.hh, x: col)
            } else {
                hh.addMatrixX(variants[0].hh, x: col)
            }
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
            if !variant.hh.isZero {
                for v in variants {
                    if minRightLen(hh: v.hh) < minRightLen(hh: variant.hh) {
                        variant = v
                    }
                }
            }
            hh.addMatrixX(variant.hh, x: i * s)
        }
        return hh
    }

    private static func minRightLen(hh: HHElem) -> Int {
        var L = 10
        for row in hh.rows {
            for c in row {
                if !c.isZero {
                    L = min(L, c.content[0].tenzor.rightComponent.len)
                }
            }
        }
        return L == 10 ? 0 : L
    }

    static func isEqual(_ all1: ShiftAllVariants, _ all2: ShiftAllVariants) -> Bool {
        if all1.seqNumber != all2.seqNumber { return false }
        let vv1 = all1.variants
        let vv2 = all2.variants
        if vv1.count != vv2.count { return false }
        for i in 0 ..< vv1.count {
            let v1 = vv1[i]
            let v2 = vv2[i]
            if v1.count != v2.count { return false }
            for j in 0 ..< v1.count {
                let s1 = v1[j]
                let s2 = v2[j]
                if s1.key == nil && s2.key != nil { return false }
                if s1.key != nil && s2.key == nil { return false }
                if let k1 = s1.key, let k2 = s2.key {
                    if k1.intValue != k2.intValue { return false }
                }
                if !s1.hh.isEq(s2.hh, debug: false) { return false }
            }
        }
        return true
    }
}

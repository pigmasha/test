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
                hh.addMatrixX(variants[0].hh, x: col)
            } else {
                if type == 3 && (shift == 15 || shift == 16 && col < s) {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 5 && shift == 16 && col < 2*s && col >= s {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 6 && shift == 15 && col < s {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 6 && shift == 16 && (col < 2*s || col >= 5*s) {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 7 && shift == 16 {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 8 && shift == 16 && (col < 2*s || col >= 11*s) {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 10 && shift == 16 && col >= 4*s && col < 5*s {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 11 && shift == 15 && col < s {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 11 && shift == 16 && col >= 2*s && col < 9*s {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 11 && shift == 16 && col >= 11*s {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 13 && shift == 15 && col >= s && col < 2*s {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 13 && shift == 16 && col >= 2*s && col < 3*s {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 13 && shift == 16 && col >= 3*s && col < 4*s {
                    hh.addMatrixX(variants[2].hh, x: col)
                } else if type == 13 && shift == 16 && col >= 9*s && col < 10*s {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 15 && shift == 16 && col >= s && col < 2*s {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 15 && shift == 16 && col >= 6*s && col < 7*s {
                    hh.addMatrixX(variants.last!.hh, x: col)
                } else if type == 16 && shift == 15 && col < s {
                    hh.addMatrixX(variants[1].hh, x: col)
                } else if type == 16 && shift == 16 {
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

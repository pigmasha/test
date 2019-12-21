//
//  Created by M on 27/01/2019.
//

import Foundation

struct PKerThinUtils {
    static func sumElemsIndexes(_ items: [[WayKoef]]) -> Set<Int> {
        var indexes = Set<Int>()
        if items.count == 0 || items[0].count == 1 { return indexes }
        for i in 0 ..< items.count - 1 {
            for j in i + 1 ..< items.count {
                let sums = sums2(items[i], items[j])
                for ssum in sums {
                    if let ii = items.firstIndex(where: { $0.isEq(ssum) }) {
                        indexes.insert(ii)
                    }
                }
            }
        }
        guard items[0].count >= 3 else {
            return indexes
        }
        for i in 0 ..< items.count - 2 {
            for j in i + 1 ..< items.count - 1 {
                for k in j + 1 ..< items.count {
                    let sums = sums3(items[i], items[j], items[k])
                    for ssum in sums {
                        if let ii = items.firstIndex(where: { $0.isEq(ssum) }) {
                            indexes.insert(ii)
                        }
                    }
                }
            }
        }
        return indexes
    }

    static func nonGenElemsIndexes(_ items: [[WayKoef]]) -> Set<Int> {
        var indexes = Set<Int>()
        for item in items {
            for w in item {
                if w.isZero { continue }
                let allP = PKer.allPWays(w.ways[0].endsWith.number)
                for p in allP {
                    if p.len < 1 { continue }
                    let mult = item.map { $0.compLeft(p) }
                    if mult.isZero { continue }
                    if let ii = items.firstIndex(where: { $0.isEq(mult) }) {
                        indexes.insert(ii)
                    }
                    guard mult.count > 1 else { continue }

                    for i in 0 ..< items.count - 1 {
                        for j in i + 1 ..< items.count {
                            let sums = sums2(items[i], items[j])
                            if sums.contains(where: { $0.isEq(mult) }) {
                                indexes.insert(items[i].nonZeroLen > items[j].nonZeroLen ? i : j)
                            }
                        }
                    }
                }
            }
        }
        return indexes
    }

    static func findSumIndex(_ items: [[WayKoef]]) -> Int? {
        guard items.count > 2 else { return nil }
        for i in 0 ..< items.count - 1 {
            for j in i + 1 ..< items.count {
                let w1 = items[i]
                let w2 = items[j]
                var kk: Int?
                for k in 0 ..< w1.count {
                    guard !w1[k].isZero && !w2[k].isZero else { continue }
                    if w1[k].ways.count != 1 || w2[k].ways.count != 1 { kk = nil; break }
                    if !w1[k].ways[0].isEq(w2[k].ways[0]) || abs(w1[k].koefs[0]) != 1 || abs(w2[k].koefs[0]) != 1 { kk = nil; break }
                    if let k2 = kk {
                        if k2 != w1[k].koefs[0] / w2[k].koefs[0] { kk = nil; break }
                    } else {
                        kk = w1[k].koefs[0] / w2[k].koefs[0]
                    }
                }
                guard let k2 = kk else { continue }
                var sum1: [WayKoef] = []
                for k in 0 ..< w1.count {
                    if !w1[k].isZero && !w2[k].isZero {
                        sum1.append(WayKoef.zero)
                    } else {
                        sum1.append(w1[k].isZero ? k2 == 1 ? w2[k].minus : w2[k] : w1[k])
                    }
                }
                if let ii = items.firstIndex(where: { $0.isEq(sum1) }) {
                    //OutputFile.writeLog(.simple, "$$find sum \(w1.str) + \(-k2) * \(w2.str) = \(sum1.str)$$\n\n")
                    return ii
                }
                if items.firstIndex(where: { sum1.isDividedBy($0) != nil }) != nil {
                    //OutputFile.writeLog(.simple, "$$find divide \(w1.str) + \(-k2) * \(w2.str) = \(sum1.str): \(items[ii].str)$$\n\n")
                    return i
                }
            }
        }
        return findSumIndex4(items)
    }

    private static func findSumIndex4(_ items: [[WayKoef]]) -> Int? {
        guard items.count == 4,
            let i1 = items.firstIndex(where: { !$0[0].isZero }),
            let i2 = items.lastIndex(where: { !$0[0].isZero }), i1 != i2,
            let w3 = items.first(where: { $0[0].isZero }),
            let w4 = items.last(where: { $0[0].isZero }), !w3.isEq(w4) else { return nil }
        let mayBeSum: [WayKoef]?
        let idx: Int
        if let ww = [items[i1][0]].isDividedBy([items[i2][0]]) {
            mayBeSum = items[i1].addSummand(other: items[i2].compLeft(way: ww.0), koef: -ww.1)
            idx = i1
        } else if let ww = [items[i2][0]].isDividedBy([items[i1][0]]) {
            mayBeSum = items[i2].addSummand(other: items[i1].compLeft(way: ww.0), koef: -ww.1)
            idx = i2
        } else {
            mayBeSum = nil
            idx = -1
        }
        guard let sum = mayBeSum, !sum.isZero else { return nil }
        let hasSum: Bool
        if let ww = w3.addSummand(other: w4, koef: 1), ww.isEq(sum) {
            hasSum = true
        } else if let ww = w3.addSummand(other: w4, koef: -1), ww.isEq(sum) {
            hasSum = true
        } else {
            hasSum = false
        }
        return hasSum ? idx : nil
    }

    private static func sums2(_ w1: [WayKoef], _ w2: [WayKoef]) -> [[WayKoef]] {
        guard w1.count >= 2 else { return [] }
        if w1.isEq(w2, koef: 1) { return [] }
        for k in 0 ..< w1.count {
            if !w1[k].isZero && !w2[k].isZero {
                return []
            }
        }
        var sum1: [WayKoef] = []
        for k in 0 ..< w1.count {
            sum1.append(w1[k].isZero ? w2[k] : w1[k])
        }
        var sum2: [WayKoef] = []
        for k in 0 ..< w1.count {
            sum2.append(w1[k].isZero ? w2[k] : w1[k].minus)
        }
        return [sum1, sum2]
    }

    private static func sums3(_ w1: [WayKoef], _ w2: [WayKoef], _ w3: [WayKoef]) -> [[WayKoef]] {
        guard w1.count >= 3 else { return [] }
        var intersects = false
        for k in 0 ..< w1.count {
            if !w1[k].isZero && !w2[k].isZero { intersects = true }
            if !w1[k].isZero && !w3[k].isZero { intersects = true }
            if !w2[k].isZero && !w3[k].isZero { intersects = true }
        }
        if intersects { return [] }
        var sss: [[WayKoef]] = []
        for i in 0 ... 3 {
            var sum1: [WayKoef] = []
            for k in 0 ..< w1.count {
                sum1.append(w1[k].isZero ? (w2[k].isZero ? w3[k] : (i == 1 || i == 2 ? w2[k] : w2[k].minus)) : (i % 2 == 0 ? w1[k] : w1[k].minus))
            }
            sss.append(sum1)
        }
        return sss
    }
}

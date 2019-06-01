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
                let w1 = items[i]
                let w2 = items[j]
                var intersects = false
                for k in 0 ..< w1.count {
                    if !w1[k].isZero && !w2[k].isZero { intersects = true }
                }
                if intersects { continue }
                var sum1: [WayKoef] = []
                for k in 0 ..< w1.count {
                    sum1.append(w1[k].isZero ? w2[k] : w1[k])
                }
                if let ii = items.firstIndex(where: { $0.isEq(sum1) }) {
                    indexes.insert(ii)
                }
                var sum2: [WayKoef] = []
                for k in 0 ..< w1.count {
                    sum2.append(w1[k].isZero ? w2[k] : w1[k].minus)
                }
                if let ii = items.firstIndex(where: { $0.isEq(sum2) }) {
                    indexes.insert(ii)
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
                    if let ii = items.firstIndex(where: { $0.isEq(mult) }) {
                        indexes.insert(ii)
                    }
                }
            }
        }
        return indexes
    }
}

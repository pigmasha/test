//
//  Created by M on 12/11/2018.
//

import Foundation

struct PKer {
    private static var items: [[WayKoef]] = []
    private static var isIm = false

    static func ker(_ homo: PHomo, onlyGen: Bool) -> PElements {
        isIm = false
        tryAddAll(homo: homo)
        removeIndexes(PKerThinUtils.sumElemsIndexes(items))
        if !onlyGen { return PElements(type: .ker, items: items) }
        removeIndexes(PKerThinUtils.nonGenElemsIndexes(items))
        while true {
            guard let i = PKerThinUtils.findSumIndex(items) else {
                break
            }
            items.remove(at: i)
        }
        simplifyElements()
        return PElements(type: .ker, items: items.sorted(by: itemsComparator))
    }

    private static var itemsComparator: ([WayKoef], [WayKoef]) -> Bool {
        return { a, b in
            let z1 = a.filter { !$0.isZero }.count
            let z2 = b.filter { !$0.isZero }.count
            if z1 != z2 { return z1 > z2 }
            let w1 = a.reduce(0, { $0 + ($1.isZero ? 0 : $1.ways[0].len) })
            let w2 = b.reduce(0, { $0 + ($1.isZero ? 0 : $1.ways[0].len) })
            if w1 != w2 { return w1 > w2 }
            let a1 = a.filter { !$0.isZero && $0.ways[0].arrays.contains(where: { $0.type == .alpha }) }.count
            let a2 = b.filter { !$0.isZero && $0.ways[0].arrays.contains(where: { $0.type == .alpha }) }.count
            if a1 != a2 { return a1 > a2 }
            for i in 0 ..< a.count {
                if (a[i].isZero && b[i].isZero) { continue }
                if (a[i].isZero && !b[i].isZero) { return false }
                if (!a[i].isZero && b[i].isZero) { return true }
                if (a[i].koefs[0] > 0 && b[i].koefs[0] < 0) { return true }
                if (a[i].koefs[0] < 0 && b[i].koefs[0] > 0) { return false }
                let d1 = a[i].ways[0].len
                let d2 = b[i].ways[0].len
                if d1 != d2 { return d1 > d2 }
            }
            print("Same! \(a.str) = \(b.str)")
            return w1 > w2
        }
    }

    static func im(_ homo: PHomo) -> PElements {
        isIm = true
        items = []
        for i in 0 ..< homo.from.count {
            let way = Way(from: homo.from[i], len: 0)
            var wk: [WayKoef] = []
            for j in 0 ..< homo.from.count {
                wk.append(i == j ? WayKoef(koef: 1, way: way) : WayKoef.zero)
            }
            tryAddImElem(wk, homo: homo)
        }
        return PElements(type: .im, items: items)
    }


    private static func tryAddAll(homo: PHomo) {
        items = []
        var allP: [[Way]] = []
        for f in homo.from { allP.append(allPWays(f)) }
        let koefs = allKoefs(len: allP.count)
        switch allP.count {
        case 1:
            for w in allP[0] {
                tryAddElem([WayKoef(koef: 1, way: w)], homo: homo)
            }
        case 2:
            for w1 in allP[0] {
                for w2 in allP[1] {
                    for kk in koefs {
                        tryAddElem([kk[0] == 0 ? WayKoef.zero : WayKoef(koef: kk[0], way: w1),
                                    kk[1] == 0 ? WayKoef.zero : WayKoef(koef: kk[1], way: w2)], homo: homo)
                    }
                }
            }
        case 3:
            for w1 in allP[0] {
                for w2 in allP[1] {
                    for w3 in allP[2] {
                        for kk in koefs {
                            tryAddElem([kk[0] == 0 ? WayKoef.zero : WayKoef(koef: kk[0], way: w1),
                                        kk[1] == 0 ? WayKoef.zero : WayKoef(koef: kk[1], way: w2),
                                        kk[2] == 0 ? WayKoef.zero : WayKoef(koef: kk[2], way: w3)], homo: homo)
                        }
                    }
                }
            }
        case 4:
            for w1 in allP[0] {
                for w2 in allP[1] {
                    for w3 in allP[2] {
                        for w4 in allP[3] {
                            for kk in koefs {
                                tryAddElem([kk[0] == 0 ? WayKoef.zero : WayKoef(koef: kk[0], way: w1),
                                            kk[1] == 0 ? WayKoef.zero : WayKoef(koef: kk[1], way: w2),
                                            kk[2] == 0 ? WayKoef.zero : WayKoef(koef: kk[2], way: w3),
                                            kk[3] == 0 ? WayKoef.zero : WayKoef(koef: kk[3], way: w4)], homo: homo)
                            }
                        }
                    }
                }
            }
        case 5:
            for w1 in allP[0] {
                for w2 in allP[1] {
                    for w3 in allP[2] {
                        for w4 in allP[3] {
                            for w5 in allP[4] {
                                for kk in koefs {
                                    tryAddElem([kk[0] == 0 ? WayKoef.zero : WayKoef(koef: kk[0], way: w1),
                                                kk[1] == 0 ? WayKoef.zero : WayKoef(koef: kk[1], way: w2),
                                                kk[2] == 0 ? WayKoef.zero : WayKoef(koef: kk[2], way: w3),
                                                kk[3] == 0 ? WayKoef.zero : WayKoef(koef: kk[3], way: w4),
                                                kk[4] == 0 ? WayKoef.zero : WayKoef(koef: kk[4], way: w5)], homo: homo)
                                }
                            }
                        }
                    }
                }
            }
        default:
            fatalError("Bad from count (not 1, 2 or 3): \(homo.from)")
        }
    }

    static var koefsCache: [Int: [[Int]]] = [:]
    private static func allKoefs(len: Int) -> [[Int]] {
        if let cc = koefsCache[len] { return cc }
        var koefs: [[Int]] = []
        var deg3 = 1
        for _ in 1 ... len { deg3 *= 3 }
        for i in 1 ... deg3 {
            var line: [Int] = []
            var ii = i
            for _ in 1 ... len {
                line.append(ii % 3 == 2 ? -1 : (ii%3))
                ii /= 3
            }
            if let firstK = line.first(where: { $0 != 0 }), firstK == 1 {
                koefs.append(line)
            }
        }
        koefsCache[len] = koefs
        return koefs
    }

    private static func tryAddElem(_ elem: [WayKoef], homo: PHomo) {
        if isIm {
            tryAddImElem(elem, homo: homo)
        } else {
            tryAddKerElem(elem, homo: homo)
        }
    }

    private static func tryAddKerElem(_ elem: [WayKoef], homo: PHomo) {
        guard elem.count == homo.matrix[0].count else {
            fatalError("bad count \(elem.count)")
        }
        for row in homo.matrix {
            var rslt: WayKoef?
            for i in 0 ..< elem.count {
                if elem[i].isZero || row[i].isZero { continue }
                let ww = way(row[i].way, elem[i].way)
                let koef = row[i].koef * elem[i].koef
                if !ww.isZero && koef != 0 {
                    if let rr = rslt {
                        if !rr.way.isEq(ww) { return }
                        let kk = rr.koef + koef
                        if kk == 0 {
                            rslt = nil
                        } else {
                            rslt = WayKoef(koef: kk, way: ww)
                        }
                    } else {
                        rslt = WayKoef(koef: koef, way: ww)
                    }
                }
            }
            if rslt != nil { return }
        }
        addElem(elem)
    }

    private static func tryAddImElem(_ elem: [WayKoef], homo: PHomo) {
        guard elem.count == homo.matrix[0].count else {
            fatalError("bad count \(elem.count)")
        }
        var imElem: [WayKoef] = []
        for row in homo.matrix {
            var koefs: [Int] = []
            var ways: [Way] = []
            for i in 0 ..< elem.count {
                if elem[i].isZero || row[i].isZero { continue }
                let ww = way(row[i].way, elem[i].way)
                let koef = row[i].koef * elem[i].koef
                if !ww.isZero && koef != 0 {
                    koefs += [koef]
                    ways += [ww]
                }
            }
            imElem += [WayKoef(koefs: koefs, ways: ways)]
        }
        addElem(imElem)
    }

    private static func addElem(_ elem: [WayKoef]) {
        guard elem.contains(where: { !$0.isZero }) else { return }
        if let index = items.firstIndex(where: { $0.isEq(elem, koef: 2) }) {
            items.remove(at: index)
        }
        if !hasElem(elem) { items += [ elem ] }
    }

    private static func hasElem(_ elem: [WayKoef]) -> Bool {
        return items.contains { $0.isEq(elem) }
    }

    private static func indexOf(_ elem: [WayKoef]) -> Int? {
        return items.firstIndex { $0.isEq(elem) }
    }

    private static func removeIndexes(_ indexes: Set<Int>) {
        let sortedIndexes = Array(indexes).sorted { $0 > $1 }
        for i in sortedIndexes { items.remove(at: i) }
    }

    private static func simplifyElements() {
        guard items.count > 1 else {
            return
        }
        for i in 0 ..< items.count - 1 {
            for j in i + 1 ..< items.count {
                guard !items[j].contains(where: { $0.ways.count > 1 }) else { continue }
                let idx = items[i].weight < items[j].weight ? j : i
                if let ww = items[i].addSummand(other: items[j], koef: 1), ww.weight < items[idx].weight {
                    items[idx] = ww
                } else if let ww = items[i].addSummand(other: items[j], koef: -1), ww.weight < items[idx].weight {
                    items[idx] = ww
                }
            }
        }
    }

    private static func removeDubles() {
        for i in 0 ..< items.count - 1 {
            while true {
                if i + 1 >= items.count { break }
                var hasDubl = false
                for j in i + 1 ..< items.count {
                    hasDubl = items[j].isEq(items[i])
                    if hasDubl {
                        items.remove(at: j)
                        break
                    }
                }
                if !hasDubl { break }
            }
        }
    }

    static func allPWays(_ starts: Int) -> [Way] {
        var pWays: [Way] = []
        for i in starts ... starts + PathAlg.vertexMod {
            for j in 0 ... 1 {
                let w = Way(from: starts, to: i, noZeroLen: j == 1)
                if !w.isZero, !pWays.contains(where: { $0.isEq(w)}) { pWays.append(w) }
            }
        }
        return pWays
    }

    private static func way(_ w1: Way, _ w2: Way) -> Way {
        let w = Way(way: w2)
        w.compRight(w1)
        return w
    }

    private static func findRemoveIndex(withLastZero: Bool) -> Int? {
        guard items.count == 3, items[0].count > 1,
            let i2 = items.firstIndex(where: { ii in return ii.contains(where: { $0.isZero }) == false }) else { return nil }
        let i0 = i2 == 0 ? 1 : 0
        let i1 = 3 - i2 - i0
        var sum1: [WayKoef] = []
        var sum2: [WayKoef] = []
        for i in 0 ..< items[0].count {
            if !items[i0][i].isZero && !items[i1][i].isZero { return nil }
            sum1.append(items[i0][i].isZero ? items[i1][i] : items[i0][i])
            sum2.append(items[i0][i].isZero ? items[i1][i].minus : items[i0][i])
        }
        let indexes1 = PKerThinUtils.nonGenElemsIndexes([items[i2], sum1])
        let indexes2 = PKerThinUtils.nonGenElemsIndexes([items[i2], sum2])
        if indexes1.contains(0) || indexes2.contains(0) { fatalError() }
        if indexes1.contains(1) || indexes2.contains(1) {
            let w0 = items[i0].first { $0.isZero == false }
            let w1 = items[i1].first { $0.isZero == false }
            if withLastZero && w0!.ways[0].len == w1!.ways[0].len {
                return items[i0][0].isZero ? i1 : i0
            }
            return w0!.ways[0].len <= w1!.ways[0].len ? i1 : i0
        }
        return findRemoveIndex2()
    }

    private static func findRemoveIndex2() -> Int? {
        guard items.count == 3 && items[0].count == 2 else { return nil }
        guard let i0 = items.firstIndex(where: { $0[0].isZero }),
            let i1 = items.firstIndex(where: { $0[1].isZero }) else { return nil }
        let i2 = 3 - i0 - i1
        let sum = [items[i1][0], items[i0][1]]
        guard !items[i2][0].isZero, !items[i2][1].isZero else { return nil }
        guard sum[0].divideBy(items[i2][0]) != nil else { return nil }
        return items[i0][1].way.len < items[i1][0].way.len ? i1 : i0
    }
}

//
//  Created by M on 12/11/2018.
//

import Foundation

struct PKer {
    private static var items: [[WayKoef]] = []
    private static var isIm = false

    static func ker(_ homo: PHomo, onlyGen: Bool, logRemoves: Bool) -> PElements {
        isIm = false
        tryAddAll(homo: homo)
        removeIndexes(PKerThinUtils.sumElemsIndexes(items))
        if !onlyGen { return PElements(type: .ker, items: items) }
        removeIndexes(PKerThinUtils.nonGenElemsIndexes(items))
        if let i = findRemoveIndex() {
            if logRemoves {
                OutputFile.writeLog(.simple, "$$\\text{remove }\(items[i].str)\\text{ from }" +
                    "\(items.map { $0.str }.joined(separator: ", "))$$\n")
            }
            items.remove(at: i)
        }
        if items.count == 3 && items[0].count > 1 && !items[1][0].isZero && !items[1][1].isZero {
            return PElements(type: .ker, items: [items[1], items[2], items[0]])
        }
        let rev = (items.count == 2 || items.count == 3) && items[0].count > 1 && (items[0][0].isZero || items[0][1].isZero)
        return PElements(type: .ker, items: rev ? items.reversed() : items)
    }

    static func im(_ homo: PHomo) -> PElements {
        isIm = true
        tryAddAll(homo: homo)
        removeIndexes(PKerThinUtils.sumElemsIndexes(items))
        thinHalfElems()
        return PElements(type: .im, items: items)
    }

    private static func tryAddAll(homo: PHomo) {
        items = []
        var allP: [[Way]] = []
        for f in homo.from { allP.append(allPWays(f)) }
        switch allP.count {
        case 1:
            for w in allP[0] {
                tryAddElem([WayKoef(koef: 1, way: w)], homo: homo)
            }
        case 2:
            let koefs = [ [1,0], [0,1,0], [1,1], [1,-1] ]
            for w1 in allP[0] {
                for w2 in allP[1] {
                    for kk in koefs {
                        tryAddElem([kk[0] == 0 ? WayKoef.zero : WayKoef(koef: kk[0], way: w1),
                                    kk[1] == 0 ? WayKoef.zero : WayKoef(koef: kk[1], way: w2)], homo: homo)
                    }
                }
            }
        case 3:
            let koefs = [
                [1,0,0], [0,1,0], [0,0,1],
                [1,1,0], [1,-1,0], [0,1,1], [0,1,-1], [1,0,1], [1,0,-1],
                [1,1,1], [1,1,-1], [1,-1,1], [1,-1,-1]
            ]
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
        default:
            fatalError("Bad from count (not 1, 2 or 3): \(homo.from)")
        }
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

    private static func thinHalfElems() {
        var i = 0
        while i < items.count {
            let w = items[i]
            let half = w.compactMap { $0.half }
            if half.count == w.count && (hasElem(half) || hasElem(half.map { $0.minus })) {
                items.remove(at: i)
            } else {
                i += 1
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
        for i in 0 ... PathAlg.vertexMod {
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

    private static func findRemoveIndex() -> Int? {
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

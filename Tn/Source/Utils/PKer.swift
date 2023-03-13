//
//  Created by M on 12/11/2018.
//

import Foundation

struct PKer {
    private static var items: [[Element]] = []
    private static var isIm = false
    private static var kerRow: [Element] = []

    static func ker(_ homo: PHomo, _ size: Int) -> PElements? {
        isIm = false
        tryAddAll(homo: homo, size: size)
        let ii1 = items.map { itemWeight($0) }
        let ii2 = items.map { itemWeight2($0) }
        items = ii1.indices.sorted { ii1[$0] == ii1[$1] ? (ii2[$0] == ii2[$1] ? $0 < $1 : ii2[$0] > ii2[$1]) : ii1[$0] > ii1[$1] }.map { items[$0] }
        thinSumElements()
        thinRkElements()
        if size > -1 && items.count != size {
            OutputFile.writeLog(.error, "Bad ker count \(items.count) (should be \(size))")
            OutputFile.writeLog(.normal, "items=<br>(" + items.map { $0.str }.joined(separator: ")<br>(") + ")")
            return nil
        }
        thinBigElements()
        //let ii = items.map { itemWeight2($0) }
        //items = ii.indices.sorted { ii[$0] == ii[$1] ? $0 < $1 : ii[$0] > ii[$1] }.map { items[$0] }
        let ii = items.map { itemIntervals($0) }
        items = ii.indices.sorted {
            let (i1, i2) = (ii[$0], ii[$1])
            return i1.0 != i2.0 ? i1.0 < i2.0 : (i1.1 != i2.1 ? i1.1 < i2.1 : $0 < $1)
        }.map { items[$0] }
        return PElements(type: .ker, items: items)
    }

    static func im(_ homo: PHomo) -> PElements {
        isIm = true
        items = []
        let elem: [Element] = homo.matrix.rows[0].map { _ in Element() }
        _ = tryAddAll1(homo: homo, elem: elem)
        return PElements(type: .im, items: items)
    }

    private static func itemWeight(_ item: [Element]) -> Int {
        var w = 0
        item.forEach { if !$0.isZero { w += 1 } }
        return w
    }

    private static func itemWeight2(_ item: [Element]) -> Int {
        var w = 0
        item.forEach { w = 2 * w + ($0.isZero ? 0 : 1) }
        return w
    }

    private static func itemIntervals(_ item: [Element]) -> (Int, Int) {
        var r = (-1, -1)
        for (i, e) in item.enumerated() {
            if e.isZero { continue }
            if r.0 < 0 { r.0 = i }
            r.1 = i
        }
        return r
    }

    private static func tryAddAll(homo: PHomo, size: Int) {
        items = []
        let elem: [Element] = homo.matrix.rows[0].map { _ in Element() }
        let notAddedWays = tryAddAll1(homo: homo, elem: elem)
        if items.count == size || size < 0 { return }
        let notAddedWays2 = notAddedWays.map { $0.map { $0.0 } }
        tryAddAll2(homo: homo, elem: elem, notAddedWays: notAddedWays2)
        let maxK = PathAlg.charK
        var kkCount = 1
        for _ in homo.matrix.rows[0] { kkCount *= maxK }
        for k in 1 ... kkCount - 1 {
            var kk: [Int] = []
            var k0 = k
            var nonZeroCount = 0
            var count = 1
            for j in 0 ..< homo.matrix.width {
                let k1 = k0 % maxK
                kk.append(PathAlg.charK == 0 ? (k1 > 5 ? k1 - 11 : k1) : k1)
                if k1 > 0 {
                    nonZeroCount += 1
                    count *= notAddedWays[j].count
                }
                k0 /= maxK
            }
            if nonZeroCount == 0 { fatalError() }
            if nonZeroCount != 3 { continue }
            for j in 0 ..< count {
                let multRes: [Element] = homo.matrix.rows.map { _ in Element() }
                var wayPos = j
                for q in 0 ..< kk.count {
                    if kk[q] == 0 { continue }
                    let c = notAddedWays[q].count
                    let (w, m) = notAddedWays[q][wayPos % c]
                    elem[q].add(way: w, koef: kk[q])
                    for (i, e) in multRes.enumerated() {
                        e.add(element: m[i], koef: kk[q])
                    }
                    wayPos /= c
                }
                if multRes.isZero { addElem(elem) }
                for q in 0 ..< kk.count {
                    if kk[q] != 0 { elem[q].clear() }
                }
            }
        }
    }

    private static func tryAddAll1(homo: PHomo, elem: [Element]) -> [[(Way, [Element])]] {
        // one nonzero element
        var allP: [[Way]] = []
        for f in homo.from { allP.append(allPWays(f)) }
        var notAddedWays: [[(Way, [Element])]] = []
        for i in 0 ..< homo.from.count {
            var notAdded: [(Way, [Element])] = []
            for w in allP[i] {
                elem[i].add(way: w, koef: 1)
                let added = tryAddElem(elem, matrix: homo.matrix)
                elem[i].add(way: w, koef: -1)
                if !added {
                    notAdded.append((w, kerRow))
                }
            }
            notAddedWays.append(notAdded)
        }
        return notAddedWays
    }

    private static func tryAddAll2(homo: PHomo, elem: [Element], notAddedWays: [[Way]]) {
        // two nonzero elements
        for i1 in 0 ..< homo.matrix.width - 1 {
            let ww1 = notAddedWays[i1]
            for w1 in ww1 {
                elem[i1].add(way: w1, koef: 1)
                let maxKoef = PathAlg.charK == 0 ? 10 : PathAlg.charK
                for koef in 1 ..< maxKoef {
                    for i2 in i1 + 1 ..< homo.matrix.width {
                        let ww2 = notAddedWays[i2]
                        for w2 in ww2 {
                            elem[i2].add(way: w2, koef: PathAlg.charK == 0 ? (koef > 5 ? koef - 7 : koef) : koef)
                            _ = tryAddElem(elem, matrix: homo.matrix)
                            elem[i2].clear()
                        }
                    }
                }
                elem[i1].clear()
            }
        }
    }

    static func pSize(_ starts: Int) -> Int {
        var s = 0
        Way.allWays.forEach { if $0.startVertex == starts { s += 1 } }
        return s
    }

    private static func allPWays(_ starts: Int) -> [Way] {
        return Way.allWays.filter { $0.startVertex == starts }
    }

    private static func tryAddElem(_ elem: [Element], matrix: PMatrix) -> Bool {
        return isIm ? tryAddImElem(elem, matrix: matrix) : tryAddKerElem(elem, matrix: matrix)
    }

    private static func tryAddKerElem(_ elem: [Element], matrix: PMatrix) -> Bool {
        guard elem.count == matrix.width else {
            fatalError("bad count \(elem.count)")
        }
        kerRow = []
        var isZero = true
        for row in matrix.rows {
            let rslt = Element()
            for i in 0 ..< elem.count {
                if elem[i].isZero || row[i].isZero { continue }
                let e = Element(element: elem[i])
                e.compRight(element: row[i])
                rslt.add(element: e)
            }
            if !rslt.isZero { isZero = false }
            kerRow.append(rslt)
        }
        if isZero {
            addElem(elem)
        }
        return isZero
    }

    private static func tryAddImElem(_ elem: [Element], matrix: PMatrix) -> Bool {
        guard elem.count == matrix.width else {
            fatalError("bad count \(elem.count)")
        }
        var imElem: [Element] = []
        for row in matrix.rows {
            let rslt = Element()
            for i in 0 ..< elem.count {
                if elem[i].isZero || row[i].isZero { continue }
                let e = Element(element: elem[i])
                e.compRight(element: row[i])
                rslt.add(element: e)
            }
            imElem.append(rslt)
        }
        if !imElem.isZero { addElem(imElem) }
        return false
    }

    private static func addElem(_ elem: [Element]) {
        guard !elem.isZero else { return }
        var kk = 0
        for i in 0 ..< items.count {
            if elem.eqKoef(items[i]) != 0 { return }
            let k = items[i].eqKoef(elem) // items[i] = k * elem
            if k != 0 {
                items[i] = elem.map { Element(element: $0) }
                kk = k
                break
            }
        }
        if kk > 0 {
            items.removeAll { return $0.eqKoef(elem) > 1 }
        }
        items += [elem.map { Element(element: $0) }]
    }

    private static func sum(_ item1: [Element], and item2: [Element], koef: Int = 1) -> [Element] {
        var item3: [Element] = []
        for k in 0 ..< item1.count {
            let e = Element(element: item1[k])
            e.add(element: item2[k], koef: koef)
            item3.append(e)
        }
        return item3
    }

    private static func thinSumElements() {
        let itemWeight: ([Element]) -> Int = { item in
            var w = 0
            item.forEach { if !$0.isZero { w += 1 } }
            return w
        }
        var i = 0
        while i < items.count - 2 {
            let item1 = items[i]
            var sumIdx: Int?
            for j in i + 1 ..< items.count - 1 {
                for k in j + 1 ..< items.count {
                    let item2 = sum(items[j], and: items[k])
                    if item2.eqKoef(item1) != 0 {
                        sumIdx = j
                        break
                    }
                    if PathAlg.charK == 2 { continue }
                    let item3 = sum(items[j], and: items[k], koef: -1)
                    if item3.eqKoef(item1) != 0 {
                        sumIdx = j
                        break
                    }
                }
                if sumIdx != nil { break }
            }
            if let sumIdx = sumIdx {
                let item2 = items[sumIdx]
                let removeSum = (itemWeight(item1) == itemWeight(item2)
                                 && item1.lastIndex(where: { !$0.isZero })! < item2.lastIndex(where: { !$0.isZero })!)
                let removeSum2 = false/*(itemWeight(item1) == itemWeight(item2)
                                  && itemWeight2(item1) > itemWeight2(item2))*/
                if removeSum || removeSum2 {
                    items.remove(at: sumIdx)
                } else {
                    items.remove(at: i)
                }
            } else {
                i += 1
            }
        }
    }

    private static func thinBigElements() {
        var i = 0
        while i < items.count {
            let item1 = items[i]
            let pos = item1.firstIndex { !$0.isZero }!
            let w1 = item1[pos].contents[0].1
            var isBig = false
            for j in 0 ..< items.count {
                if i == j { continue }
                let item2 = items[j]
                if item2[pos].isZero { continue }
                let w2 = item2[pos].contents[0].1
                if w1.isEq(w2) || !w1.hasSuffix(w2) { continue }
                let ww = Way.allWays.filter { $0.startVertex == w2.endVertex }
                for w in ww {
                    var isZero = true
                    var koef = 0
                    for k in 0 ..< item1.count {
                        if item2[k].isZero && item1[k].isZero { continue }
                        let e = Element(element: item2[k])
                        e.compLeft(element: Element(way: w))
                        if e.isZero && item1[k].isZero { continue }
                        let kk = e.eqKoef(item1[k])
                        if kk == 0 { isZero = false; break }
                        if koef == 0 {
                            koef = kk
                        } else if koef != kk {
                            isZero = false; break
                        }
                    }
                    if isZero { isBig = true; break }
                }
                if isBig { break }
            }
            if isBig {
                items.remove(at: i)
            } else {
                i += 1
            }
        }
    }


    private static func thinRkElements() {
        let columns = items[0].map { _ in PKerColInfo() }
        for item in items {
            if item.nonZeroCount < 2 { continue }
            for (i, e) in item.enumerated() {
                if e.isZero { continue }
                let c = columns[i]
                let s = e.strKey
                if c.m[s] == nil {
                    c.m[s] = c.count
                    c.count += 1
                }
            }
        }
        var s = 0
        for c in columns {
            c.prevCount = s
            s += c.count
        }
        let koefs = KoefIntMatrix()
        var delPoses: [Int] = []
        var lastRk = -1
        var cc = items.count
        for item in items.reversed() {
            cc -= 1
            if item.nonZeroCount < 2 { continue }
            var row = (1 ... s).map { _ in 0 }
            for (i, e) in item.enumerated() {
                if e.isZero { continue }
                let c = columns[i]
                row[c.prevCount + c.m[e.strKey]!] = e.contents[0].0.n
            }
            koefs.addRow(row)
            let rk = koefs.rank
            if rk == lastRk { delPoses.append(cc) }
            lastRk = rk
        }
        delPoses.forEach { items.remove(at: $0) }
    }
}

private final class PKerColInfo {
    var prevCount = 0
    var count = 0
    var m: [String: Int] = [:]
}

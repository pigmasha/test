//
//  Created by M on 12/11/2018.
//

import Foundation

struct PKer {
    private static var items: [[Element]] = []
    private static var isIm = false

    static func ker(_ matrix: PMatrix) -> PElements {
        isIm = false
        tryAddAll(matrix: matrix)
        thinSumElements()
        return PElements(type: .ker, items: items)
    }

    static func im(_ matrix: PMatrix) -> PElements {
        isIm = true
        tryAddAll(matrix: matrix)
        return PElements(type: .im, items: items)
    }

    static func im(_ matrix: Matrix) -> [[Element]] {
        isIm = true
        items = []
        let ways = Way.allWays
        for i in 0 ..< matrix.height {
            for w in ways {
                var ee: [Element] = []
                for j in 0 ..< matrix.width {
                    let e = Element()
                    for (k, t) in matrix.rows[i][j].contents {
                        let e0 = Element(way: t.leftComponent, koef: k.n)
                        e0.compRight(element: Element(way: w, koef: 1))
                        e0.compRight(element: Element(way: t.rightComponent, koef: 1))
                        if !e0.isZero { e.add(element: e0) }
                    }
                    ee.append(e)
                }
                addElem(ee)
            }
        }
        return items
    }

    private static func tryAddAll(matrix: PMatrix) {
        items = []
        let allWays = Way.allWays
        let elem: [Element] = matrix.rows[0].map { _ in Element() }
        var notAddedWays: [[Way]] = []
        // one nonzero element
        for i in 0 ..< matrix.width {
            var notAdded: [Way] = []
            var addedWays: [Way] = []
            for w in allWays {
                if addedWays.contains(where: { w.hasSuffix($0) }) { continue }
                elem[i].add(way: w, koef: 1)
                let added = tryAddElem(elem, matrix: matrix)
                elem[i].add(way: w, koef: -1)
                if added { addedWays.append(w); continue }
                notAdded.append(w)
            }
            notAddedWays.append(notAdded)
        }
        if isIm { thinIm() }
        if matrix.width == 1 || isIm { return }
        let maxK = PathAlg.charK
        var kkCount = 1;
        for _ in matrix.rows[0] { kkCount *= maxK }
        for k in 1 ... kkCount - 1 {
            var kk: [Int] = []
            var k0 = k
            var nonZeroCount = 0
            var count = 1
            for j in 0 ..< matrix.width {
                let k1 = k0 % maxK
                kk.append(PathAlg.charK == 0 ? (k1 > 5 ? k1 - 11 : k1) : k1)
                if k1 > 0 {
                    nonZeroCount += 1
                    count *= notAddedWays[j].count
                }
                k0 /= maxK
            }
            if nonZeroCount == 0 { fatalError() }
            if nonZeroCount == 1 { continue }
            for j in 0 ..< count {
                var wayPos = j
                for q in 0 ..< kk.count {
                    if kk[q] == 0 { continue }
                    let c = notAddedWays[q].count
                    elem[q].add(way: notAddedWays[q][wayPos % c], koef: kk[q])
                    wayPos /= c
                }
                _ = tryAddElem(elem, matrix: matrix)
                for q in 0 ..< kk.count {
                    if kk[q] != 0 { elem[q].clear() }
                }
            }
        }
    }

    private static func tryAddElem(_ elem: [Element], matrix: PMatrix) -> Bool {
        return isIm ? tryAddImElem(elem, matrix: matrix) : tryAddKerElem(elem, matrix: matrix)
    }

    private static func tryAddKerElem(_ elem: [Element], matrix: PMatrix) -> Bool {
        guard elem.count == matrix.width else {
            fatalError("bad count \(elem.count)")
        }
        for row in matrix.rows {
            let rslt = Element()
            for i in 0 ..< elem.count {
                if elem[i].isZero || row[i].isZero { continue }
                let e = Element(element: elem[i])
                e.compRight(element: row[i])
                rslt.add(element: e)
            }
            if !rslt.isZero { return false }
        }
        addElem(elem)
        return true
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
        if imElem.isZero { return false }
        addElem(imElem)
        return false
    }

    private static func addElem(_ elem: [Element]) {
        guard !elem.isZero else { return }
        var kk = 0
        for i in 0 ..< items.count {
            if elem.eqKoef(items[i]) != 0 { return }
            let k = items[i].eqKoef(elem) // items[i] = k * elem
            if k != 0 {
                items[i] = elem
                kk = k
                break
            }
        }
        if kk > 0 {
            items.removeAll { return $0.eqKoef(elem) > 1 }
        }
        items += [elem.map { Element(element: $0) }]
    }

    private static func thinIm() {
        if items.isEmpty { return }
        var thinItems: [[Element]] = []
        for i in 0 ..< items[0].count {
            var ii = items.filter { item in item.nonZeroCount == 1 && !item[i].isZero }
            ii.sort { $0[i].contents[0].1.len < $1[i].contents[0].1.len }
            var addedWays: [Way] = []
            for item in ii {
                if item[i].contents.count > 1 { thinItems.append(item); continue }
                let w = item[i].contents[0].1
                if addedWays.contains(where: { w.hasSuffix($0) }) { continue }
                thinItems.append(item)
                addedWays.append(w)
            }
        }
        let ii = items.filter { item in item.nonZeroCount > 1 }
        thinItems.append(contentsOf: ii)
        let additionalItems: ([[Element]], [[Element]], [[Element]]) -> [[Element]] = { items1, items2, allItems in
            var ii: [[Element]] = []
            for item1 in items1 {
                guard let idx1 = item1.firstIndex(where: { $0.contents.count > 1 }) else { continue }
                for item2 in items2 {
                    if item2[idx1].isZero { continue }
                    let item3 = sum(item1, and: item2)
                    if !item3.isZero && !item3.contains(where: { $0.contents.count > 1 })
                        && !allItems.contains(where: { $0.eqKoef(item3) != 0 })
                        && !ii.contains(where: { $0.eqKoef(item3) != 0 }) {
                        ii.append(item3)
                    }
                }
            }
            return ii
        }
        var allItems = thinItems
        let add1 = additionalItems(thinItems, thinItems, allItems)
        allItems += add1
        var add = add1
        while true {
            let add2 = additionalItems(thinItems, add, allItems) + additionalItems(add, thinItems, allItems)
            if add2.isEmpty { break }
            add += add2
            allItems += add2
        }
        if add.count > 0 {
            for item1 in thinItems {
                guard let idx1 = item1.firstIndex(where: { $0.contents.count > 1 }) else { continue }
                for item2 in add {
                    if item2[idx1].isZero { continue }
                    let item3 = sum(item1, and: item2)
                    if !item3.isZero && !item3.contains(where: { $0.contents.count > 1 })
                        && !thinItems.contains(where: { $0.eqKoef(item3) != 0 })
                        && !add.contains(where: { $0.eqKoef(item3) != 0 }) {
                        add.append(item3)
                        break
                    }
                }
            }
        }
        thinItems.append(contentsOf: add)
        items = thinItems
    }

    private static func sum(_ item1: [Element], and item2: [Element]) -> [Element] {
        var item3: [Element] = []
        for k in 0 ..< item1.count {
            let e = Element(element: item1[k])
            e.add(element: item2[k])
            item3.append(e)
        }
        return item3
    }

    private static func thinSumElements() {
        while true {
            if !thinSumElement() { break }
        }
    }

    private static func thinSumElement() -> Bool {
        for item1 in items {
            for item2 in items {
                let item3 = sum(item1, and: item2)
                if item3.nonZeroCount < item1.nonZeroCount || item3.nonZeroCount < item2.nonZeroCount { continue }
                guard let idx = items.firstIndex(where: { $0.eqKoef(item3) != 0 }) else { continue }
                items.remove(at: idx)
                return true
            }
        }
        return false
    }
}

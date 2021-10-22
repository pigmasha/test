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
        return PElements(type: .ker, items: items)
    }

    static func im(_ matrix: PMatrix) -> PElements {
        isIm = true
        tryAddAll(matrix: matrix)
        return PElements(type: .im, items: items)
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
                if PathAlg.charK < 4 { continue }
                for k in 2 ..< PathAlg.charK - 1 {
                    elem[i].add(way: w, koef: k)
                    _ = tryAddElem(elem, matrix: matrix)
                    elem[i].clear()
                }
            }
            notAddedWays.append(notAdded)
        }
        if matrix.width == 1 || isIm { return }
        let maxK = PathAlg.charK == 0 ? 11 : PathAlg.charK
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
}

struct PMyKer {
    static func ker(_ deg: Int) -> PElements {
        let k = PathAlg.k
        var items: [[Element]] = []
        items.append([Element(way: Way(type: .x, len: 2), koef: 1), Element()])
        if PathAlg.d == 0 {
            items.append([Element(), Element(way: Way.y, koef: 1)])
        } else {
            items.append([Element(), Element(way: Way(type: .y, len: 2), koef: 1)])
            items.append([Element(way: Way(type: .y, len: 2 * k - 1), koef: -PathAlg.d),
                          Element(way: Way.y, koef: 1)])
        }
        if PathAlg.c == 0 {
            items.append([Element(way: Way.x, koef: -1),
                          Element(way: Way(type: .x, len: 2 * k - 2), koef: 1)])
        }
        items.append([Element(way: Way(type: .y, len: 2 * k - 1), koef: -1),
                      Element(way: Way(type: .x, len: 2 * k - 1), koef: 1)])
        return PElements(type: .ker, items: items)
    }
}

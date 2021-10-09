//
//  Created by M on 12/11/2018.
//

import Foundation

struct PKer {
    private static var items: [[Element]] = []
    private static var isIm = false

    static func ker(_ homo: PHomo, onlyGen: Bool) -> PElements {
        isIm = false
        tryAddAll(homo: homo)
        if !onlyGen { return PElements(type: .ker, items: items) }
        return PElements(type: .ker, items: items)
    }

    private static func tryAddAll(homo: PHomo) {
        items = []
        let allWays = Way.allWays
        let elem: [Element] = homo.matrix[0].map { _ in Element() }
        var notAddedWays: [[Way]] = []
        // one nonzero element
        for i in 0 ..< homo.matrix[0].count {
            var notAdded: [Way] = []
            var addedWays: [Way] = []
            for w in allWays {
                if addedWays.contains(where: { w.hasPrefix($0) }) { continue }
                elem[i].add(way: w, koef: 1)
                let added = tryAddElem(elem, homo: homo)
                elem[i].add(way: w, koef: -1)
                if added { addedWays.append(w); continue }
                notAdded.append(w)
                if PathAlg.charK < 4 { continue }
                for k in 2 ..< PathAlg.charK - 1 {
                    elem[i].add(way: w, koef: k)
                    _ = tryAddElem(elem, homo: homo)
                    elem[i].clear()
                }
            }
            notAddedWays.append(notAdded)
        }
        if homo.matrix[0].count == 1 { return }
        let maxK = PathAlg.charK == 0 ? 11 : PathAlg.charK
        var kkCount = 1;
        for _ in homo.matrix[0] { kkCount *= maxK }
        for k in 1 ... kkCount - 1 {
            var kk: [Int] = []
            var k0 = k
            var nonZeroCount = 0
            var count = 1
            for j in 0 ..< homo.matrix[0].count {
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
                //OutputFile.writeLog(.normal, "Try " + elem.map { $0.str }.joined(separator: ", "))
                _ = tryAddElem(elem, homo: homo)
                for q in 0 ..< kk.count {
                    if kk[q] != 0 { elem[q].clear() }
                }
            }
        }
    }

    private static func tryAddElem(_ elem: [Element], homo: PHomo) -> Bool {
        return isIm ? tryAddImElem(elem, homo: homo) : tryAddKerElem(elem, homo: homo)
    }

    private static func tryAddKerElem(_ elem: [Element], homo: PHomo) -> Bool {
        guard elem.count == homo.matrix[0].count else {
            fatalError("bad count \(elem.count)")
        }
        for row in homo.matrix {
            let rslt = Element()
            for i in 0 ..< elem.count {
                if elem[i].isZero || row[i].isZero { continue }
                let e = Element(element: row[i])
                e.compRight(element: elem[i])
                rslt.add(element: e)
            }
            if !rslt.isZero { return false }
        }
        addElem(elem)
        return true
    }

    private static func tryAddImElem(_ elem: [Element], homo: PHomo) -> Bool {
        guard elem.count == homo.matrix[0].count else {
            fatalError("bad count \(elem.count)")
        }
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

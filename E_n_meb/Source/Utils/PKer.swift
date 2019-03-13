//
//  Created by M on 12/11/2018.
//

import Foundation

struct PKer {
    private static var items: [[WayKoef]] = []
    private static var isIm = false

    static func ker(_ homo: PHomo, onlyGen: Bool, logRemoves: Bool) -> [[WayKoef]] {
        var allP: [[Way]] = []
        for f in homo.from { allP.append(allPWays(f)) }
        items = []
        isIm = false
        switch allP.count {
        case 1:
            for w in allP[0] {
                if (homo.to.count == 1 && way(homo.matrix[0][0].way, w).isZero) ||
                    (homo.to.count == 2 && way(homo.matrix[0][0].way, w).isZero && way(homo.matrix[1][0].way, w).isZero) {
                    addElem([WayKoef(koef: 1, way: w)])
                }
            }
        case 2:
            for w1 in allP[0] {
                for w2 in allP[1] {
                    let col: Int
                    if homo.matrix.count == 1 {
                        col = 0
                    } else if homo.matrix[1][1].isZero {
                        col = 0
                    } else if homo.matrix[0][1].isZero {
                        col = 1
                    } else {
                        fatalError()
                    }
                    let ww1 = way(homo.matrix[col][0].way, w1)
                    let ww2 = way(homo.matrix[col][1].way, w2)
                    if homo.matrix.count > 1 {
                        if !way(homo.matrix[1 - col][0].way, w1).isZero { continue }
                    }
                    if ww1.isZero {
                        addElem([WayKoef(koef: 1, way: w1), WayKoef(koef: 0, way: w2)])
                    }
                    if ww2.isZero {
                        addElem([WayKoef(koef: 0, way: w1), WayKoef(koef: 1, way: w2)])
                    }
                    if !ww1.isZero && !ww2.isZero && ww1.isEq(ww2) {
                        let k1 = homo.matrix[col][0].koef
                        let k2 = homo.matrix[col][1].koef
                        addElem([WayKoef(koef: 1, way: w1), WayKoef(koef: k1 == k2 ? -1 : 1, way: w2)])
                    }
                }
            }
        default:
            fatalError("Bad from count (not 1 or 2): \(homo.from)")
        }
        if !onlyGen { return items }

        var i = 0
        while i < items.count {
            let w = items[i]
            var isGen = true
            for j in 0 ..< items.count {
                guard i != j else { continue }
                let item = items[j]
                if w.count == 1 {
                    if w[0].divideBy(item[0]) != nil { isGen = false; break }
                } else {
                    let w1 = w[0].divideBy(item[0])
                    let w2 = w[1].divideBy(item[1])
                    if w1 != nil && w2 != nil { isGen = false; break }
                    if let w1 = w1, w1.len > 0, w[1].isZero, Way(way1: item[1].way, way2: w1).isZero {
                        isGen = false; break
                    }
                    if let w2 = w2, w2.len > 0, w[0].isZero, Way(way1: item[0].way, way2: w2).isZero {
                        isGen = false; break
                    }
                }
            }
            if isGen { i += 1 } else { items.remove(at: i) }
        }
        guard items.count > 0 else { fatalError("Bad from count (not 1 or 2): \(homo.from)") }
        if items.count == 3 && items[0].count == 2 {
            if let i0 = items.firstIndex(where: { $0[0].isZero }), let i1 = items.firstIndex(where: { $0[1].isZero }) {
                let i = items[i0][1].way.len < items[i1][0].way.len ? i1 : i0
                if logRemoves {
                    OutputFile.writeLog(.simple, "$$\\text{remove }(\(items[i][0].str)\\text{ }\(items[i][1].str))$$\n")
                }
                items.remove(at: i)
            }
        }
        return items
    }

    static func im(_ homo: PHomo) -> [[WayKoef]] {
        var allP: [[Way]] = []
        for f in homo.from { allP.append(allPWays(f)) }
        items = []
        isIm = true
        switch allP.count {
        case 1:
        for w in allP[0] {
            if homo.to.count == 1 {
                addElem([WayKoef(koef: 1, way: way(homo.matrix[0][0].way, w))])
            } else {
                addElem([WayKoef(koef: homo.matrix[0][0].koef, way: way(homo.matrix[0][0].way, w)),
                         WayKoef(koef: homo.matrix[1][0].koef, way: way(homo.matrix[1][0].way, w))])
            }
        }
        case 2:
        for w1 in allP[0] {
            for w2 in allP[1] {
                let wk0 = WayKoef(koefs: [homo.matrix[0][0].koef, homo.matrix[0][1].koef],
                                  ways: [way(homo.matrix[0][0].way, w1), way(homo.matrix[0][1].way, w2)])
                if homo.to.count == 1 {
                    addElem([wk0])
                } else {
                    let wk1 = WayKoef(koefs: [homo.matrix[1][0].koef, homo.matrix[1][1].koef],
                                      ways: [way(homo.matrix[1][0].way, w1), way(homo.matrix[1][1].way, w2)])
                    addElem([wk0, wk1])
                }
            }
        }
        default:
            fatalError()
        }
        thinImElems1()
        thinImElems2()
        return items
    }

    private static func addElem(_ elem: [WayKoef]) {
        guard elem.contains(where: { !$0.isZero }) else { return }
        if let index = items.firstIndex(where: { $0.isEq(elem, koef: 2) }) {
            items.remove(at: index)
        }
        let hasElem = items.contains { $0.isEq(elem) }
        if !hasElem { items += [ elem ] }
        if !isIm || elem.count != 1 || elem[0].koefs.count != 1 || abs(elem[0].koefs[0]) != 1 { return }
    }

    private static func thinImElems1() {
        guard items.count > 0, items[0].count == 1 else { return }
        for i in 0 ..< items.count {
            guard items[i][0].koefs.count == 1 else { continue }
            let w = items[i][0].ways[0]
            for j in 0 ..< items.count {
                let elem = items[j][0]
                guard elem.koefs.count == 2 else { continue }
                if elem.ways[0].isEq(w) {
                    items[j] = [WayKoef(koef: elem.koefs[1], way: elem.ways[1])]
                } else if elem.ways[1].isEq(w) {
                    items[j] = [WayKoef(koef: elem.koefs[0], way: elem.ways[0])]
                }
            }
        }
        removeDubles()
    }

    private static func thinImElems2() {
        guard items.count > 0, items[0].count == 2 else { return }
        for mode in 0 ... 2 {
            for i in 0 ..< items.count {
                switch mode {
                case 0, 2:
                    guard items[i][0].koefs.count == 1, abs(items[i][0].koef) == 1, items[i][1].isZero else { continue }
                case 1:
                    guard items[i][1].koefs.count == 1, abs(items[i][1].koef) == 1, items[i][0].isZero else { continue }
                default: fatalError("unknown mode \(mode)")
                }
                let w = mode == 1 ? items[i][1].way : items[i][0].way
                for j in 0 ..< items.count {
                    switch mode {
                    case 0:
                        let elem = items[j][0]
                        if elem.koefs.count == 2 {
                            if elem.ways[0].isEq(w) {
                                items[j] = [WayKoef(koef: elem.koefs[1], way: elem.ways[1]), items[j][1]]
                            } else if elem.ways[1].isEq(w) {
                                items[j] = [WayKoef(koef: elem.koefs[0], way: elem.ways[0]), items[j][1]]
                            }
                        }
                    case 1:
                        let elem = items[j][1]
                        if elem.koefs.count == 2 {
                            if elem.ways[0].isEq(w) {
                                items[j] = [items[j][0], WayKoef(koef: elem.koefs[1], way: elem.ways[1])]
                            } else if elem.ways[1].isEq(w) {
                                items[j] = [items[j][0], WayKoef(koef: elem.koefs[0], way: elem.ways[0])]
                            }
                        }
                    case 2:
                        if !items[j][1].isZero, items[j][0].way.isEq(w) {
                            items[j] = [WayKoef(koefs: [], ways: []), items[j][1]]
                        }
                    default: fatalError("unknown mode \(mode)")
                    }
                }
            }
        }
        removeDubles()
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

    private static func allPWays(_ starts: Int) -> [Way] {
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
}

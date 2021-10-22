//
//  Created by M on 22.04.16.
//

import Foundation

final class Comb {
    private(set) var contents: [(NumInt, Tenzor)]

    init() {
        contents = []
    }

    init(tenzor: Tenzor, koef: Int) {
        contents = []
        add(tenzor: tenzor, koef: koef)
    }

    init(left: Way, right: Way, koef: Int) {
        contents = []
        add(tenzor: Tenzor(left: left, right: right), koef: koef)
    }

    init(comb: Comb) {
        contents = []
        for (n, t) in comb.contents {
            add(tenzor: t, koef: n.n)
        }
    }

    var isZero: Bool {
        return contents.isEmpty
    }

    func add(tenzor: Tenzor, koef: Int) {
        if tenzor.isZero || NumInt.isZero(n: koef) { return }
        if let i = contents.firstIndex(where: { $0.1.isEq(tenzor) }) {
            contents[i].0.n += koef
            if contents[i].0.isZero {
                contents.remove(at: i)
            }
        } else {
            contents.append((NumInt(n: koef), Tenzor(tenzor: tenzor)))
        }
    }

    func add(left: Way, right: Way, koef: Int) {
        add(tenzor: Tenzor(left: left, right: right), koef: koef)
    }

    func add(comb: Comb) {
        for (k, t) in comb.contents {
            add(tenzor: t, koef: k.n)
        }
    }

    func clear() {
        contents = []
    }

    var str: String {
        if isZero { return "0" }
        var s = ""
        for i in 0 ..< contents.count {
            let k = contents[i].0.n
            if k < 0 {
                s += k == -1 ? "-" : "\(k)"
            } else {
                if i > 0 { s += "+" }
                if k != 1 { s += "\(k)" }
            }
            s += contents[i].1.str
        }
        return s
    }

    func compKoef(_ koef: Int) {
        var hasZero = false
        contents.forEach {
            $0.0.n *= koef
            if $0.0.isZero { hasZero = true }
        }
        if hasZero {
            contents = contents.filter { !$0.0.isZero }
        }
    }

    func compRight(comb: Comb) {
        var result: [(NumInt, Tenzor)] = []
        for (k, t) in comb.contents {
            result += Comb.compRight(contents: contents, tenzor: t, koef: k.n)
        }
        contents = Comb.removeZerosAndDubles(result)
    }

    func eqKoef(_ other: Comb) -> Int {
        guard !contents.isEmpty && contents.count == other.contents.count else { return 0 }
        var kk = 0
        for i1 in 0 ..< contents.count {
            guard let i2 = other.contents.firstIndex(where: { contents[i1].1.isEq($0.1) }) else { return 0 }
            let k = contents[i1].0.eqKoef(other.contents[i2].0)
            if k == 0 { return 0 }
            if kk > 0 && k != kk { return 0 }
            kk = k
        }
        return kk
    }

    private static func compRight(contents: [(NumInt, Tenzor)], tenzor: Tenzor, koef: Int) -> [(NumInt, Tenzor)] {
        if tenzor.isZero || NumInt.isZero(n: koef) { return [] }
        var result: [(NumInt, Tenzor)] = []
        if tenzor.leftComponent.len == 0 && tenzor.rightComponent.len == 0 {
            for (n, t) in contents {
                let k = n.n * koef
                if !NumInt.isZero(n: k) {
                    result.append((NumInt(n: k), Tenzor(tenzor: t)))
                }
            }
            return result
        }
        for (n, t) in contents {
            let k = PathAlg.k
            let n1 = NumInt(n: n.n * koef)
            let t1 = Tenzor(tenzor: t)
            result.append((n1, t1))
            if n1.isZero { continue }
            var canL = t1.leftComponent.canCompLeft(tenzor.leftComponent)
            var canR = t1.rightComponent.canCompRight(tenzor.rightComponent)
            if canL && canR { t1.compRight(tenzor); continue }
            if !canL && (t1.leftComponent.len > 1 || tenzor.leftComponent.len > 1) { n1.n = 0; continue }
            if !canR && (t1.rightComponent.len > 1 || tenzor.rightComponent.len > 1) { n1.n = 0; continue }
            if canL { t1.leftComponent.compLeft(tenzor.leftComponent) }
            if canR { t1.rightComponent.compRight(tenzor.rightComponent) }
            if !canL && t1.leftComponent.startArr == .y {
                t1.leftComponent = Way(type: .x, len: 2 * k)
                n1.n *= PathAlg.d
                canL = true
            }
            if !canR && t1.rightComponent.startArr == .y {
                t1.rightComponent = Way(type: .x, len: 2 * k)
                n1.n *= PathAlg.d
                canR = true
            }
            if canL && canR { continue }
            if canL {
                result.append((NumInt(n: n1.n), Tenzor(left: t1.leftComponent, right: Way(type: .y, len: 2 * k - 1))))
                t1.rightComponent = Way(type: .x, len: 2 * k)
                n1.n *= PathAlg.c
                continue
            }
            if canR {
                result.append((NumInt(n: n1.n), Tenzor(left: Way(type: .y, len: 2 * k - 1), right: t1.rightComponent)))
                t1.leftComponent = Way(type: .x, len: 2 * k)
                n1.n *= PathAlg.c
                continue
            }
            // x^2*x^2
            result.append((NumInt(n: n1.n), Tenzor(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .y, len: 2 * k - 1))))
            result.append((NumInt(n: n1.n * PathAlg.c), Tenzor(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .x, len: 2 * k))))
            result.append((NumInt(n: n1.n * PathAlg.c), Tenzor(left: Way(type: .x, len: 2 * k), right: Way(type: .y, len: 2 * k - 1))))
            t1.leftComponent = Way(type: .x, len: 2 * k)
            t1.rightComponent = Way(type: .x, len: 2 * k)
            n1.n *= PathAlg.c * PathAlg.c
        }
        return removeZerosAndDubles(result)
    }

    private static func removeZerosAndDubles(_ items: [(NumInt, Tenzor)]) -> [(NumInt, Tenzor)] {
        var result: [(NumInt, Tenzor)] = []
        let myContents = items.filter { !$0.0.isZero && !$0.1.isZero }
        var hasZero = false
        for (n, w) in myContents {
            if let i = result.firstIndex(where: { $0.1.isEq(w) }) {
                result[i].0.n += n.n
                if result[i].0.isZero { hasZero = true }
            } else {
                result.append((n, w))
            }
        }
        return hasZero ? result.filter { !$0.0.isZero } : result
    }
}

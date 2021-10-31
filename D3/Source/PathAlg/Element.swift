//
//  Element.swift
//  Created by M on 02.10.2021.
//

import Foundation

final class Element {
    private(set) var contents: [(NumInt, Way)]

    init() {
        contents = []
    }

    init(way: Way, koef: Int) {
        contents = []
        add(way: way, koef: koef)
    }

    init(element: Element) {
        contents = []
        for (n, w) in element.contents {
            add(way: w, koef: n.n)
        }
    }

    var isZero: Bool {
        return contents.isEmpty
    }

    func add(way: Way, koef: Int) {
        if way.isZero || NumInt.isZero(n: koef) { return }
        if let i = contents.firstIndex(where: { $0.1.isEq(way) }) {
            contents[i].0.n += koef
            if contents[i].0.isZero {
                contents.remove(at: i)
            }
        } else {
            contents.append((NumInt(n: koef), Way(way: way)))
        }
    }

    func add(element: Element) {
        for (k, w) in element.contents {
            add(way: w, koef: k.n)
        }
    }

    func clear() {
        contents = []
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

    func compRight(element: Element) {
        comp(right: true, element: element)
    }

    func compLeft(element: Element) {
        comp(right: false, element: element)
    }

    func eqKoef(_ other: Element) -> Int {
        guard !contents.isEmpty && contents.count == other.contents.count else { return 0 }
        var kk = 0
        for i in 0 ..< contents.count {
            if !contents[i].1.isEq(other.contents[i].1) { return 0 }
            let k = contents[i].0.eqKoef(other.contents[i].0)
            if k == 0 { return 0 }
            if kk > 0 && k != kk { return 0 }
            kk = k
        }
        return kk
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

    private func comp(right isRight: Bool, element: Element) {
        var result: [(NumInt, Way)] = []
        for (k, w) in element.contents {
            result += Element.comp(right: isRight, contents: contents, way: w, koef: k.n)
        }
        contents = Element.removeZerosAndDubles(result)
    }

    private static func comp(right isRight: Bool, contents: [(NumInt, Way)], way: Way, koef: Int) -> [(NumInt, Way)] {
        if way.isZero || NumInt.isZero(n: koef) { return [] }
        var result: [(NumInt, Way)] = []
        for (n, w) in contents {
            let n1 = NumInt(n: n.n * koef)
            if n1.isZero { continue }
            let w1 = Way(way: w)
            if isRight { w1.compRight(way) } else { w1.compLeft(way) }
            if !w1.isZero { result.append((n1, w1)) }
        }
        return removeZerosAndDubles(result)
    }

    private static func removeZerosAndDubles(_ items: [(NumInt, Way)]) -> [(NumInt, Way)] {
        var result: [(NumInt, Way)] = []
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

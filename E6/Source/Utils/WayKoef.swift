//
//  Created by M on 29/12/2018.
//

struct WayKoef {
    let koefs: [Int]
    let ways: [Way]

    static var zero: WayKoef {
        return WayKoef(koefs: [], ways: [])
    }

    init(koef: Int, way: Way) {
        self.init(koefs: [koef], ways: [way])
    }

    init(koefs: [Int], ways: [Way]) {
        if koefs.count != ways.count { fatalError() }
        if koefs.count != 0 && koefs.count != 1 && koefs.count != 2 { fatalError() }
        var kk: [Int] = []
        var ww: [Way] = []
        for i in 0 ..< koefs.count {
            if ways[i].isZero || koefs[i] == 0 { continue }
            kk += [koefs[i]]
            ww += [ways[i]]
        }
        if ww.count == 2 && ww[0].isEq(ww[1]) {
            let k = kk[0] + kk[1]
            if k == 0 {
                self.koefs = []
                self.ways = []
            } else {
                self.koefs = [k]
                self.ways = [ww[0]]
            }
        } else if ww.count == 2 {
            if kk[0] != 1 && kk[0] != -1 { fatalError("bad koef \(kk[0])") }
            if kk[1] != 1 && kk[1] != -1 { fatalError("bad koef \(kk[1])") }
            if ww[0].len > ww[1].len {
                self.koefs = kk
                self.ways = ww
            } else {
                self.koefs = kk.reversed()
                self.ways = ww.reversed()
            }
        } else {
            self.koefs = kk
            self.ways = ww
        }
    }

    var isZero: Bool {
        return koefs.count == 0
    }

    var koef: Int {
        guard !isZero else { return 0 }
        if koefs.count != 1 { fatalError("koef for multiway") }
        return koefs[0]
    }

    var minus: WayKoef {
        if isZero { return self }
        return WayKoef(koefs: koefs.map { -$0 }, ways: ways)
    }

    var half: WayKoef? {
        for k in koefs {
            if k % 2 != 0 { return nil }
        }
        return WayKoef(koefs: koefs.map { $0 / 2 }, ways: ways)
    }

    var part1: WayKoef? {
        guard koefs.count == 2 else { return nil }
        return WayKoef(koef: koefs[0], way: ways[0])
    }

    var part2: WayKoef? {
        guard koefs.count == 2 else { return nil }
        return WayKoef(koef: koefs[1], way: ways[1])
    }

    func compLeft(_ w: Way) -> WayKoef {
        var kk: [Int] = []
        var ww: [Way] = []
        for i in 0 ..< koefs.count {
            let w2 = Way(way: ways[i])
            w2.compLeft(w)
            if !w2.isZero {
                kk += [koefs[i]]
                ww += [w2]
            }
        }
        return WayKoef(koefs: kk, ways: ww)
    }

    var way: Way {
        guard !isZero else { return Way() }
        if koefs.count != 1 { fatalError("way for multiway") }
        return ways[0]
    }

    func divideBy(_ item: WayKoef) -> Way? {
        if isZero { return item.isZero ? Way() : nil }
        if item.isZero { return Way() }
        if item.way.isEq(way) { return Way() }
        //guard item.way.len < way.len else { return nil }
        let w2 = Way(from: item.way.endsWith.number, to: way.endsWith.number, noZeroLen: true)
        if !w2.isZero {
            let w3 = Way(way: w2)
            w3.compRight(item.way)
            if w3.isEq(way) { return w2 }
        }
        return nil
    }

    var str: String {
        guard !isZero else { return "0" }
        let sfx = koefs.count == 2 ? ((koefs[1] == 1 ? "+" : "-") + ways[1].shortStr) : ""
        let kStr: String
        switch koefs[0] {
        case 1: kStr = ""
        case -1: kStr = "-"
        case 2: kStr = "2"
        case -2: kStr = "-2"
        default: fatalError("Bad koef \(koefs[0])")
        }
        return kStr + ways[0].shortStr + sfx
    }

    func isEq(_ other: WayKoef, koef: Int) -> Bool {
        guard koefs.count == other.koefs.count else { return false }
        guard !isZero else { return true }
        for i in 0 ..< ways.count {
            if !ways[i].isEq(other.ways[i]) { return false }
            if koefs[i] != koef * other.koefs[i] { return false }
        }
        return true
    }
}

extension Array where Element == WayKoef {
    func isEq(_ k2: [WayKoef]) -> Bool {
        return isEq(k2, koef: 1) || isEq(k2, koef: -1)
    }

    func isEq(_ k2: [WayKoef], koef: Int) -> Bool {
        for i in 0 ..< count {
            if !self[i].isEq(k2[i], koef: koef) { return false }
        }
        return true
    }

    var str: String {
        if count == 1 { return "\(self[0].str)" }
        return "(" + self.map { $0.str }.joined(separator: "\\text{; }") + ")"
    }
}

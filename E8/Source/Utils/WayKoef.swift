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
        if koefs.count != 0 && koefs.count != 1 && koefs.count != 2 && koefs.count != 3 { fatalError() }
        var kk: [Int] = []
        var ww: [Way] = []
        for i in 0 ..< koefs.count {
            if ways[i].isZero || koefs[i] == 0 { continue }
            kk += [koefs[i]]
            ww += [ways[i]]
        }
        if ww.count == 2 && ww[0].isEq(ww[1]) {
            let k = kk[0] + kk[1]
            kk.remove(at: 1)
            ww.remove(at: 1)
            if k == 0 {
                kk.remove(at: 0)
                ww.remove(at: 0)
            } else {
                kk[0] = k
            }
        }
        if ww.count > 2 && ww[0].isEq(ww[2]) {
            let k = kk[0] + kk[2]
            kk.remove(at: 2)
            ww.remove(at: 2)
            if k == 0 {
                kk.remove(at: 0)
                ww.remove(at: 0)
            } else {
                kk[0] = k
            }
        }
        if ww.count > 1 && ww[0].isEq(ww[1]) {
            let k = kk[0] + kk[1]
            kk.remove(at: 1)
            ww.remove(at: 1)
            if k == 0 {
                kk.remove(at: 0)
                ww.remove(at: 0)
            } else {
                kk[0] = k
            }
        }

        if ww.count == 2 {
            if ww[0].len > ww[1].len {
                self.koefs = kk
                self.ways = ww
            } else {
                self.koefs = kk.reversed()
                self.ways = ww.reversed()
            }
        } else if ww.count == 3 {
            if kk[0] != 1 && kk[0] != -1 { fatalError("bad koef \(kk[0])") }
            if kk[1] != 1 && kk[1] != -1 { fatalError("bad koef \(kk[1])") }
            if kk[2] != 1 && kk[2] != -1 { fatalError("bad koef \(kk[2])") }
            self.koefs = kk
            self.ways = ww
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
        let koefStr: (Int, Bool) -> String = { k, withPlus in
            if k == -1 { return "-" }
            if k == 1 { return withPlus ? "+" : "" }
            return k > 0 && withPlus ? "+\(k)" : "\(k)"
        }
        let sfx: String
        switch koefs.count {
        case 1: sfx = ""
        case 2: sfx = koefStr(koefs[1], true) + ways[1].shortStr
        case 3: sfx = koefStr(koefs[1], true) + ways[1].shortStr + koefStr(koefs[2], true) + ways[2].shortStr
        default: fatalError("Bad koefs count \(koefs.count)")
        }
        return koefStr(koefs[0], false) + ways[0].shortStr + sfx
    }

    var longStr: String {
        guard !isZero else { return "0" }
        let koefStr: (Int, Bool) -> String = { k, withPlus in
            if k == -1 { return "-" }
            if k == 1 { return withPlus ? "+" : "" }
            return k > 0 && withPlus ? "+\(k)" : "\(k)"
        }
        let sfx: String
        switch koefs.count {
        case 1: sfx = ""
        case 2: sfx = koefStr(koefs[1], true) + ways[1].str
        case 3: sfx = koefStr(koefs[1], true) + ways[1].str + koefStr(koefs[2], true) + ways[2].str
        default: fatalError("Bad koefs count \(koefs.count)")
        }
        return koefStr(koefs[0], false) + ways[0].str + sfx
    }

    var printStr: String {
        return str
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

    var longStr: String {
        if count == 1 { return "\(self[0].longStr)" }
        return "(" + self.map { $0.longStr }.joined(separator: "\\text{; }") + ")"
    }

    var isZero: Bool {
        return !contains(where: { !$0.isZero })
    }

    var nonZeroLen: Int {
        var ll = 0
        for wk in self {
            for way in wk.ways { ll += way.len }
        }
        return ll
    }

    var weight: Int {
        var w = 0
        for wk in self {
            if wk.isZero { continue }
            w += wk.koefs.reduce(0, { $0 + abs($1) })
        }
        return w
    }

    func isSummand(of other: [WayKoef]) -> Int? {
        guard count == other.count || isZero else { return nil }
        var kk: Int?
        for i in 0 ..< count {
            if self[i].isZero { continue }
            if other[i].isZero { return nil }
            if self[i].ways.count != 1 { return nil }
            if self[i].koefs[0] != 1 && self[i].koefs[0] != -1 { return nil }
            guard let ii = other[i].ways.firstIndex(where: { $0.isEq(self[i].ways[0]) }) else {
                return nil
            }
            if let kk = kk {
                if (kk * self[i].koefs[0]) != other[i].koefs[ii] { return nil }
            } else {
                kk = other[i].koefs[ii] / self[i].koefs[0]
            }
        }
        return kk
    }

    func addSummand(other: [WayKoef], koef: Int) -> [WayKoef]? {
        if count != other.count { fatalError() }

        var items: [WayKoef] = []
        for i in 0 ..< count {
            if other[i].isZero {
                items.append(WayKoef(koefs: self[i].koefs, ways: self[i].ways))
                continue
            }
            if other[i].ways.count != 1 { fatalError() }
            var koefs: [Int] = self[i].koefs
            var ways: [Way] = self[i].ways
            if let ii = ways.firstIndex(where: { $0.isEq(other[i].ways[0]) }) {
                koefs[ii] += koef * other[i].koefs[0]
                if koefs[ii] == 0 {
                    koefs.remove(at: ii)
                    ways.remove(at: ii)
                }
            } else {
                koefs += [koef * other[i].koefs[0]]
                ways += [other[i].ways[0]]
            }
            if koefs.count > 3 { return nil }
            if koefs.count == 3 && koefs.contains(where: { abs($0) > 1 }) { return nil }
            items.append(WayKoef(koefs: koefs, ways: ways))
        }
        return items
    }

    func isDividedBy(_ other: [WayKoef]) -> (Way, Int)? {
        guard count == other.count else { return nil }
        var dd: (way: Way, koef: Int)?
        for i in 0 ..< count {
            let w1 = self[i]
            let w2 = other[i]
            if w1.isZero && w2.isZero { continue }
            if w1.isZero || w2.isZero { return nil }
            if w1.ways.count != 1 || w2.ways.count != 1 { return nil }
            if abs(w1.koefs[0]) != 1 || abs(w2.koefs[0]) != 1 { return nil }
            let w = Way(from: w2.ways[0].endsWith.number, to: w1.ways[0].endsWith.number, noZeroLen: true)
            if w.isZero { return nil }
            if (w.len + w2.ways[0].len > 6) { return nil }
            if let dd = dd {
                if !dd.way.isEq(w) { return nil }
                if w1.koefs[0] / w2.koefs[0] != dd.koef { return nil }
            } else {
                dd = (w, w1.koefs[0] / w2.koefs[0])
            }
        }
        return dd
    }

    func dividePartBy(_ other: [WayKoef]) -> (Way, Int)? {
        guard count == other.count else { return nil }
        for i in 0 ..< count {
            let w1 = self[i]
            let w2 = other[i]
            if w1.isZero || w2.isZero { continue }
            if w2.ways.count != 1 || abs(w2.koefs[0]) != 1 { return nil }
            for j in 0 ..< w1.ways.count {
                let w = Way(from: w2.ways[0].endsWith.number, to: w1.ways[j].endsWith.number, noZeroLen: true)
                if w.isZero { continue }
                return (w, w1.koefs[j] / w2.koefs[0] > 0 ? 1 : -1)
            }
        }
        return nil
    }

    func compLeft(way: Way) -> [WayKoef] {
        var items: [WayKoef] = []
        for i in 0 ..< count {
            var koefs: [Int] = []
            var ways: [Way] = []
            for j in 0 ..< self[i].ways.count {
                let ww = Way(way1: self[i].ways[j], way2: way)
                if !ww.isZero {
                    koefs.append(self[i].koefs[j])
                    ways.append(ww)
                }
            }
            items.append(WayKoef(koefs: koefs, ways: ways))
        }
        return items
    }
}

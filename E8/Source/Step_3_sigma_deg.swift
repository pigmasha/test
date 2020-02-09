//
//  Created by M on 30.03.18.
//

struct Step_3_sigma_deg {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "s=\(PathAlg.s), char=\(PathAlg.charK)")
        //processInnerDeg()
        let s = PathAlg.s
        let sDeg = sigmaDeg()
        var myDeg = 1
        while true {
            var isSame = true
            // vertices
            for i in 0 ..< 8 * s {
                var v = i
                for _ in 0 ..< myDeg { v = PathAlg.sigma(v) }
                if !Vertex(i: v).isEq(Vertex(i: i)) {
                    isSame = false
                    break
                }
            }
            if !isSame { myDeg += 1; continue }

            // arrows
            for i in 0 ..< 9 {
                for j in 0 ..< s {
                    let from = i == 8 ? 0 : i
                    let to = i == 4 ? 7 : (i == 8 ? 5 : i + 1)
                    let w = Way(from: from+8*j, to: to+8*j)
                    if w.isZero || w.len != 1 {
                        OutputFile.writeLog(.error, "Zero way \(from) -> \(from + 1)")
                        return true
                    }
                    let c = Comb(tenzor: Tenzor(left: w, right: Way(from: 0, to: 0)), koef: 1)
                    let c0 = Comb(comb: c)
                    for _ in 0 ..< myDeg { c.twist() }
                    if c.compareK(c0) != 1 {
                        isSame = false
                        break
                    }
                }
            }
            if !isSame { myDeg += 1; continue }
            break
        }

        if myDeg != sDeg {
            OutputFile.writeLog(.error, "Deg=\(sDeg), right=\(myDeg)")
            return true
        }
        return false
    }

    /*private static func processInnerDeg() {
        let n = PathAlg.n
        let s = PathAlg.s

        let s0 = 2*s / Utils.gcd(n+s, j: 2*s)
        if PathAlg.charK == 2 || s0 % 4 == 0 { return }

        // vertices
        for i in 0 ..< 8*s {
            var v = i
            for _ in 0 ..< s0 { v = PathAlg.sigma(v) }
            if !Vertex(i: v).isEq(Vertex(i: i)) { OutputFile.writeLog(.error, "Vertices not same") }
        }

        let eArr = [0, 1, 2, 3, 4*s+1, 4*s+2]
        var deg2 = 1
        var hasInner = false
        for _ in 0 ..< eArr.count - 1 { deg2 *= 2 }
        for i in 0 ..< deg2 {
            var i0 = i
            let ways = WaysComb()
            for p in 0 ..< s {
                ways.addPair(WayExactPair(way: Way(from: 4*p + eArr[0], to: 4*p + eArr[0]), koef: 1))
            }
            for j in 1 ..< eArr.count {
                for p in 0 ..< s {
                    ways.addPair(WayExactPair(way: Way(from: 4*p + eArr[j], to: 4*p + eArr[j]), koef: i0 % 2 == 0 ? 1 : -1))
                }
                i0 /= 2
            }
            if (isInner(ways: ways, deg: s0)) {
                hasInner = true
                var i0 = i
                let ways = WaysComb()
                ways.addPair(WayExactPair(way: Way(from: eArr[0], to: eArr[0]), koef: 1))
                for j in 1 ..< eArr.count {
                    ways.addPair(WayExactPair(way: Way(from: eArr[j], to: eArr[j]), koef: i0 % 2 == 0 ? 1 : -1))
                    i0 /= 2
                }
                OutputFile.writeLog(.normal, "Inner! \(ways.str)")
            }
        }
        if !hasInner { OutputFile.writeLog(.error, "No inner") }
    }

    private static func isInner(ways: WaysComb, deg: Int) -> Bool {
        let s = PathAlg.s
        for i in 0 ..< s {
            for j in 0 ..< 7 {
                let way: Way
                if j == 6 {
                    way = Way(from: 4*i-1, to: 4*i) // gamma
                } else {
                    way = j < 3 ? Way(from: 4*i+j, to: 4*i+j+1) : Way(from: 4*(i+s)+j-3, to: 4*(i+s)+j-3+1)
                }
                let mult = WaysComb()
                mult.addComb(ways)
                mult.compRight(way)
                mult.compRight(ways)

                let c = Comb(tenzor: Tenzor(left: way, right: Way(from: 0, to: 0)), koef: 1)
                for _ in 0 ..< deg { c.twist() }
                if mult.content.count != 1 { return false }
                if !mult.content[0].way.isEq(way) { return false }
                if mult.content[0].koef != c.content[0].koef { return false }
            }
        }
        return true
    }*/
}

/*final class WayExactPair {
    let way: Way
    var koef: Double

    init(way: Way, koef: Double) {
        self.way = Way(way: way)
        self.koef = koef
    }
}

final class WaysComb {
    var content: [WayExactPair] { return ways }
    var isZero: Bool { return ways.count == 0 }
    private var ways: [WayExactPair] = []

    func compRight(_ way: Way) {
        if isZero { return }

        for pair in ways {
            pair.way.compRight(way)
        }
        normalForm()
    }

    func compRight(_ comb: WaysComb) {
        if isZero { return }

        var resultContent: [WayExactPair] = []
        for pair in comb.content {
            let c1 = WaysComb()
            c1.addComb(self)
            for pair2 in c1.content {
                pair2.way.compRight(pair.way)
                pair2.koef *= pair.koef
            }
            resultContent += c1.content
        }
        ways = resultContent
        normalForm()
    }

    func addComb(_ comb: WaysComb) {
        for pair in comb.content {
            ways.append(WayExactPair(way: pair.way, koef: pair.koef))
        }
        normalForm()
    }

    func addPair(_ pair: WayExactPair) {
        ways.append(WayExactPair(way: pair.way, koef: pair.koef))
        normalForm()
    }

    var str: String {
        if isZero { return "0" }
        var ss = ""
        for item in ways {
            let koef = Int(item.koef)
            if koef > 0 && ss != "" { ss += "+" }
            if koef != 1 {
                ss += (koef == -1) ? "-" : "\(koef)"
            }
            ss += item.way.str
        }
        return ss
    }

    private func normalForm() {
        let charK = PathAlg.charK
        var hasElem = true
        while hasElem {
            hasElem = false

            for i in 0 ..< ways.count {
                let pp1 = ways[i]
                let koef = Int(pp1.koef)
                if (charK == 0 && koef == 0) || (charK > 0  && (koef % charK == 0)) || pp1.way.isZero {
                    ways.remove(at: i)
                    hasElem = true
                    break
                }

                for j in 0 ..< i {
                    let pp2 = ways[j]
                    if pp2.way.isEq(pp1.way) {
                        pp2.koef = pp2.koef + pp1.koef
                        ways.remove(at: i)
                        hasElem = true
                        break
                    }
                }
                if (hasElem) { break }
            }
        }
    }
}
*/

//
//  Created by M on 30/09/2021.
//

struct Step_0_check_alg {
    static func runCase() -> Bool {
        let ways = Way.allWays
        OutputFile.writeLog(.normal, "ways=" + ways.map { $0.str }.joined(separator: ", "))
        if ways.count != 4 * (PathAlg.n1 + PathAlg.n2 + PathAlg.n3) { return true }
        if checkWays(ways) { return true }
        return checkTenzors(for: ways)
    }

    private static func checkWays(_ ways: [Way]) -> Bool {
        for w1 in ways {
            for w2 in ways {
                if w1.len > 0 && w2.len > 0 { continue }
                let e = Element(way: w1, koef: 1)
                e.compLeft(element: Element(way: w2, koef: -1))
                if w1.len == 0 && w2.len == 0 {
                    if e.isZero && w1.startVertex == w2.endVertex {
                        OutputFile.writeLog(.error, "compLeft zero for vertices \(w1.str) & \(w2.str)")
                        return true
                    }
                    if !e.isZero && w1.startVertex != w2.endVertex {
                        OutputFile.writeLog(.error, "compLeft not zero for vertices \(w1.str) & \(w2.str)")
                        return true
                    }
                } else if w1.len == 0 {
                    if e.isZero && w2.startVertex == w1.endVertex {
                        OutputFile.writeLog(.error, "compLeft zero for vertex and way \(w1.str) & \(w2.str)")
                        return true
                    }
                    if !e.isZero && w2.startVertex != w1.endVertex {
                        OutputFile.writeLog(.error, "compLeft not zero for vertex and way \(w1.str) & \(w2.str)")
                        return true
                    }
                } else {
                    if e.isZero && w2.endVertex == w1.endVertex {
                        OutputFile.writeLog(.error, "compLeft zero for way and vertex \(w1.str) & \(w2.str)")
                        return true
                    }
                    if !e.isZero && w2.endVertex != w1.endVertex {
                        OutputFile.writeLog(.error, "compLeft not zero for way and vertex \(w1.str) & \(w2.str)")
                        return true
                    }
                }
            }
        }
        for w1 in ways {
            if w1.len == 0 { continue }
            for w2 in ways {
                if w2.isEq(w1) { continue }
                for w3 in ways {
                    let ee: () -> Element = {
                        let e = Element(way: w1, koef: 1)
                        e.add(way: w2, koef: 1)
                        return e
                    }
                    let e1 = ee()
                    let e2 = Element(way: w3, koef: 1)
                    e1.compLeft(element: e2)
                    //OutputFile.writeLog(.normal, "\(e2.str) * \(ee().str) = \(e1.str)")
                    e2.compRight(element: ee())
                    if e1.str != e2.str {
                        OutputFile.writeLog(.error, "Diff elements \(e1.str) & \(e2.str)")
                        return true
                    }
                }
            }
        }
        return false
    }

    private static func checkTenzors(for ways: [Way]) -> Bool {
        var tenzors: [Tenzor] = []
        for w1 in ways {
            for w2 in ways {
                tenzors.append(Tenzor(left: w1, right: w2))
            }
        }
        for t1 in tenzors {
            for t2 in tenzors {
                let c1 = Comb(tenzor: t1, koef: 1)
                let c2 = Comb(tenzor: t2, koef: -1)
                c1.compRight(comb: c2)
                let e1 = Element(way: t1.leftComponent, koef: -1)
                e1.compLeft(element: Element(way: t2.leftComponent, koef: 1))
                let e2 = Element(way: t1.rightComponent, koef: 1)
                e2.compRight(element: Element(way: t2.rightComponent, koef: 1))
                if c1.str == e1.str + "*" + e2.str { continue }
                if (e1.isZero || e2.isZero) && !c1.isZero { return true }
                if c1.isZero && !e1.isZero && !e2.isZero { return true }
                if c1.isZero { continue }
                if c1.contents.count != e1.contents.count * e2.contents.count { return true }
                for (n1, w1) in e1.contents {
                    for (n2, w2) in e2.contents {
                        let t = Tenzor(left: w1, right: w2)
                        guard let i = c1.contents.firstIndex(where: { _, tt in tt.isEq(t) }) else { return true }
                        if c1.contents[i].0.n != n1.n * n2.n { return true }
                    }
                }
                //OutputFile.writeLog(.normal, s1 + c1.str + " // " + e1.str + "*" + e2.str)
            }
        }
        return false
    }
}

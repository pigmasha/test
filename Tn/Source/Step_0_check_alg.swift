//
//  Created by M on 30/09/2021.
//

struct Step_0_check_alg {
    static func runCase() -> Bool {
        let ways = Way.allWays
        OutputFile.writeLog(.normal, "ways=" + ways.map { $0.str }.joined(separator: ", "))
        if ways.count != 2 * ways.filter({ $0.hasBeta }).count { return true }
        if !checkWays(ways) { return true }
        if !checkFromTo(ways) { return true }
        return false
    }

    private static func checkWays(_ ways: [Way]) -> Bool {
        for w1 in ways {
            for w2 in ways {
                let e = Element(way: w1, koef: 1)
                e.compLeft(element: Element(way: w2, koef: -1))
                if e.isZero { continue }
                let e2 = Element(way: w2, koef: 1)
                e2.compRight(element: Element(way: w1, koef: -1))
                if e.eqKoef(e2) != 1 {
                    OutputFile.writeLog(.normal, "\(e2.str) != \(e.str); \(w1.str) \(w2.str)")
                    return false
                }
            }
        }
        return true
    }

    private static func checkFromTo(_ ways: [Way]) -> Bool {
        var m: [String: Way] = [:]
        for w in ways {
            guard w.len == 1 else { continue }
            let k = "\(w.startVertex)-\(w.endVertex)"
            if m[k] != nil {
                OutputFile.writeLog(.error, "Duplicate ways, k=" + k + ", way=" + w.str)
                return false
            }
            m[k] = w
        }
        for i in 1 ... PathAlg.n + 1 {
            for j in 1 ... PathAlg.n + 1 {
                if i == j { continue }
                let w = Way(from: i, to: j)
                let k = "\(i)-\(j)"
                if w.isZero {
                    if let w1 = m[k] {
                        OutputFile.writeLog(.error, "Zero way \(i) -> \(j), should be " + w1.str)
                        return false
                    }
                    continue
                }
                if w.startVertex != i || w.endVertex != j {
                    OutputFile.writeLog(.error, "Bad way \(i) -> \(j), bad start or end vertex, way=" + w.str)
                    return false
                }
                guard let w1 = m[k] else {
                    OutputFile.writeLog(.error, "Bad way \(i) -> \(j), should be zero, way=" + w.str)
                    return false
                }
                if !w.isEq(w1) {
                    OutputFile.writeLog(.error, "Bad way \(i) -> \(j), should be \(w1.str), way=" + w.str)
                    return false
                }
                m[k] = nil
            }
        }
        if !m.isEmpty {
            OutputFile.writeLog(.error, "Unused ways " + m.values.map { $0.str }.joined(separator: ", "))
        }
        return true
    }
}

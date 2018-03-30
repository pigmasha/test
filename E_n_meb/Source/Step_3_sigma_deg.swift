//
//  Created by M on 30.03.18.
//

struct Step_3_sigma_deg {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "s=\(PathAlg.s), char=\(PathAlg.charK)")

        let sDeg = sigmaDeg()
        var myDeg = 1
        while true {
            var isSame = true
            // vertices
            for i in 0 ..< 7 {
                let from = i < 4 ? i : i + 4 * PathAlg.s - 4
                var v = from
                for _ in 0 ..< myDeg { v = PathAlg.sigma(v) }
                if !Vertex(i: v).isEq(Vertex(i: from)) {
                    isSame = false
                    break
                }
            }
            if !isSame {
                myDeg += 1
                continue
            }

            // arrows
            for i in 0 ..< 7 {
                let from = (i < 4) ? i : i + 4 * PathAlg.s - 4
                let w = Way(from: from, to: from + 1)
                if w.isZero {
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
            if !isSame {
                myDeg += 1
                continue
            }
            break
        }

        if myDeg != sDeg {
            OutputFile.writeLog(.error, "Deg=\(sDeg), right=\(myDeg)")
            return true
        }
        return false
    }
}

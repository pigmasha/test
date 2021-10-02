//
//  Created by M on 30/09/2021.
//

struct Step_0_check_alg {
    enum StepErr: String {
        case badZeroLenWay, zeroCheck, longWay, startsWith, endsWith, parseStart, parseEnd
    }
    static func runCase() -> Bool {
        OutputFile.writeLog(.simple, "<font face='courier'>")
        OutputFile.writeLog(.bold, "k=\(PathAlg.k), c=\(PathAlg.c), d=\(PathAlg.d), char=\(PathAlg.charK)")
        var ways: [Way] = []
        for l in 0 ... 3 * PathAlg.k {
            let way1 = Way(type: .x, len: l)
            let way2 = Way(type: .y, len: l)
            if !way1.isZero && !ways.contains(where: { way1.isEq($0) }) { ways.append(way1) }
            if !way2.isZero && !ways.contains(where: { way2.isEq($0) }) { ways.append(way2) }
        }
        OutputFile.writeLog(.normal, "ways=" + ways.map { $0.str }.joined(separator: ", "))
        if ways.count != 4 * PathAlg.k { return true }

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
                    let eS = ee().str
                    let e2 = Element(way: w3, koef: 1)
                    e1.compLeft(element: e2)
                    OutputFile.writeLog(.normal, "\(e2.str) * \(eS) = \(e1.str)")
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
}

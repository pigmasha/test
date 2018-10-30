//
//  Created by M on 26/10/2018.
//

struct Step_1_calc_s {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")

        for i in 0 ... 3 {
            var resModuls: [PHomo] = []
            let w = maxLenWay(end: i)
            resModuls += [PHomo(from: [w.startsWith.number], to: [w.endsWith.number], matrix: [[w]])]
            var resStr = "&rarr;S" + kStr(i) + "&rarr;&nbsp;0"
            for i in 0 ..< resModuls.count {
                resStr = "&rarr;" + pStr(resModuls[i].to) + resStr
            }
            OutputFile.writeLog(.normal, resStr)
        }
        return false
    }

    private static func maxLenWay(end: Int) -> Way {
        var way = Way(from: end, to: end, noZeroLen: true)
        if way.isZero { way = Way(from: end, to: end) }
        var cnt = 1
        for i in 0 ... PathAlg.vertexMod {
            let w = Way(from: i, to: end)
            if !w.isZero && w.len > way.len {
                way = w
                cnt = 1
            }
            if !w.isZero && w.len == way.len && !w.isEq(way) {
                cnt += 1
            }
        }
        if cnt != 1 || way.len == 0 { fatalError("Search way error: \(cnt) different ways \(way.htmlStr)") }
        return way
    }

    private static func kStr(_ k: Int) -> String {
        return k == 0 ? "<sub>rt</sub>" : "<sub>rt+\(k)</sub>"
    }

    private static func pStr(_ p: [Int]) -> String {
        return p.map { "P\(kStr($0))" }.joined(separator: "&oplus;")
    }

    private static func ker(_ homo: PHomo) -> [[Way]] {
        return []
    }
}

struct PHomo {
    let from: [Int]
    let to: [Int]
    let matrix: [[Way]]
}

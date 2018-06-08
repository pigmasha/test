//
//  Created by M on 23.05.2018.
//

import Foundation

struct Step_15_degs_mult {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=%d, S=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)

        let c0 = PathAlg.charK
        let s0 = PathAlg.s

        initDegsMult()
        for ch in [0, 3] {
            PathAlg.charK = ch
            for s in Array(2 ... 50) {
                PathAlg.s = s
                fillDegsMult()
            }
        }
        printDegsMult("Char not 2")

        initDegsMult()
        for ch in [2] {
            PathAlg.charK = ch
            for s in Array(2 ... 50) {
                PathAlg.s = s
                fillDegsMult()
            }
        }
        printDegsMult("<p><p>Char=2")

        PathAlg.charK = c0
        PathAlg.s = s0

        return false
    }

    static var result: [Int: [ [Int] ]] = [:]

    private static func initDegsMult() {
        for type in 1 ... 22 {
            for t2 in type ... 22 {
                result[type * 22 + t2] = []
            }
        }
    }

    private static func fillDegsMult() {
        for type in 1 ... 22 {
            for deg1 in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
                guard Dim.deg(deg1, hasType: type) else { continue }
                for deg2 in 1...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
                    for t2 in type ... 22 {
                        guard Dim.deg(deg2, hasType: t2) else { continue }
                        let deg = deg1 + deg2
                        let types = Array(1 ... 22).flatMap { Dim.deg(deg, hasType: $0) ? $0 : nil }
                        let kk = type * 22 + t2
                        let items = result[kk]!
                        if types.count == 0 && items.contains { $0.count == 0 } { continue }
                        if types.count == 1 && items.contains { $0.count == 1 && $0[0] == types[0] } { continue }
                        result[kk] = items + [types]
                    }
                }
            }
        }
    }

    private static func printDegsMult(_ prefix: String) {
        OutputFile.writeLog(.bold, "Degs mult \(prefix)")

        OutputFile.writeLog(.simple, "<table border=1><tr><td width=30>&nbsp;</td>")
        for t2 in 1 ... 22 {
            OutputFile.writeLog(.simple, "<td width=30>\(t2)</td>")
        }
        for type in 1 ... 22 {
            OutputFile.writeLog(.simple, "</tr><tr><td>\(type)</td>")
            for _ in 1 ..< type {
                OutputFile.writeLog(.simple, "<td>&nbsp;</td>")
            }
            for t2 in type ... 22 {
                let items = result[type * 22 + t2]!
                let s: String
                switch items.count {
                case 0: s = "-"
                case 1:
                    let item = items[0]
                    s = item.count == 0 ? "-" : (item.count == 1 ? "\(item[0])" : "\(item)")
                default: s = "\(items)"
                }
                OutputFile.writeLog(.simple, "<td>\(s)</td>")
            }
        }
        OutputFile.writeLog(.simple, "</tr></table>")
    }
}

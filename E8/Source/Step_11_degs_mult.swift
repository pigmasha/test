//
//  Created by M on 23.05.2018.
//

import Foundation

struct Step_11_degs_mult {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "S=\(PathAlg.s), Char=\(PathAlg.charK)")

        let c0 = PathAlg.charK
        let s0 = PathAlg.s

        initDegsMult()
        for ch in [0, 2, 3, 5] {
            PathAlg.charK = ch
            for s in (s0 == 1 ? [1] : Array(2 ... 50)) {
                PathAlg.s = s
                fillDegsMult()
            }
        }
        printDegsMult("")

        /*initDegsMult()
        for ch in [2] {
            PathAlg.charK = ch
            for s in Array(2 ... 50) {
                PathAlg.s = s
                fillDegsMult()
            }
        }
        printDegsMult("<p><p>Char=2")*/

        PathAlg.charK = c0
        PathAlg.s = s0

        return false
    }

    static var result: [Int: [ [Int] ]] = [:]

    private static func initDegsMult() {
        for type in 1 ... Dim.typeMax2 {
            for t2 in type ... Dim.typeMax2 {
                result[type * Dim.typeMax2 + t2] = []
            }
        }
    }

    private static func fillDegsMult() {
        for type in 1 ... Dim.typeMax2 {
            for deg1 in 0...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
                guard Dim.deg(deg1, hasType: type) else { continue }
                for deg2 in 0...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
                    for t2 in type ... Dim.typeMax2 {
                        guard Dim.deg(deg2, hasType: t2) else { continue }
                        let deg = deg1 + deg2
                        let types = Array(1 ... Dim.typeMax2).compactMap { Dim.deg(deg, hasType: $0) ? $0 : nil }
                        let kk = type * Dim.typeMax2 + t2
                        let items = result[kk]!
                        if items.contains(types) { continue }
                        result[kk] = items + [types]
                    }
                }
            }
        }
    }

    private static func printDegsMult(_ prefix: String) {
        OutputFile.writeLog(.bold, "Degs mult \(prefix)")

        let typeMax = PathAlg.s == 1 ? Dim.typeMax2 : Dim.typeMax
        OutputFile.writeLog(.simple, "<table border=1><tr><td width=30>&nbsp;</td>")
        for t2 in 1 ... typeMax {
            OutputFile.writeLog(.simple, "<td width=30>\(t2)</td>")
        }
        for type in 1 ... typeMax {
            OutputFile.writeLog(.simple, "</tr><tr><td>\(type)</td>")
            for _ in 1 ..< type {
                OutputFile.writeLog(.simple, "<td>&nbsp;</td>")
            }
            let itemToStr: ([Int]) -> String = { item in item == [1, 29, 30, 31, 32, 33, 34, 35, 36] ? "(*)" : "\(item)" }
            for t2 in type ... typeMax {
                let items = result[type * Dim.typeMax2 + t2]!
                let s: String
                switch items.count {
                case 0: s = "-"
                case 1:
                    let item = items[0]
                    s = item.count == 0 ? "-" : (item.count == 1 ? "\(item[0])" : itemToStr(item))
                default:
                    let itemsStr = items.map { itemToStr($0) }
                    s = "[\(itemsStr.joined(separator: ", "))]"
                }
                if PathAlg.alg.dummy1 != 0 {
                    OutputFile.writeLog(.simple, "<td>&nbsp;&nbsp;<br>&nbsp;</td>")
                } else {
                    OutputFile.writeLog(.simple, "<td>\(s)</td>")
                }
            }
        }
        OutputFile.writeLog(.simple, "</tr></table><p>(*) = [1, 29, 30, 31, 32, 33, 34, 35, 36]")
    }
}

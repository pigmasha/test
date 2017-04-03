//
//  Created by M on 17.04.16.
//
//

import Foundation

class ShiftHHGenProgram : NSObject {
    private let hhElem: HHElem
    private let shift: Int
    private let file: OutputFile

    class func printProgram(_ hhElem: HHElem, shift: Int) {
        let object = ShiftHHGenProgram(hhElem: hhElem, shift: shift)
        object.printProgram()
    }

    private func printProgram() {
        let s = PathAlg.alg.s

        file.writeln("<pre>")
        file.writeln("override func shift\(shift)(hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {")
        file.writeln("    hhElem.makeZeroMatrix(\(width / s)*s, h:\(height / s)*s)")
        file.writeln("")

        if isOnePerBlock {
            printOnePerBlockProgram();
        }

        file.writeln("}")
        file.writeln("</pre>")
    }

    private func printOnePerBlockProgram() {
        var j = -1

        for col in 0..<width {
            var i  = -1
            for row in 0..<height {
                if !hhElem.rows[row][col].isZero {
                    i = row
                    break
                }
            }
            if (i < 0) {
                continue
            }
            if (j < 0) {
                file.writeln("var j = \(stringByS(col))")
            } else {
                file.writeln("j += \(stringByS(col - j))")
            }

            printOnePerBlockProgram(col)
            j = col
        }
    }

    private func printOnePerBlockProgram(_ col: Int) {
        let m = (shift % PathAlg.alg.twistPeriod) / 2

        for row in 0..<height {
            let c = hhElem.rows[row][col]
            if !hhElem.rows[row][col].isZero {
                let t = c.firstTenzor!
                let l = t.leftComponent
                let r = t.rightComponent

                file.writeln("HHElem.addElemToHH(hhElem, i:\(iString(row, col: col)), j:j,")
                file.writeln("                   leftFrom:\(vertexString(l.startsWith, j: col, m: m)), leftTo:\(vertexString(l.endsWith, j: col, m: m)),")
                file.writeln("                   rightFrom:\(vertexString(r.startsWith, j: col, m: -1)), rightTo:\(vertexString(r.endsWith, j: col, m: -1)), koef:\((c.firstKoef == 1) ? "1" : "-1"))")
            }
        }
    }

    private func vertexString(_ v: Vertex, j: Int, m: Int) -> String {
        let s = PathAlg.alg.s
        var str = (m < 0) ? "" : "+m"
        let v0 = Vertex(i: (m < 0) ? v.number : v.number - 4 * m)

        for a in 0...1 {
            if (a > 0) {
                str += "+s"
                v0.number += 4 * s
            }
            for b in 0...7 {
                let v1 = Vertex(i: 4 * j + b)

                if (v1.isEq(v0)) {
                    let b0 = (b < 4) ? b : b - 4
                    if (b >= 4) {
                        str += "+1"
                    }
                    let prefix = (str.isEmpty) ? "4*j" : "4*(j\(str))"
                    return (b0 == 0) ? prefix : "\(prefix)+\(b0)"
                }
            }
        }
        return "???"
    }

    private func iString(_ row: Int, col: Int) -> String {
        let s = PathAlg.alg.s
        let d = row - col

        if (d % s == 0) {
            if (d == 0) { return "j" }
            if (d == s) { return "j+s" }
            if (d == -s) { return "j-s" }
            return "j" + ((d > 0) ? "+" : "") + "\(d / s)*s"
        }
        return "\(sStringPart(row))+myModS(j+1)";
    }

    private init(hhElem: HHElem, shift: Int) {
        self.hhElem = hhElem
        self.shift = shift
        file = OutputFile()
        super.init()
    }

    private func sStringPart(_ i: Int) -> String {
        let s = PathAlg.alg.s
        if (i < s) { return "" }
        if (i < 2 * s) { return "s" }
        return "\(i / s)*s"
    }

    private func stringByS(_ i: Int) -> String {
        let s = PathAlg.alg.s
        if (i < s) { return "\(i)" }
        return (i % s == 0) ? sStringPart(i) : "\(sStringPart(i)) + \(i % s)"
    }

    private var width: Int {
        return hhElem.rows.last!.count
    }

    private var height: Int {
        return hhElem.rows.count
    }

    private var isOnePerBlock: Bool {
        let s = PathAlg.alg.s

        let w = width
        let h = height

        for i in 0..<h {
            for j in 0..<w {
                if !hhElem.rows[i][j].isZero {
                    let c1 = (i / s) * s
                    let c2 = (j / s) * s

                    var count : Int = 0
                    for i1 in c1..<c1+s {
                        for j1 in c2..<c2+s {
                            if !hhElem.rows[i1][j1].isZero {
                                count += 1
                            }
                        }
                    }
                    return count == 1
                }
            }
        }
        return false
    }

}

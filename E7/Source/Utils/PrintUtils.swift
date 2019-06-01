//
//  Created by M on 09.06.17.
//

import Foundation

final class PrintUtils {
    static func printMatrix(_ prefix: String, _ m: Matrix) {
        printMatrix(prefix, m, redColumns: nil)
    }

    static func printMatrix(_ prefix: String, _ m: Matrix, redColumns: [Int]? = nil, redRows: [Int]? = nil) {
        printMatrixDeg(prefix, m, -1, -1, redColumns: redColumns, redRows: redRows)
    }

    static func printMatrixDeg(_ prefix: String, _ m: Matrix, _ degFrom: Int, _ degTo: Int) {
        printMatrixDeg(prefix, m, degFrom, degTo, redColumns: nil, redRows: nil)
    }

    static func printMatrixDeg(_ prefix: String, _ m: Matrix, _ degFrom: Int, _ degTo: Int,
                               redColumns: [Int]?, redRows: [Int]?) {
        OutputFile.writeLog(.normal, prefix)

        let posesFrom = posesFromDeg(degFrom)
        let posesTo = posesFromDeg(degTo)
        let file = OutputFile()
        file.write("<table>")
        let rows = m.rows
        for i in 0 ..< rows.count {
            let cellTop = cellBorder(i, posesTo)
            file.write("<tr>")
            let line = rows[i]
            for j in 0 ..< line.count {
                let cellLeft = cellBorder(j, posesFrom)
                file.write("<td class='c_t_\(cellTop) c_l_\(cellLeft)'")
                if (redColumns?.contains(j) ?? false) || (redRows?.contains(i) ?? false) {
                    file.write("><font color=red>" + line[j].htmlStr + "</font></td>")
                } else {
                    file.write(">" + line[j].htmlStr + "</td>")
                }
            }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    static func printMatrixKoefs(_ m: Matrix, colsMax: Int = 0, rowsMax: Int = 0) {
        printMatrixKoefsDeg(m, degFrom: -1, degTo: -1, colsMax: colsMax, rowsMax: rowsMax)
    }
    static func printMatrixKoefsDeg(_ m: Matrix, degFrom: Int, degTo: Int, colsMax: Int, rowsMax: Int) {
        let posesFrom = posesFromDeg(degFrom)
        let posesTo = posesFromDeg(degTo)
        let file = OutputFile()
        file.write("<table>")
        let rows = m.rows
        for i in 0 ..< rows.count {
            if rowsMax > 0 && rowsMax <= i { break }
            let cellTop = cellBorder(i, posesTo)
            file.write("<tr>")
            let line = rows[i]
            for j in 0 ..< line.count {
                if colsMax > 0 && colsMax <= j { break }
                let cellLeft = cellBorder(j, posesFrom)
                file.write("<td class='c_t_\(cellTop) c_l_\(cellLeft)'")
                let c = line[j]
                if c.content.count > 1 {
                    file.write(">ERROR! (sz = \(c.content.count))</td>")
                } else if c.isZero {
                    file.write(" width=16>&nbsp;</td>")
                } else {
                    file.write(" width=16>" + (c.terminateKoef(isLast: false) > 0 ? "+" : "&minus;") + "</td>")
                }
            }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    static func printIm(_ prefix: String, _ m: ImMatrix, deg: Int) {
        OutputFile.writeLog(.normal, prefix)
        let posesFrom = posesFromDeg(deg)
        let posesTo = posesFromDeg(deg + 1)

        let file = OutputFile()
        file.write("<table>")
        let rows = m.rows
        for i in 0 ..< rows.count {
            let cellTop = cellBorder(i, posesFrom)
            file.write("<tr>")
            let line = rows[i]
            for j in 0 ..< line.count {
                let cellLeft = cellBorder(j, posesTo)
                file.write("<td class='c_t_\(cellTop) c_l_\(cellLeft)'>")
                let pp = line[j]
                if pp.koef == 0 || pp.way == nil || pp.way!.isZero {
                    file.write("&nbsp;</td>")
                } else {
                    file.write(pp.koef == -1 ? "-" : (pp.koef == 1 ? "" : "\(Int(pp.koef))"))
                    file.write(pp.way!.htmlStr + "</td>")
                }
            }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    static func printKoefIntMatrix(_ m: KoefIntMatrix, deg: Int, skipLines: Int) {
        let posesFrom = posesFromDeg(deg)
        let posesTo = posesFromDeg(deg + 1)

        let file = OutputFile()
        file.write("<table>")
        let rows = m.rows
        for i in 0 ..< rows.count {
            if i < skipLines { continue }
            let cellTop = cellBorder(i, posesFrom)
            file.write("<tr>")
            let line = rows[i]
            for j in 0 ..< line.count {
                let cellLeft = cellBorder(j, posesTo)
                file.write("<td class='c_t_\(cellTop) c_l_\(cellLeft)' width=16>")
                let n = line[j]
                file.write(n.intValue == 0 ? "&nbsp;</td>" : "\(n.intValue)</td>")
            }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    private static func cellBorder(_ i: Int, _ poses: [Int]?) -> Int {
        guard i > 0 && (i % PathAlg.s) == 0 else { return 0 }
        guard let poses = poses else { return 1 }
        return poses.contains(Int(i / PathAlg.s)) ? 2 : 1
    }

    private static func posesFromDeg(_ deg: Int) -> [Int]? {
        guard deg >= 0 else { return nil }
        let q = BimodQ(deg: deg)
        var sum = 0
        var poses: [Int] = []
        for n in q.sizes {
            sum += n
            poses += [ sum ]
        }
        return poses
    }
}

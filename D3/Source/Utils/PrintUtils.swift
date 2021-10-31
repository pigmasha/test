//
//  Created by M on 09.06.17.
//

import Foundation

final class PrintUtils {
    static func printMatrix(_ prefix: String, _ m: Matrix) {
        printMatrix(prefix, m, redColumns: nil, redRows: nil)
    }

    static func printMatrix(_ prefix: String, _ m: Matrix, redColumns: [Int]? = nil, redRows: [Int]? = nil) {
        OutputFile.writeLog(.normal, prefix)

        let file = OutputFile()
        file.write("<table>")
        let rows = m.rows
        for i in 0 ..< rows.count {
            file.write("<tr>")
            let line = rows[i]
            for j in 0 ..< line.count {
                if (redColumns?.contains(j) ?? false) || (redRows?.contains(i) ?? false) {
                    file.write("<td><font color=red>" + line[j].str + "</font></td>")
                } else {
                    file.write("<td>" + line[j].str + "</td>")
                }
            }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    static func printMatrixKoefs(_ m: Matrix, colsMax: Int = 0, rowsMax: Int = 0) {
        let file = OutputFile()
        file.write("<table>")
        let rows = m.rows
        for i in 0 ..< rows.count {
            if rowsMax > 0 && rowsMax <= i { break }
            file.write("<tr>")
            let line = rows[i]
            for j in 0 ..< line.count {
                if colsMax > 0 && colsMax <= j { break }
                let c = line[j]
                if c.contents.count > 1 {
                    file.write("<td>ERROR! (sz = \(c.contents.count))</td>")
                } else if c.isZero {
                    file.write("<td width=16>&nbsp;</td>")
                } else {
                    file.write("<td width=16>" + (c.contents[0].0.n > 0 ? "+" : "&minus;") + "</td>")
                }
            }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    static func printKoefIntMatrix(_ prefix: String, _ m: KoefIntMatrix) {
        OutputFile.writeLog(.normal, prefix)

        let file = OutputFile()
        file.write("<table>")
        file.write("<tr><td>" + m.ways.map { $0.str }.joined(separator: "</td><td>") + "</td></tr>")
        for line in m.rows {
            file.write("<tr>")
            line.forEach { file.write("<td>" + ($0.n == 0 ? "&nbsp;" : "\($0.n)") + "</td>") }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    static func printPMatrix(_ prefix: String, _ diff: PMatrix) {
        OutputFile.writeLog(.normal, prefix)

        let file = OutputFile()
        file.write("<table>")
        let rows = diff.rows
        for line in rows {
            file.write("<tr>")
            line.forEach { file.write("<td>" + $0.str + "</td>") }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }
}

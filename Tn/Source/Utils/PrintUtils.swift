//
//  Created by M on 09.06.17.
//

import Foundation

final class PrintUtils {
    static func printMatrix(_ prefix: String, _ m: Matrix) {
        printMatrix(prefix, m, redColumns: nil, redRows: nil)
    }

    static func printDiffMatrix(_ prefix: String, _ d: Diff) {
        printMatrix(prefix, d, redColumns: nil, redRows: nil, from: d.deg + 1, to: d.deg)
    }

    static func printMatrix(_ prefix: String, _ m: Matrix, from: Int, to: Int) {
        printMatrix(prefix, m, redColumns: nil, redRows: nil, from: from, to: to)
    }

    static func printMatrix(_ prefix: String, _ m: Matrix, redColumns: [Int]? = nil, redRows: [Int]? = nil) {
        printMatrix(prefix, m, redColumns: redColumns, redRows: redRows, from: -1, to: -1)
    }

    static func printMatrix(_ prefix: String, _ m: Matrix, redColumns: [Int]?, redRows: [Int]?, from: Int, to: Int) {
        let qFrom = from < 0 ? nil : BimodQ(deg: from)
        let qTo = to < 0 ? nil : BimodQ(deg: to)
        OutputFile.writeLog(.normal, PathAlg.isTex ? "$$" + prefix : prefix)

        let file = OutputFile()
        let rows = m.rows
        if PathAlg.isTex {
            //file.writeln("\\left(\\begin{array}{" + rows[0].map { _ in "c" }.joined() + "}")
            file.writeln("\\begin{pmatrix}")
        } else {
            file.write("<table>")
        }
        for i in 0 ..< rows.count {
            if !PathAlg.isTex { file.write("<tr>") }
            let line = rows[i]
            for j in 0 ..< line.count {
                let prefix: String
                let suffix: String
                if PathAlg.isTex {
                    prefix = j == 0 ? "" : "&"
                    suffix = ""
                } else {
                    let isRed = (redColumns?.contains(j) ?? false) || (redRows?.contains(i) ?? false)
                    let st1: String
                    if let q = qFrom, j > 0, q.pij[j].1 != q.pij[j - 1].1 {
                        st1 = "border-left:3px solid black;"
                    } else {
                        st1 = ""
                    }
                    let st2: String
                    if let q = qTo, i > 0, q.pij[i].1 != q.pij[i - 1].1 {
                        st2 = "border-top:3px solid black;"
                    } else {
                        st2 = ""
                    }
                    let st = st1 == "" && st2 == "" ? "" : " style='" + st1 + st2 + "'"
                    prefix = isRed ? "<td" + st + "><font color=red>" : "<td" + st + ">"
                    suffix = isRed ? "</font></td>" : "</td>"
                }
                file.write(prefix + line[j].str + suffix)
            }
            file.writeln(PathAlg.isTex ? "\\\\" : "</tr>")
        }
        file.write(PathAlg.isTex ? "\\end{pmatrix}$$" : "</table><p>")
    }

    static func printMatrixColumn(_ prefix: String, _ m: Matrix, _ column: Int) {
        OutputFile.writeLog(.time, prefix)

        let file = OutputFile()
        let rows = m.rows
        if PathAlg.isTex {
            file.writeln("\\left(\\begin{array}{c}")
        } else {
            file.write("<table>")
        }
        for i in 0 ..< rows.count {
            if !PathAlg.isTex { file.write("<tr>") }
            let prefix = PathAlg.isTex ? "" : "<td>"
            file.write(prefix + rows[i][column].str + (PathAlg.isTex ? "" : "</td>"))
            file.writeln(PathAlg.isTex ? "\\\\" : "</tr>")
        }
        file.write(PathAlg.isTex ? "\\end{array}\\right)" : "</table><p>")
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
        for (i, line) in m.rows.enumerated() {
            file.write("<tr><td>" + (m.ways.isEmpty ? "" : m.ways[i].str) + "</td>")
            line.forEach { file.write("<td>" + ($0.n == 0 ? "&nbsp;" : "\($0.n)") + "</td>") }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }

    static func printPMatrix(_ prefix: String, _ diff: PMatrix) {
        OutputFile.writeLog(.normal, prefix)

        let file = OutputFile()
        let rows = diff.rows
        if PathAlg.isTex {
            file.writeln("\\left(\\begin{array}{" + rows[0].map { _ in "c" }.joined() + "}")
        } else {
            file.write("<table>")
        }
        for line in rows {
            if PathAlg.isTex {
                file.write(line.map { $0.str }.joined(separator: "&") + "\\\\")
            } else {
                file.write("<tr>")
                line.forEach { file.write("<td>" + $0.str + "</td>") }
                file.writeln("</tr>")
            }
        }
        file.write(PathAlg.isTex ? "\\end{array}\\right)" : "</table><p>")
    }

    /*static func printImMatrix(_ prefix: String, _ matrix: ImMatrix) {
        printImRows(prefix, matrix.rows)
    }*/

    static func printImRows(_ prefix: String, _ rows: [[Element]]) {
        OutputFile.writeLog(.normal, prefix)

        let file = OutputFile()
        file.write("<table>")
        for line in rows {
            file.write("<tr>")
            for e in line {
                file.write("<td>" + e.str + "</td>")
            }
            file.writeln("</tr>")
        }
        file.write("</table><p>")
    }
}

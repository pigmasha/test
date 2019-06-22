//
//  Created by M on 17.04.16.
//

struct ShiftHHGenProgram {
    let hhElem: HHElem
    let shift: Int
    let isOdd: Bool
    private let file = OutputFile()

    func printProgram() {
        let s = PathAlg.s

        file.writeln("<pre>")
        if isOdd {
            file.writeln("override func oddShift\(shift)(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell: Int) {")
        } else {
            file.writeln("override func shift\(shift)(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {")
        }
        file.writeln("    hhElem.makeZeroMatrix(\(width / s)*s, h:\(height / s)*s)")
        file.writeln("")

        if isOnePerBlock {
            printOnePerBlockProgram()
        } else {
            printBlocksProgram()
        }

        file.writeln("}")
        file.writeln("</pre>")
    }

    private struct BlockItem {
        let minCol: Int
        let maxCol: Int
        let programs: [Program]

        func setPrograms(_ items: [Program]) -> BlockItem {
            return BlockItem(minCol: minCol, maxCol: maxCol, programs: items)
        }
    }

    private struct Program {
        let format: String
        let iVariants: [String]
        let k: Int
    }

    private func printBlocksProgram() {
        let s = PathAlg.s
        let w = Int(width / s)
        let h = Int(height / s)
        for blockCol in 0..<w {
            var blocks: [BlockItem] = []
            for blockRow in 0..<h {
                if let minElem = minColElementInBlock(blockRow, blockCol: blockCol),
                    let maxElem = maxColElementInBlock(blockRow, blockCol: blockCol) {
                    let program = onePerBlockProgram(minElem.col, row: minElem.row)
                    if let item = blocks.last, item.minCol == minElem.col, item.maxCol == maxElem.col {
                        blocks[blocks.count - 1] = item.setPrograms(item.programs + [program])
                        continue
                    } else {
                        blocks += [ BlockItem(minCol: minElem.col, maxCol: maxElem.col, programs: [program]) ]
                    }
                }
            }
            if blocks.count > 1 {
                for i in 0 ..< blocks.count - 1 {
                    let block = blocks[i]
                    let nextBlock = blocks[i + 1]
                    guard block.programs.count == 1 && nextBlock.programs.count == 1 else { continue }
                    guard block.programs[0].format == nextBlock.programs[0].format else { continue }
                    guard block.maxCol + 1 == nextBlock.minCol || block.minCol == nextBlock.maxCol + 1 else { continue }
                    let iVariant = block.programs[0].iVariants.first { nextBlock.programs[0].iVariants.contains($0) }
                    guard let iV = iVariant else { continue }
                    blocks[i] = BlockItem(minCol: min(block.minCol, nextBlock.minCol),
                                          maxCol: max(block.maxCol, nextBlock.maxCol),
                                          programs: [Program(format: block.programs[0].format, iVariants: [iV], k: block.programs[0].k)])
                    blocks[i + 1] = nextBlock.setPrograms([])
                }
            }
            blocks = blocks.filter { $0.programs.count > 0 }
            if blocks.count > 1 {
                for i in 0 ..< blocks.count - 1 {
                    let block = blocks[i]
                    let nextBlock = blocks[i + 1]
                    if block.minCol == nextBlock.minCol, block.maxCol == nextBlock.maxCol {
                        blocks[i] = block.setPrograms(block.programs + nextBlock.programs)
                        blocks[i + 1] = nextBlock.setPrograms([])
                    }
                }
            }
            blocks = blocks.filter { $0.programs.count > 0 }

            for item in blocks {
                file.writeln("for j in \(stringByS(item.minCol)) ..< \(stringByS(item.maxCol + 1)) {")
                file.writeln(item.programs.map(defaultProgramString).joined(separator: "") + "}")
            }
        }
    }

    private func minColElementInBlock(_ blockRow: Int, blockCol: Int) -> (row: Int, col: Int)? {
        let s = PathAlg.s
        for col in blockCol*s..<(blockCol+1)*s {
            for row in blockRow*s..<(blockRow+1)*s {
                if !hhElem.rows[row][col].isZero {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private func maxColElementInBlock(_ blockRow: Int, blockCol: Int) -> (row: Int, col: Int)? {
        let s = PathAlg.s
        var result: (row: Int, col: Int)? = nil
        for col in blockCol*s..<(blockCol+1)*s {
            for row in blockRow*s..<(blockRow+1)*s {
                if !hhElem.rows[row][col].isZero {
                    result = (row, col)
                }
            }
        }
        return result
    }

    private func printOnePerBlockProgram() {
        var j = -1

        for col in 0..<width {
            var i = -1
            for row in 0..<height {
                if !hhElem.rows[row][col].isZero {
                    i = row
                    break
                }
            }
            if (i < 0) { continue }
            if (j < 0) {
                file.writeln((hhElem.nonZeroCount == 1 ? "let" : "var") + " j = \(stringByS(col))")
            } else {
                file.writeln("j += \(stringByS(col - j))")
            }

            let program = onePerBlockProgram(col, row: nil)
            file.write(defaultProgramString(program))
            j = col
        }
    }

    private func defaultProgramString(_ program: Program) -> String {
        if program.iVariants.count > 0 {
            let str = program.format.replacingOccurrences(of: "!i", with: program.iVariants[0])
            return str.replacingOccurrences(of: "!k", with: "\(program.k)")
        } else {
            return program.format
        }
    }

    private func onePerBlockProgram(_ col: Int, row fixedRow: Int?) -> Program {
        let m = (shift % PathAlg.twistPeriod) / 2
        var str = ""
        var items: [String] = []
        var k = 0
        for row in 0..<height {
            if let rr = fixedRow, row != rr { continue }
            let c = hhElem.rows[row][col]
            if !hhElem.rows[row][col].isZero {
                let t = c.terminateTenzor(isLast: false)!
                let l = t.leftComponent
                let r = t.rightComponent

                let iS: String
                if items.count == 0 {
                    items = iString(row, col: col)
                    iS = "!i"
                } else {
                    iS = iString(row, col: col)[0]
                }
                let kS: String
                if k == 0 {
                    k = c.terminateKoef(isLast: false) == 1 || PathAlg.charK == 2 ? 1 : -1
                    kS = "!k"
                } else {
                    kS = c.terminateKoef(isLast: false) == 1 || PathAlg.charK == 2 ? "1" : "-1"
                }

                str += "HHElem.addElemToHH(hhElem, i:\(iS), j:j,"
                str += " leftFrom:\(vertexString(l.startsWith, j: col, m: m)), leftTo:\(vertexString(l.endsWith, j: col, m: m)),"
                str += " rightFrom:\(vertexString(r.startsWith, j: col, m: -1)), rightTo:\(vertexString(r.endsWith, j: col, m: -1)), koef:\(kS))\n"
                //str += "HHElem.addElemToHH(hhElem, i:\(iS), j:j,\n"
                //str += "                   leftFrom:\(vertexString(l.startsWith, j: col, m: m)), leftTo:\(vertexString(l.endsWith, j: col, m: m)),\n"
                //str += "                   rightFrom:\(vertexString(r.startsWith, j: col, m: -1)), rightTo:\(vertexString(r.endsWith, j: col, m: -1)), koef:\(kS))\n"
            }
        }
        return Program(format: str, iVariants: items, k: k)
    }

    private func vertexString(_ v: Vertex, j: Int, m: Int) -> String {
        let v0 = Vertex(i: (m < 0) ? v.number : v.number - 7 * m)
        for b in -6 ... 19 {
            guard Vertex(i: 7 * j + b).isEq(v0) else { continue }
            var str = m < 0 ? "" : "+m"
            if b >= 7 {
                str += b >= 14 ? "+2" : "+1"
            } else if b < 0 {
                str += "-1"
            }
            let prefix = str.isEmpty ? "7*j" : "7*(j\(str))"
            let b0 = b < 0 ? (b + 7) % 7 : b % 7
            return b0 == 0 ? prefix : "\(prefix)+\(b0)"
        }
        return "???"
    }

    private func iString(_ row: Int, col: Int) -> [String] {
        let s = PathAlg.s
        let d = row - col

        if (d % s == 0) {
            if (d == 0) { return ["j"] }
            if (d == s) { return ["j+s"] }
            if (d == -s) { return ["j-s"] }
            return ["j" + ((d > 0) ? "+" : "") + "\(d / s)*s"]
        }
        var result = ["\(sStringPart(row))+myModS(j+1)"]
        if (col + 1) % s == (col + 1) % (2*s) {
            result += ["\(sStringPart(row))+myMod2S(j+1)"]
        } else {
            result += ["\(sStringPart(row))+myMod2S(j+s+1)"]
            if row >= s {
                result += ["\(sStringPart(row-s))+myMod2S(j+1)"]
            }
        }
        if row >= s && ((col + s + 1) % (2*s) == s + (col + 1) % s) {
            result += ["\(sStringPart(row-s))+myMod2S(j+s+1)"]
        }
        return result;
    }

    private func sStringPart(_ i: Int) -> String {
        let s = PathAlg.s
        if (i < s) { return "" }
        if (i < 2 * s) { return "s" }
        return "\(i / s)*s"
    }

    private func stringByS(_ i: Int) -> String {
        let s = PathAlg.s
        if (i < s) { return (i == s - 1) ? "s - 1" : "\(i)" }
        switch i % s {
        case 0: return sStringPart(i)
        case s - 1: return "\(sStringPart(i + 1)) - 1"
        default: return "\(sStringPart(i)) + \(i % s)"
        }
    }

    private var width: Int {
        return hhElem.rows.last!.count
    }

    private var height: Int {
        return hhElem.rows.count
    }

    private var isOnePerBlock: Bool {
        let s = PathAlg.s
        let w = width
        let h = height

        for i in 0..<h {
            for j in 0..<w {
                if !hhElem.rows[i][j].isZero {
                    let c1 = (i / s) * s
                    let c2 = (j / s) * s

                    var count = 0
                    for i1 in c1..<c1+s {
                        for j1 in c2..<c2+s {
                            if !hhElem.rows[i1][j1].isZero {
                                count += 1
                            }
                        }
                    }
                    if count > 2 { return false }
                }
            }
        }
        return true
    }

}

//
//  HHProgram.swift

//

struct HHProgram {
    let hhElem: HHElem
    let deg: Int
    let type: Int
    private let file = OutputFile()

    func printProgram() {
        let s = PathAlg.s
        var ss = "<pre>private func createHH\(type)() {\n"
        ss += "    let s = PathAlg.s\n"
        ss += "    makeZeroMatrix(\(width / s)*s, h: \(height / s)*s)\n"
        file.writeln(ss)
        if isOnePerBlock {
            printOnePerBlockProgram()
        } else {
            printBlocksProgram()
        }
        file.writeln("}</pre>")
    }

    private func printBlocksProgram() {
        var ss = ""
        for j in 0 ..< hhElem.width {
            guard j % PathAlg.s == 0 else { continue }
            var hasNonZero = false
            for i in 0 ..< hhElem.height {
                let c = hhElem.rows[i][j]
                if !c.isZero { hasNonZero = true; break }
            }
            guard hasNonZero else { continue }
            ss += "    for j in \(colForJ(j)) ..< \(colForJ(j+PathAlg.s)) {\n"
            for i in 0 ..< hhElem.height {
                let c = hhElem.rows[i][j]
                guard !c.isZero else { continue }
                let t = c.content[0].tenzor
                ss += "        HHElem.addElemToHH(self, i:\(rowRowJ(j, i)), j:j, "
                    + "leftFrom:\(koefStr(t.leftComponent.startsWith, j)), leftTo:\(koefStr(t.leftComponent.endsWith, j)), "
                    + "right:\(koefStr(t.rightComponent.startsWith, j)), koef:\(Int(c.content[0].koef)))\n"
            }
            ss += "    }\n"
        }
        file.write(ss)
    }

    private func printOnePerBlockProgram() {
        for j in 0..<width {
            for i in 0..<height {
                let c = hhElem.rows[i][j]
                guard !c.isZero else { continue }
                let t = c.content[0].tenzor
                file.writeln("    HHElem.addElemToHH(self, i:\(rowRowJ(j, i)), j:\(j), "
                    + "leftFrom:\(koefStr(t.leftComponent.startsWith, j)), leftTo:\(koefStr(t.leftComponent.endsWith, j)), "
                    + "right:\(koefStr(t.rightComponent.startsWith, j)), koef:\(Int(c.content[0].koef)))")
            }
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
                    if count > 1 { return false }
                }
            }
        }
        return true
    }

    private func colForJ(_ j: Int) -> String {
        let s = PathAlg.s
        if j == 0 { return "0" }
        if j == s { return "s" }
        if j % s == 0 { return "\(j/s)*s" }
        return "???"
    }

    private func rowRowJ(_ j: Int, _ i: Int) -> String {
        let s = PathAlg.s
        guard i % s == 0 else { return "???" }
        guard i != j else { return "j" }
        let m = (i - j) / s
        return m == 1 ? "j+s" : (m == -1 ? "j-s" : (m < 0 ? "j\(m)*s" : "j+\(m)*s"))
    }

    private func koefStr(_ v: Vertex, _ j: Int) -> String {
        let n = PathAlg.n
        let dd = myMod(v.number - n * j, mod: n * PathAlg.s)
        let m1 = dd / n
        //let m2 = m1 == PathAlg.s - 1 ? -1 : m1
        //let ss = m1 == 0 ? "\(n)*j" : "\(n)*(j" + (m2 < 0 ? "" : "+") + "\(m2))"
        let ss = m1 == 0 ? "\(n)*j" : "\(n)*(j+\(m1))"
        return dd == n * m1 ? ss : "\(ss)+\(dd - n * m1)"
    }
}

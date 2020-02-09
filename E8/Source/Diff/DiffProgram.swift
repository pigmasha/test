//
//  E8
//  Created by M on 26/03/2019.
//

import Foundation

struct DiffProgram {
    static func diffProgram(_ diff: Diff, deg: Int) {
        let s = PathAlg.s
        let m = deg / 2
        var ss = "<pre>private func createDiffWithNumber\(deg)() {\n"
        ss += "    let s = PathAlg.s\n"
        ss += "    let m = \(m)\n"
        ss += "    makeZeroMatrix(\(diff.width / s)*s, h: \(diff.height / s)*s)\n\n"
        for j in 0 ..< diff.width {
            guard j % s == 0 else { continue }
            ss += "    for j in \(colForJ(j)) ..< \(colForJ(j+s)) {\n"
            for i in 0 ..< diff.height {
                let c = diff.rows[i][j]
                guard !c.isZero else { continue }
                let t = c.content[0].tenzor
                ss += "        addTenToPos(\(rowRowJ(j, i)), j, "
                    + "\(koefStr(t.leftComponent.startsWith, j + m, jStr: "j+m")), "
                    + "\(koefStr(t.leftComponent.endsWith, j + m, jStr: "j+m")), "
                    + "\(koefStr(t.rightComponent.startsWith, j, jStr: "j")), "
                    + "\(koefStr(t.rightComponent.endsWith, j, jStr: "j")), \(Int(c.content[0].koef)))\n"
            }
            ss += "    }\n"
        }
        ss += "}</pre>\n"
        OutputFile.writeLog(.simple, ss)
    }

    static func diffKoefsProgram(_ diff: Diff, deg: Int) {
        let s = PathAlg.s
        let m = deg / 2
        var ss = "<pre>private func createDiffKoefsWithNumber\(deg)() {\n"
        ss += "    let s = PathAlg.s\n"
        ss += "    let m = \(m)\n"
        ss += "    makeZeroMatrix(\(diff.width / s)*s, h: \(diff.height / s)*s)\n\n"
        for j in 0 ..< diff.width {
            guard j % s == 0 else { continue }
            ss += "    for j in \(colForJ(j)) ..< \(colForJ(j+s)) {\n"
            for i in 0 ..< diff.height {
                let c = diff.rows[i][j]
                guard !c.isZero else { continue }
                ss += "        addTenToPos(\(rowRowJ(j, i)), j, 0, 0, 0, 0, \(Int(c.content[0].koef)))\n"
            }
            ss += "    }\n"
        }
        ss += "}</pre>\n"
        OutputFile.writeLog(.simple, ss)
    }

    private static func colForJ(_ j: Int) -> String {
        let s = PathAlg.s
        if j == 0 { return "0" }
        if j == s { return "s" }
        if j % s == 0 { return "\(j/s)*s" }
        return "\(j / s)*s+\(j%s)"
    }

    private static func rowRowJ(_ j: Int, _ i: Int) -> String {
        let s = PathAlg.s
        if i == j { return "j" }
        if i == 0 { return "j%s" }
        if i == 1 { return "(j+1)%s" }
        if i % s == 1 {
            let m = (i - 1) / s
            return (m == 1 ? "s" : "\(m)*s") + "+(j+1)%s"
        }
        let m = (i - j) / s
        let ss = m == 1 ? "j+s" : (m == -1 ? "j-s" : (m < 0 ? "j\(m)*s" : "j+\(m)*s"))
        if i % s == 0 { return ss }
        return ""
    }

    private static func koefStr(_ v: Vertex, _ j: Int, jStr: String) -> String {
        let n = PathAlg.n
        let dd = myMod(v.number - n * j, mod: n * PathAlg.s)
        let m1 = dd / n
        let m2 = m1 == PathAlg.s - 1 ? -1 : m1
        let ss = m1 == 0 ? (jStr == "j" ? "\(n)*\(jStr)" : "\(n)*(\(jStr))") : "\(n)*(" + jStr + (m2 < 0 ? "" : "+") + "\(m2))"
        return dd == n * m1 ? ss : "\(ss)+\(dd - n * m1)"
    }
}

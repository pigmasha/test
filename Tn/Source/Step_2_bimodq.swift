//
//  Created by M on 25.02.2023.
//

import Foundation

struct Step_2_bimodq {
    private static let checkPBimod = false

    static func runCase() -> Bool {
        if checkPBimod {
            for i in 1 ... PathAlg.n + 1 {
                if processS(i) { return true }
            }
        } else {
            for d in 0 ... PathAlg.alg.someNumber {
                if !checkBimod(d) { return true }
                OutputFile.writeLog(.normal, "\(d): BimodQ checked :)")
            }
        }
        return false
    }

    private static func checkBimod(_ deg: Int) -> Bool {
        let b = BimodQ(deg: deg)
        if !b.pij.isEmpty {
            var lastI = b.pij[0].1
            for p in b.pij {
                if p.1 < 1 || p.1 > PathAlg.n + 1 {
                    OutputFile.writeLog(.error, "checkBimod: deg=\(deg) unknown second values (not in 1 ... n + 1) \(p)")
                    return false
                }
                if p.1 == lastI { continue }
                if p.1 != lastI + 1 {
                    OutputFile.writeLog(.error, "checkBimod: deg=\(deg) pair \(p) not prev pair + 1")
                    return false
                }
                lastI = p.1
            }
            if b.pij.count != BimodQ.size(deg: deg) {
                OutputFile.writeLog(.error, "Bad size \(BimodQ.size(deg: deg)) (should be \(b.pij.count))")
                return false
            }
        }
        for i in 1 ... PathAlg.n + 1 {
            let b2 = PBimodQ(deg: deg, i: i)
            if b.pij.isEmpty {
                OutputFile.writeLog(.normal, "i=\(i): \(b2.p)")
            }
            let f = b.pij.filter({ $0.1 == i })
            if f.count != b2.p.count {
                OutputFile.writeLog(.normal, "checkBimod: deg=\(deg), i=\(i), bad count \(f.count), should be \(b2.p.count) (array \(b2.p))")
                return false
            }
            for (j, p) in f.enumerated() {
                if p.0 != b2.p[j] {
                    OutputFile.writeLog(.normal, "checkBimod: deg=\(deg), i=\(i), bad \(j)-th element, array \(b2.p)")
                    return false
                }
            }
        }
        return true
    }

    private static func processS(_ i: Int) -> Bool {
        OutputFile.writeLog(.bold, "S" + Utils.subStr(i))
        for d in 0 ... PathAlg.alg.someNumber {
            let diff = PDiff(deg: d, i: i)
            let hh = homoFromPDiff(diff)
            if !checkP(hh, i) { return true }
            OutputFile.writeLog(.normal, "\(d): PBimod checked :)")
        }
        return false
    }

    private static func checkP(_ homo: PHomo, _ i: Int) -> Bool {
        let b = PBimodQ(deg: homo.deg, i: i)
        if b.p.isEmpty {
            OutputFile.writeLog(.normal, "\(homo.deg): \(homo.to), count=\(homo.to.count)")
            return true
        }
        if b.p.count != homo.to.count {
            OutputFile.writeLog(.error, "checkP: bad bimod size \(b.p.count), should be \(homo.to.count) (\(homo.to))")
            return false
        }
        for (i, p) in b.p.enumerated() {
            if p != homo.to[i] {
                OutputFile.writeLog(.error, "checkP: bad \(i)-th element, array should be \(homo.to)")
                return false
            }
        }
        return true
    }

    private static func homoFromPDiff(_ diff: PDiff) -> PHomo {
        var to: [Int] = []
        for row in diff.rows {
            let startVertex = row.first(where: { !$0.isZero })!.contents[0].1.startVertex
            to.append(startVertex)
        }
        var from: [Int] = []
        for j in 0 ..< diff.rows[0].count {
            let endVertex = diff.rows.first(where: { !$0[j].isZero })![j].contents[0].1.endVertex
            from.append(endVertex)
        }
        return PHomo(deg: diff.deg, from: from, to: to, matrix: diff)
    }
}

//
//  CreateDiff.swift
//  Created by M on 20.10.2021.
//

import Foundation

/*struct CreateDiff {
    static func check(diff: Diff, deg: Int, prevDiff: Diff) -> String? {
        let pDiff = PDiff(deg: deg)
        if pDiff.width != diff.width || pDiff.height != diff.height { return "Bad matrix size" }
        for i in 0 ..< diff.height {
            for j in 0 ..< diff.width {
                let p = pDiff.rows[i][j]
                if p.isZero {
                    for (_, t) in diff.rows[i][j].contents {
                        guard t.rightComponent.len == 0 else { continue }
                        return "[\(i)][\(j)]: zero at pDiff, but comb is " + diff.rows[i][j].str
                    }
                } else {
                    var count = 0
                    for (k, t) in diff.rows[i][j].contents {
                        guard t.rightComponent.len == 0 else { continue }
                        count += 1
                        guard let ii = p.contents.firstIndex(where: { $0.1.isEq(t.leftComponent) }) else {
                            return "[\(i)][\(j)]: no \(t.leftComponent.str) in " + p.str
                        }
                        if p.contents[ii].0.n != k.n {
                            return "[\(i)][\(j)]: bad koef at \(t.leftComponent.str) in " + p.str
                        }
                    }
                    if count != p.contents.count {
                        return "[\(i)][\(j)]: Not all from " + p.str
                    }
                }
            }
        }
        if deg > 0 {
            let mult = Matrix(mult: prevDiff, and: diff)

            if !mult.isZero {
                PrintUtils.printMatrix("Prev Diff \(deg - 1)", prevDiff)
                PrintUtils.printMatrix("Diff \(deg)", diff)
                PrintUtils.printMatrix("Mult", mult)
                return "Mult not zero!"
            }
        }
        return nil
    }

    static func create(diff: Diff, deg: Int, prevDiff: Diff) -> String? {
        guard deg > 0 else { return "Deg 0" }
        let pDiff = PDiff(deg: deg)
        if pDiff.width != diff.width || pDiff.height != diff.height { return "Bad matrix size" }
        if !diff.isZero { return "Diff not zero" }
        for i in 0 ..< diff.height {
            for j in 0 ..< diff.width {
                let p = pDiff.rows[i][j]
                guard !p.isZero else { continue }
                for (k, w) in p.contents {
                    diff.rows[i][j].add(left: w, right: Way.e, koef: k.n)
                }
            }
        }
        let ch2Diff = Diff(emptyForDeg: deg)
        ch2Diff.fillDiff2Char()
        var nVariants = 1
        for i in 0 ..< diff.height {
            for j in 0 ..< diff.width {
                let p = ch2Diff.rows[i][j]
                var c = 1
                for (_, t) in p.contents {
                    guard t.rightComponent.len > 0 else { continue }
                    c *= 2
                }
                nVariants *= c
            }
        }
        for v in 0 ..< nVariants {
            var k = v
            var poses: [(Int, Int, Tenzor, Int)] = []
            for i in 0 ..< diff.height {
                for j in 0 ..< diff.width {
                    let p = ch2Diff.rows[i][j]
                    for (_, t) in p.contents {
                        guard t.rightComponent.len > 0 else { continue }
                        let kk = k % 2 == 0 ? 1 : -1
                        diff.rows[i][j].add(tenzor: t, koef: kk)
                        poses.append((i, j, t, kk))
                        k /= 2
                    }
                }
            }
            let mult = Matrix(mult: prevDiff, and: diff)
            if mult.isZero { return nil }
            for p in poses {
                diff.rows[p.0][p.1].add(tenzor: p.2, koef: -p.3)
            }
        }
        return nil
    }
}
*/

//
//  CreateDiff.swift
//  Created by M on 20.10.2021.
//

import Foundation

struct CreateDiff {
    static func check(diff: Diff, deg: Int, prevDiff: Diff) -> String? {
        let pDiff = PDiff(deg: deg)
        if pDiff.width != diff.width || pDiff.height != diff.height {
            return "Bad matrix size"
        }
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
                PrintUtils.printMatrix("Diff \(deg - 1)", prevDiff)
                PrintUtils.printMatrix("Mult", mult)
                return "Mult not zero!"
            }
        }
        return nil
    }
}

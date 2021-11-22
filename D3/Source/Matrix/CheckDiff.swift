//
//  CheckDiff.swift
//  Created by M on 20.10.2021.
//

import Foundation

struct CheckDiff {
    static func check(diff: Diff, deg: Int, prevDiff: Diff) -> String? {
        if let err = checkDeg(matrix: diff, degFrom: deg + 1, degTo: deg) { return err }
        for i in 0 ..< diff.height {
            var zeroLine = true
            for j in 0 ..< diff.width {
                if !diff.rows[i][j].isZero { zeroLine = false; break }
            }
            if zeroLine { return "Line \(i): zero!" }
        }
        for j in 0 ..< diff.width {
            var zeroColumn = true
            for i in 0 ..< diff.height {
                if !diff.rows[i][j].isZero { zeroColumn = false; break }
            }
            if zeroColumn { return "Column \(j): zero!" }
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

    static func checkDeg(matrix: Matrix, degFrom: Int, degTo: Int) -> String? {
        let qFrom = BimodQ(deg: degFrom)
        let qTo = BimodQ(deg: degTo)
        if matrix.width != qFrom.pij.count || matrix.height != qTo.pij.count { return "Bad matrix size" }
        for i in 0 ..< matrix.height {
            for j in 0 ..< matrix.width {
                let p = matrix.rows[i][j]
                if p.isZero { continue }
                var errors: [String] = []
                for (_, t) in p.contents {
                    if t.leftComponent.startVertex != qTo.pij[i].0 {
                        errors.append("[\(i)][\(j)]: startVertex for left \(t.leftComponent.str) not " + qTo.pij[i].0.str)
                    }
                    if t.leftComponent.endVertex != qFrom.pij[j].0 {
                        errors.append("[\(i)][\(j)]: endVertex for left \(t.leftComponent.str) not " + qFrom.pij[j].0.str)
                    }
                    if t.rightComponent.startVertex != qFrom.pij[j].1 {
                        errors.append("[\(i)][\(j)]: startVertex for right \(t.rightComponent.str) not " + qFrom.pij[j].1.str)
                    }
                    if t.rightComponent.endVertex != qTo.pij[i].1 {
                        errors.append("[\(i)][\(j)]: endVertex for right \(t.rightComponent.str) not " + qTo.pij[i].1.str)
                    }
                    if errors.count > 0 {
                        return errors.joined(separator: "; ")
                    }
                }
            }
        }
        return nil
    }
}

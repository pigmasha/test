//
//  CreateDiff.swift
//  Created by M on 16.05.2022.
//

import Foundation

struct CreateDiff {
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

    static func create(diff: Diff, deg: Int, prevDiff: Diff) -> String? {
        guard deg > 0 else { return "Deg 0" }
        let pDiff = PDiff(deg: deg)
        if pDiff.width != diff.width || pDiff.height != diff.height { return "Bad matrix size" }
        if !diff.isZero { return "Diff not zero" }
        for i in 0 ..< diff.height {
            for j in 0 ..< diff.width {
                let p = pDiff.rows[i][j]
                guard !p.isZero else { continue }
                for (_, w) in p.contents {
                    diff.rows[i][j].add(comb: Comb(left: w, right: Way.e, label: ""))
                }
            }
        }
        return SearchForMult.search(for: diff, multWith: prevDiff, mult: nil, mode: .diff)
    }

    static func checkDeg(matrix: Matrix, degFrom: Int, degTo: Int) -> String? {
        if matrix.width != Utils.qSize(degFrom) || matrix.height != Utils.qSize(degTo) { return "Bad matrix size" }
        return nil
    }

    /*static func tryFix(diff: Diff, deg: Int, prevDiff: Diff, column: Int, rows: (Int, Int), searchAll: Bool) -> String? {
        for i in rows.0 ... rows.1 {
            diff.rows[i][column].clear()
        }
        let pDiff = PDiff(deg: deg)
        let allCombs = alllCombs
        var columns: [Matrix] = []
        let columnCheck: (Int) -> Bool = { column in
            for i in 0 ..< pDiff.height {
                let c = diff.rows[i][column]
                let p = pDiff.rows[i][column]
                let e = Element()
                for (_, t) in c.contents {
                    if t.rightComponent.len == 0 {
                        e.add(way: t.leftComponent, koef: 1)
                    }
                }
                if p.isZero && e.isZero { continue }
                if p.isZero && !e.isZero { return false }
                if p.eqKoef(e) == 0 { return false }
            }
            if Matrix(mult: prevDiff, and: diff, column: column).isZero {
                if searchAll {
                    let m = Matrix(m: diff, column: column)
                    if !columns.contains(where: { $0.numberOfDifferents(with: m) == 0 }) {
                        PrintUtils.printMatrixColumn("Col \(column)", diff, column)
                        columns.append(m)
                    }
                    return false
                } else {
                    return true
                }
            }
            return false
        }
        if fill1(diff: diff, column: column, rows: rows, allCombs: allCombs, columnCheck: columnCheck) { return nil }
        return "Fix failed"
    }*/
}

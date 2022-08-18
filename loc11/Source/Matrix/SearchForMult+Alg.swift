//
//  SearchForMult+Alg.swift
//  Created by M on 05.06.2022.
//

import Foundation

extension SearchForMult {
    static func fill(for matrix: Matrix, column: Int, multWith: Matrix, mult: Matrix) {
        let multC = Matrix(zeroMatrix: 1, h: mult.height)
        for i in 0 ..< mult.height {
            multC.rows[i][0].add(comb: mult.rows[i][column])
        }
        let m1 = Matrix(mult: multWith, and: matrix, column: column)
        for i in 0 ..< multC.height {
            multC.rows[i][0].add(comb: m1.rows[i][0], koef: -1)
        }
        //PrintUtils.printMatrix("Column \(column)", multC)

        let printSearch = PathAlg.kk == 0
        if printSearch { OutputFile.writeLog(.simple, "<table><tr>\n") }
        while true {
            guard let i0 = multC.rows.firstIndex(where: { !$0[0].isZero }) else {
                if printSearch { OutputFile.writeLog(.simple, "</tr></table>\n") }
                return
            }
            if searchOneStepResult(for: matrix, column: column, multWith: multWith, mult: multC, print: printSearch) {
                if printSearch { OutputFile.writeLog(.simple, "</tr></table>\n") }
                return
            }
            let c = multC.rows[i0][0]
            var j0 = -1
            for j1 in 0 ..< multWith.width {
                let j = multWith.width - 1 - j1
                if matrix.rows[j][column].isZero && canDivide(comb: c, by: multWith.rows[i0][j]) {
                    j0 = j
                    break
                }
            }
            if j0 == -1 { break }
            matrix.rows[j0][column].add(comb: divide(comb: c,  by: multWith.rows[i0][j0], partial: true))
            let m1 = Matrix(mult: multWith, and: matrix, column: column)
            for i in 0 ..< multC.height {
                multC.rows[i][0].clear()
                multC.rows[i][0].add(comb: mult.rows[i][column])
                multC.rows[i][0].add(comb: m1.rows[i][0], koef: -1)
            }
        }
    }

    private static func searchOneStepResult(for matrix: Matrix, column: Int, multWith: Matrix, mult: Matrix, print: Bool) -> Bool {
        for i in 0 ..< mult.height {
            if mult.rows[i][0].isZero { continue }
            let c = mult.rows[i][0]
            for m in 1 ... 2 {
                for j in 0 ..< multWith.rows[i].count {
                    //let j = multWith.rows[i].count - 1 - j0
                    if m == 1 && j != column { continue }
                    guard matrix.rows[j][column].isZero && canDivide(comb: c, by: multWith.rows[i][j]) else { continue }
                    matrix.rows[j][column].add(comb: divide(comb: c,  by: multWith.rows[i][j], partial: false))
                    let m1 = Matrix(mult: multWith, and: matrix, column: column)
                    if m1.numberOfDifferents(with: mult) == 0 {
                        if print {
                            PrintUtils.printMatrixColumn("<td>Column \(column)", matrix, column)
                            OutputFile.writeLog(.simple, "</td>\n")
                        } else {
                            return true
                        }
                    }
                    matrix.rows[j][column].clear()
                }
            }
        }
        return print ? searchOneStepResult(for: matrix, column: column, multWith: multWith, mult: mult, print: false) : false
    }

    private static func fillDiag(for matrix: Matrix, column: Int, multWith: Matrix, mult: Matrix) {
        if !matrix.rows[column][column].isZero { return }
        guard let i0 = mult.rows.firstIndex(where: { !$0[column].isZero }) else { return }
        matrix.rows[column][column].add(comb: divide(comb: mult.rows[i0][column],  by: multWith.rows[i0][column], partial: false))
    }

    private static func canDivide(comb c: Comb, by d: Comb) -> Bool {
        if d.isZero { return false }
        return d.contents.contains(where: { c.contents[0].1.hasPrefix($0.1) })
    }

    private static func minPos(c: Comb, isRight: Bool, divideBy: Tenzor?) -> Int {
        var pos = 0
        var len = -1
        for i in 0 ..< c.contents.count {
            if let divideBy = divideBy, !divideBy.hasPrefix(c.contents[i].1) { continue }
            let w = isRight ? c.contents[i].1.rightComponent : c.contents[i].1.leftComponent
            if len < 0 || w.len < len {
                len = w.len
                pos = i
            }
        }
        return pos
    }

    private static func divide(comb c: Comb, by d: Comb, partial: Bool) -> Comb {
        if d.isZero { onError("Can't divide " + c.str + " by " + d.str + ": zero comb") }
        let onError: (String) -> Void = { s in
            OutputFile.writeLog(.normal, "Divide err " + c.str + " by " + d.str + ": bad result " + s)
        }
        let cc = Comb(comb: c)
        let res = Comb()
        var step = 0
        while true {
            var hasC = false
            for i in 0 ... 1 {
                let cPos = minPos(c: cc, isRight: i == 1, divideBy: nil)
                let dPos = minPos(c: d, isRight: i == 1, divideBy: cc.contents[cPos].1)
                if let res1 = divide(comb: cc, cPos: cPos, by: d, dPos: dPos) {
                    res.add(comb: res1)
                    cc.add(comb: Comb(comb: d, compRight: res1))
                    if cc.isZero { return res }
                    hasC = true
                    if partial { return res }
                }
            }
            if cc.isZero || step > 10 || !hasC { break }
            step += 1
        }
        if !cc.isZero { onError(res.str)  }
        return res
    }

    private static func divide(comb c: Comb, cPos: Int, by d: Comb, dPos: Int) -> Comb? {
        if !c.contents[cPos].1.hasPrefix(d.contents[dPos].1) { return nil }
        return divide(pair: c.contents[cPos], by: d.contents[dPos])
    }

    private static func divide(pair c: (NumInt, Tenzor), by d: (NumInt, Tenzor)) -> Comb {
        let cT = c.1
        let dT = d.1
        let wL = divide(way: cT.leftComponent, by: dT.leftComponent, fromLeft: true)
        let wR = divide(way: cT.rightComponent, by: dT.rightComponent, fromLeft: false)
        if c.0.n % d.0.n != 0 {
            onError("Can't divide " + c.1.str + " by " + d.1.str + ": bad koefs \(c.0.n) and \(d.0.n)")
        }
        return Comb(left: wL, right: wR, koef: c.0.n / d.0.n)
    }

    private static func divide(way: Way, by other: Way, fromLeft: Bool) -> Way {
        if way.isEq(other) {
            return Way.e
        }
        if other.len == 0 {
            return Way(way: way)
        }
        let c: Way
        if let t = way.twin, t.endArr == other.endArr || t.endArr == Way.nextArray(after: other.endArr) {
            c = t
        } else {
            c = way
        }
        return Way(type: fromLeft || other.len % 2 == 0 ? c.endArr : Way.nextArray(after: c.endArr), len: c.len - other.len)
    }

    private static func onError(_ message: String) -> Never {
        OutputFile.writeLog(.error, message)
        fatalError(message)
    }
}

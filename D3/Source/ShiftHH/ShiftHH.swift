//
//  ShiftHH.swift
//
//  Created by M on 16.11.2021.
//

import Foundation

final class ShiftHH {
    let hhDeg: Int
    let shiftDeg: Int
    let matrix: Matrix
    let hhLabel: String
    private var multErr = false

    init(gen: Gen) {
        hhDeg = gen.deg
        shiftDeg = 0
        hhLabel = gen.label
        let qTo = BimodQ(deg: 0)
        let qFrom = BimodQ(deg: hhDeg)
        matrix = Matrix(zeroMatrix: qFrom.pij.count, h: qTo.pij.count)
        for j in 0 ..< gen.elem.count {
            let i = (hhLabel == "u1" || hhLabel == "u1_h" ? j + 1 : j) % qTo.pij.count
            if qFrom.pij[j].1 == qTo.pij[i].1 {
                matrix.rows[i][j].add(left: gen.elem[j].1, right: Way(vertexType: qFrom.pij[j].1), koef: gen.elem[j].0)
            } else {
                let wL = gen.elem[j].1
                let w = wL.len == 1 ? Way(vertexType: wL.endVertex) : Way(type: wL.endArr, len: wL.len - 1)
                matrix.rows[i][j].add(left: w, right: Way(from: qFrom.pij[j].1, to: qTo.pij[i].1), koef: gen.elem[j].0)
            }
        }
    }

    init(nextAfter shift: ShiftHH) {
        hhDeg = shift.hhDeg
        shiftDeg = shift.shiftDeg + 1
        hhLabel = shift.hhLabel
        matrix = Matrix(zeroMatrix: BimodQ(deg: hhDeg + shiftDeg).pij.count, h: BimodQ(deg: shiftDeg).pij.count)

        let mult = Matrix(mult: shift.matrix, and: Diff(deg: shift.hhDeg + shift.shiftDeg))
        let diff = Diff(deg: shift.shiftDeg)
        if mult.width != matrix.width { fatalError() }
        //PrintUtils.printMatrix("Diff", diff)
        //PrintUtils.printMatrix("Mult", mult)
        shiftZ1()
        for j in 0 ..< mult.width {
            if hhDeg == 0 {
                fillDiag(column: j, diff: diff, mult: mult)
            } else {
                fill(column: j, diff: diff, mult: mult)
            }
        }
        let m2 = Matrix(mult: diff, and: matrix)
        let n = m2.numberOfDifferents(with: mult)
        if n != 0 {
            PrintUtils.printMatrix("Diff", diff)
            PrintUtils.printMatrix("Mult", mult)
            PrintUtils.printMatrix("Mult2", m2)
            OutputFile.writeLog(.error, "Number of differents: \(n)")
            multErr = true
        }
    }

    init(gen: Gen, shiftDeg: Int) {
        hhDeg = gen.deg
        self.shiftDeg = shiftDeg
        self.hhLabel = gen.label
        matrix = Matrix(zeroMatrix: 3 * (hhDeg + shiftDeg + 1), h: 3 * (shiftDeg + 1))
        if shiftC00(gen.label) { return }
        if shiftX00(gen.label) { return }
        if shiftU0(gen.label) { return }
        if shiftE0(gen.label) { return }
        if shiftX0(gen.label) { return }
        if shiftW00(gen.label) { return }
        switch gen.label {
        case "q": shiftQ()
        case "z1": shiftZ1()
        default: break
        }
    }

    func print() {
        PrintUtils.printMatrix("Shift \(shiftDeg)", matrix)
    }

    func printProgram(diffWith m: Matrix? = nil) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let capLabel = hhLabel.prefix(1).uppercased() + hhLabel.dropFirst()
        OutputFile.writeLog(.simple, "<pre>private func shift\(capLabel.replacingOccurrences(of: "_", with: ""))\(shiftDeg)() {\n")
        OutputFile.writeLog(.simple, "    let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)\n")
        let strForWay: (Way) -> String = { w in
            if w.len == 0 { return "Way.e" + w.startVertex.str }
            if w.len % 2 == 0 {
                let len = w.len / 2
                let s: String
                let lenStr: String
                switch w.endArr {
                case .a12: s = "alpha1"; lenStr = n3 > 1 && len == n3 - 1 ? "n3 - 1" : "\(len)"
                case .a21: s = "beta2"; lenStr = n3 > 1 && len == n3 - 1 ? "n3 - 1" : "\(len)"
                case .a32: s = "beta3"; lenStr = n1 > 1 && len == n1 - 1 ? "n1 - 1" : "\(len)"
                case .a23: s = "alpha2"; lenStr = n1 > 1 && len == n1 - 1 ? "n1 - 1" : "\(len)"
                case .a31: s = "alpha3"; lenStr = n2 > 1 && len == n2 - 1 ? "n2 - 1" : "\(len)"
                case .a13: s = "beta1"; lenStr = n2 > 1 && len == n2 - 1 ? "n2 - 1" : "\(len)"
                }
                return w.len == 2 ? "Way." + s : "Way." + s + "(deg: \(lenStr))"
            }
            let lenStr = n1 > 1 && w.len == 2 * n1 - 1 ? "2 * n1 - 1" : (n2 > 1 && w.len == 2 * n2 - 1 ? "2 * n2 - 1" : (n3 > 1 && w.len == 2 * n3 - 1 ? "2 * n3 - 1" : "\(w.len)"))
            return "Way(type: .a\(w.endArr.str), len: \(lenStr))"
        }
        for j in 0 ..< matrix.width {
            for i in 0 ..< matrix.height {
                let c = matrix.rows[i][j]
                if let m = m, m.rows[i][j].isEq(c) { continue }
                for (k, t) in c.contents {
                    OutputFile.writeLog(.simple, "    matrix.rows[\(i)][\(j)].add(left: \(strForWay(t.leftComponent)), right: \(strForWay(t.rightComponent)), koef: \(k.n))\n")
                }
            }
        }
        OutputFile.writeLog(.normal, "}</pre>")
    }

    func check() -> String? {
        if let err = CheckDiff.checkDeg(matrix: matrix, degFrom: hhDeg + shiftDeg, degTo: shiftDeg) {
            return err
        }
        return multErr ? "Mult error" : nil
    }

    func put(items: [(sh: Int, x: Int, y: Int, k: Int, f: ((Int, Int), Int) -> Void, fi: Bool)], kFlag: Bool = false) {
        for item in items {
            guard shiftDeg >= item.sh else { continue }
            let j1 = (shiftDeg - item.sh) / 6
            for j in 0 ... j1 {
                let pos = (3 * (6 * j + item.x), 3 * (6 * j + item.y))
                item.f(pos, kFlag ? Utils.minusDeg(j) * item.k : item.k)
                if item.fi { matrix.putFi(at: pos) }
            }
        }
    }

    private func fillAll(column: Int, diff: Matrix, mult: Matrix) {
        let qFrom = BimodQ(deg: hhDeg + shiftDeg)
        let qTo = BimodQ(deg: shiftDeg)

        let multC = Matrix(zeroMatrix: 1, h: mult.height)
        for i in 0 ..< mult.height {
            multC.rows[i][0].add(comb: mult.rows[i][column])
        }
        if multC.isZero { return }
        var cc = 1
        for _ in 1 ... matrix.height { cc *= 3 }
        for c in 1 ..< cc {
            var kk = c
            for j in 0 ..< matrix.height {
                matrix.rows[j][column].clear()
                let k = kk % 3
                kk /= 3
                if k == 0 { continue }
                matrix.rows[j][column].add(left: Way(from: qTo.pij[j].0, to: qFrom.pij[column].0),
                                           right: Way(from: qFrom.pij[column].1, to: qTo.pij[j].1), koef: k == 2 ? -1 : k)
            }
            if column < 3 && !matrix.rows[column][column].isZero { continue }
            let m1 = Matrix(mult: diff, and: matrix, column: column)
            if m1.numberOfDifferents(with: multC) == 0 { break }
        }
    }

    private func fill(column: Int, diff: Matrix, mult: Matrix) {
        //fillAll(column: column, diff: diff, mult: mult)
        //return
        let multC = Matrix(zeroMatrix: 1, h: mult.height)
        for i in 0 ..< mult.height {
            multC.rows[i][0].add(comb: mult.rows[i][column])
        }
        let m1 = Matrix(mult: diff, and: matrix, column: column)
        for i in 0 ..< multC.height {
            multC.rows[i][0].add(comb: m1.rows[i][0], koef: -1)
        }
        //PrintUtils.printMatrix("Column \(column)", multC)

        let printSearch = PathAlg.n1 == 0
        if printSearch { OutputFile.writeLog(.simple, "<table><tr>\n") }
        while true {
            guard let i0 = multC.rows.firstIndex(where: { !$0[0].isZero }) else {
                if printSearch { OutputFile.writeLog(.simple, "</tr></table>\n") }
                return
            }
            if searchOneStepResult(column: column, diff: diff, mult: multC, print: printSearch) {
                if printSearch { OutputFile.writeLog(.simple, "</tr></table>\n") }
                return
            }
            let c = multC.rows[i0][0]
            var j0 = -1
            for j1 in 0 ..< diff.width {
                let j = diff.width - 1 - j1
                if matrix.rows[j][column].isZero && canDivide(comb: c, by: diff.rows[i0][j]) {
                    j0 = j
                    break
                }
            }
            if j0 == -1 { break }
            matrix.rows[j0][column].add(comb: divide(comb: c,  by: diff.rows[i0][j0]))
            let m1 = Matrix(mult: diff, and: matrix, column: column)
            for i in 0 ..< multC.height {
                multC.rows[i][0].clear()
                multC.rows[i][0].add(comb: mult.rows[i][column])
                multC.rows[i][0].add(comb: m1.rows[i][0], koef: -1)
            }
        }
    }

    private func searchOneStepResult(column: Int, diff: Matrix, mult: Matrix, print: Bool) -> Bool {
        for i in 0 ..< mult.height {
            if mult.rows[i][0].isZero { continue }
            let c = mult.rows[i][0]
            for m in 1 ... 4 {
                for j in 0 ..< diff.rows[i].count {
                    //let j = diff.rows[i].count - 1 - j0
                    if m == 1 && j != column { continue }
                    var c0 = (column - j) % 3
                    if c0 < 0 { c0 += 3 }
                    if m == 2 && c0 != 0 { continue }
                    if m == 3 && c0 != 1 { continue }
                    if m == 4 && c0 != 2 { continue }
                    guard matrix.rows[j][column].isZero && canDivide(comb: c, by: diff.rows[i][j]) else { continue }
                    matrix.rows[j][column].add(comb: divide(comb: c,  by: diff.rows[i][j]))
                    let m1 = Matrix(mult: diff, and: matrix, column: column)
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
        return print ? searchOneStepResult(column: column, diff: diff, mult: mult, print: false) : false
    }

    private func fillDiag(column: Int, diff: Matrix, mult: Matrix) {
        guard let i0 = mult.rows.firstIndex(where: { !$0[column].isZero }) else { return }
        matrix.rows[column][column].add(comb: divide(comb: mult.rows[i0][column],  by: diff.rows[i0][column]))
    }

    private func canDivide(comb c: Comb, by d: Comb) -> Bool {
        if d.isZero { return false }
        return d.contents.contains(where: { c.contents[0].1.hasPrefix($0.1) })
    }

    private func divide(comb c: Comb, by d: Comb) -> Comb {
        if d.isZero { onError("Can't divide " + c.str + " by " + d.str + ": zero comb") }
        let checkRes: (Comb) -> String? = { r in
            let r0 = Comb(comb: d)
            r0.compRight(comb: r)
            return r0.isEq(c) ? nil : "Can't divide " + c.str + " by " + d.str + ": bad result " + r.str
        }
        let res1 = divide(comb: c, cPos: 0, by: d, dFirst: true)!
        if checkRes(res1) == nil { return res1 }
        let res2 = divide(comb: c, cPos: 0, by: d, dFirst: false)!
        if checkRes(res2) == nil { return res2 }
        if c.contents.count == 1 { return res1 }

        let rr = Comb(comb: res1)
        for pos in 1 ..< c.contents.count {
            guard let res3 = divide(comb: c, cPos: pos, by: d, dFirst: true) else { break }
            rr.add(comb: res3)
            if checkRes(rr) == nil { return rr }
        }
        OutputFile.writeLog(.normal, "Divide err " + c.str + " by " + d.str + " = " + res1.str)
        return res1
    }

    private func divide(comb c: Comb, cPos: Int, by d: Comb, dFirst: Bool) -> Comb? {
        let cT = c.contents[cPos].1
        guard let i0 = dFirst ? d.contents.firstIndex(where: { cT.hasPrefix($0.1) }) :
                d.contents.lastIndex(where: { cT.hasPrefix($0.1) }) else {
                    return nil
        }
        return divide(pair: c.contents[cPos], by: d.contents[i0])
    }

    private func divide(pair c: (NumInt, Tenzor), by d: (NumInt, Tenzor)) -> Comb {
        let cT = c.1
        let dT = d.1
        let wL = divide(way: cT.leftComponent, by: dT.leftComponent, fromLeft: true)
        let wR = divide(way: cT.rightComponent, by: dT.rightComponent, fromLeft: false)
        if c.0.n % d.0.n != 0 {
            onError("Can't divide " + c.1.str + " by " + d.1.str + ": bad koefs \(c.0.n) and \(d.0.n)")
        }
        return Comb(left: wL, right: wR, koef: c.0.n / d.0.n)
    }

    private func divide(way: Way, by other: Way, fromLeft: Bool) -> Way {
        if way.isEq(other) {
            return Way(vertexType: fromLeft ? way.endVertex : way.startVertex)
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

    private func onError(_ message: String) -> Never {
        OutputFile.writeLog(.error, message)
        fatalError(message)
    }
}

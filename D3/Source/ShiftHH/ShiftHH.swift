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
    private var multErr = false

    init(gen: Gen) {
        hhDeg = gen.deg
        shiftDeg = 0
        let qTo = BimodQ(deg: 0)
        let qFrom = BimodQ(deg: hhDeg)
        matrix = Matrix(zeroMatrix: qFrom.pij.count, h: qTo.pij.count)
        for j in 0 ..< gen.elem.count {
            let i = j % qTo.pij.count
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
        matrix = Matrix(zeroMatrix: BimodQ(deg: hhDeg + shiftDeg).pij.count, h: BimodQ(deg: shiftDeg).pij.count)

        let mult = Matrix(mult: shift.matrix, and: Diff(deg: shift.hhDeg + shift.shiftDeg))
        let diff = Diff(deg: shift.shiftDeg)
        if mult.width != matrix.width { fatalError() }
        //PrintUtils.printMatrix("Diff", diff)
        //PrintUtils.printMatrix("Mult", mult)
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
        matrix = Matrix(zeroMatrix: 3 * (hhDeg + shiftDeg + 1), h: 3 * (shiftDeg + 1))
        switch gen.label {
        case "c12": shiftC12()
        case "c23": shiftC23()
        case "c31": shiftC31()
        default: break
        }
    }

    func print() {
        PrintUtils.printMatrix("Shift \(shiftDeg)", matrix)
    }

    func check() -> String? {
        if let err = CheckDiff.checkDeg(matrix: matrix, degFrom: hhDeg + shiftDeg, degTo: shiftDeg) {
            return err
        }
        return multErr ? "Mult error" : nil
    }

    private func fill(column: Int, diff: Matrix, mult: Matrix) {
        guard let i0 = mult.rows.firstIndex(where: { !$0[column].isZero }) else { return }
        let c = mult.rows[i0][column]
        guard let j0 = diff.rows[i0].firstIndex(where: { canDivide(comb: c, by: $0) }) else {
            onError("Can't divide \(column)-th col elem " + c.str + " by diff")
        }
        matrix.rows[j0][column].add(comb: divide(comb: c,  by: diff.rows[i0][j0]))
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
        let res1 = divide(comb: c, cPos: 0, by: d, dFirst: true)
        if checkRes(res1) == nil { return res1 }
        let res2 = divide(comb: c, cPos: 0, by: d, dFirst: false)
        if checkRes(res2) == nil { return res2 }
        if c.contents.count > 1 {
            let res3 = divide(comb: c, cPos: 1, by: d, dFirst: true)
            res3.add(comb: res1)
            return res3
        }
        return res1
    }

    private func divide(comb c: Comb, cPos: Int, by d: Comb, dFirst: Bool) -> Comb {
        let cT = c.contents[cPos].1
        guard let i0 = dFirst ? d.contents.firstIndex(where: { cT.hasPrefix($0.1) }) :
                d.contents.lastIndex(where: { cT.hasPrefix($0.1) }) else {
            onError("Can't divide " + c.str + " by " + d.str + ": not in prefix")
        }
        return divide(pair: c.contents[cPos], by: d.contents[i0])
    }

    private func divide(pair c: (NumInt, Tenzor), by d: (NumInt, Tenzor)) -> Comb {
        let cT = c.1
        let dT = d.1
        let wL: Way
        if cT.leftComponent.isEq(dT.leftComponent) {
            wL = Way(vertexType: cT.leftComponent.endVertex)
        } else {
            wL = Way(type: cT.leftComponent.endArr, len: cT.leftComponent.len - dT.leftComponent.len)
        }
        let wR: Way
        if cT.rightComponent.isEq(dT.rightComponent) {
            wR = Way(vertexType: cT.rightComponent.startVertex)
        } else {
            wR = Way(type: dT.rightComponent.len % 2 == 0 ? cT.rightComponent.endArr : Way.nextArray(after: cT.rightComponent.endArr),
                     len: cT.rightComponent.len - dT.rightComponent.len)
        }
        if c.0.n % d.0.n != 0 {
            onError("Can't divide " + c.1.str + " by " + d.1.str + ": bad koefs \(c.0.n) and \(d.0.n)")
        }
        return Comb(left: wL, right: wR, koef: c.0.n / d.0.n)
    }

    private func onError(_ message: String) -> Never {
        OutputFile.writeLog(.error, message)
        fatalError(message)
    }
}

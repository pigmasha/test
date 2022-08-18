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
        matrix = Matrix(zeroMatrix: Utils.qSize(hhDeg), h: Utils.qSize(0))
        for j in 0 ..< gen.elem.count {
            for (k, w) in gen.elem[j].contents {
                matrix.rows[0][j].add(left: w, right: Way.e, koef: k.n)
            }
        }
    }

    init(nextAfter shift: ShiftHH) {
        hhDeg = shift.hhDeg
        shiftDeg = shift.shiftDeg + 1
        hhLabel = shift.hhLabel
        matrix = Matrix(zeroMatrix: Utils.qSize(hhDeg + shiftDeg), h: Utils.qSize(shiftDeg))
        _ = shiftV0(hhLabel)
        let mult = Matrix(mult: shift.matrix, and: Diff(deg: shift.hhDeg + shift.shiftDeg))
        let diff = Diff(deg: shift.shiftDeg)
        if mult.width != matrix.width { fatalError() }
        //PrintUtils.printMatrix("Diff", diff)
        //PrintUtils.printMatrix("Mult", mult)
        if let err = SearchForMult.search(for: matrix, multWith: diff, mult: mult, mode: hhDeg == 0 ? .fillDiag : .fill) {
            OutputFile.writeLog(.error, "SearchForMult.search error=" + err)
        }
        /*for j in 0 ..< mult.width {
            if hhDeg == 0 {
                fillDiag(column: j, diff: diff, mult: mult)
            } else {
                fill(column: j, diff: diff, mult: mult)
            }
        }*/
        let m2 = Matrix(mult: diff, and: matrix)
        let n = m2.numberOfDifferents(with: mult)
        if n != 0 {
            //PrintUtils.printMatrix("Diff", diff)
            //PrintUtils.printMatrix("Mult", mult)
            PrintUtils.printMatrix("Mult2", m2, redColumns: m2.diffColumns(with: mult))
            OutputFile.writeLog(.error, "Number of differents: \(n)")
            multErr = true
        }
    }

    init(gen: Gen, shiftDeg: Int) {
        hhDeg = gen.deg
        self.shiftDeg = shiftDeg
        self.hhLabel = gen.label
        matrix = Matrix(zeroMatrix: Utils.qSize(hhDeg + shiftDeg), h: Utils.qSize(shiftDeg))
        if shiftP0(gen.label) { return }
        if shiftU0(gen.label) { return }
        if shiftV0(gen.label) { return }
        if shiftW0(gen.label) { return }
        if shiftT(gen.label) { return }
    }

    func print() {
        PrintUtils.printMatrix(PathAlg.isTex ? "T^"+(shiftDeg < 10 ? "\(shiftDeg)" : "{\(shiftDeg)}")+"(" + Step_9_tex.genToTex[hhLabel]! + ")=" : "Shift \(shiftDeg)", matrix)
    }

    func check() -> String? {
        if let err = CreateDiff.checkDeg(matrix: matrix, degFrom: hhDeg + shiftDeg, degTo: shiftDeg) {
            return err
        }
        return multErr ? "Mult error" : nil
    }

    func add(row: Int, col: Int, comb: Comb) {
        matrix.rows[row][col].add(comb: comb)
        let r2 = matrix.height % 2 == 0 ? (row % 2 == 0 ? row + 1 : row - 1) : (row == 0 ? row : (row % 2 == 0 ? row - 1 : row + 1))
        matrix.rows[r2][col + 1].add(comb: comb.phi)
    }

    // n! / k!(n-k)!
    func hasKoef(n: Int, k: Int) -> Bool {
        return (n | k) == n
    }

    func jj(with n: Int) -> [Int] {
        let s = shiftDeg / 2
        if s == 0 { return [] }
        var rr: [Int] = []
        for i in 0 ... s - 1 {
            if hasKoef(n: s, k: i + 1) {
                rr.append(2 * i + 1 + n)
            }
        }
        return rr
    }
}

//
//  Diff.swift
//  Created by M on 16.05.2022.
//

import Foundation

final class Diff: Matrix {
    let deg: Int

    static func printTex() {
        for i in 0 ... 1 {
            PrintUtils.printMatrix("A_\(i)=", Diff(a: i))
        }
        for i in 0 ... 7 {
            PrintUtils.printMatrix("l_\(i)=", Diff(l: i))
            if i > 5 {
                PrintUtils.printMatrix("l_\(i)^L=", Diff(ll: i, isWave: false))
                PrintUtils.printMatrix("\\widetilde{l}_\(i)^L=", Diff(ll: i, isWave: true))
            }
        }
        PrintUtils.printMatrix("B=", Diff(bL: false))
        PrintUtils.printMatrix("B^L=", Diff(bL: false))
        PrintUtils.printMatrix("P_0=", Diff(p: 0))
        PrintUtils.printMatrix("P_i=", Diff(p: 5))
    }

    static func checkRelations() -> Int {
        for m in 0 ... 6 {
            let m1 = Matrix(mult: Diff(deg: m), and: Diff(deg: m + 1))
            if m1.isNil || !m1.isZero { return 1 }
            let m2 = Matrix(mult: Diff(ll: m, isWave: true), and: Diff(deg: m + 1))
            let m3 = Matrix(mult: Diff(deg: m), and: Diff(ll: m + 1, isWave: true))
            let m4 = Matrix(mult: Diff(l: m), and: Diff(p: m + 1))
            if m2.isNil || m3.isNil || m4.isNil { return 2 }
            m2.add(m3, koef: 1)
            m2.add(m4, koef: 1)
            if !m2.isZero { return 3 }
            let m5 = Matrix(mult: Diff(ll: m, isWave: true), and: Diff(ll: m + 1, isWave: true))
            if m5.isNil || !m5.isZero { return 4 }
            let m6 = Matrix(mult: Diff(ll: m, isWave: false), and: Diff(p: m + 1))
            if m6.isNil || !m6.isZero { return 5 }
        }
        return 0
    }

    init(emptyForDeg deg: Int) {
        self.deg = deg
        super.init()
        makeZeroMatrix(Utils.qSize(deg + 1), h: Utils.qSize(deg))
    }

    convenience init(deg: Int) {
        self.init(emptyForDeg: deg)
        let m = deg % 8
        fillDiff(d: m)
        let n = deg / 8
        if n == 0 { return }
        if n % 2 == 1 { putLL(idx: m, isWave: true, at: (0,0)) }
        putP(idx: m, at: (0, m + 1))
        putL(idx: m, at: (m + 2 + 8 * (n - 1), 0))
        putA(idx: m, at: (m + 2 + 8 * (n - 1), m + 1 + 8 * (n - 1)))
        if n == 1 { return }
        for i in 0 ... n - 2 {
            if hasKoef(n: n, k: n - i - 1) { putL(idx: m, at: (m + 2 + 8 * i, 0)) }
            if hasKoef(n: n, k: n - i - 2) { putLL(idx: m, isWave: false, at: (m + 2 + 8 * i, 0)) }
            putB(at: (m + 2 + 8 * (n - 1), m + 1 + 8 * i))
            putA(idx: m, at: (m + 2 + 8 * i, m + 1 + 8 * i))
            if hasKoef(n: n - i - 1, k: n - i - 2) { putBL(at: (m + 2 + 8 * i, m + 1 + 8 * i)) }
            putP(at: (m + 2 + 8 * i, m + 1 + 8 * (i + 1)))
        }
        if n == 2 { return }
        for i in 0 ... n - 3 {
            for j in 0 ... n - 3 - i {
                if hasKoef(n: n - 1 - i, k: n - 2 - i - j) {
                    putB(at: (m + 2 + 8 * (i + j + 1), m + 1 + 8 * i))
                }
                if hasKoef(n: n - 1 - i, k: n - 3 - i - j) {
                    putBL(at: (m + 2 + 8 * (i + j + 1), m + 1 + 8 * i))
                }
            }
        }
    }

    private init(a: Int) {
        self.deg = 0
        super.init()
        makeZeroMatrix(8, h: 8)
        putA(idx: a, at: (0, 0))
    }

    private init(l: Int) {
        self.deg = 0
        super.init()
        makeZeroMatrix(8, h: l + 1)
        putL(idx: l, at: (0, 0))
    }

    private init(ll: Int, isWave: Bool) {
        self.deg = 0
        super.init()
        makeZeroMatrix(isWave ? ll + 2 : 8, h: ll + 1)
        putLL(idx: ll, isWave: isWave, at: (0, 0))
    }

    private init(bL: Bool) {
        self.deg = 0
        super.init()
        makeZeroMatrix(8, h: 8)
        if bL {
            putBL(at: (0, 0))
        } else {
            putB(at: (0, 0))
        }
    }

    private init(p: Int) {
        self.deg = 0
        super.init()
        makeZeroMatrix(p + 2, h: 8)
        putP(idx: p, at: (0, 0))
    }

    private func add(row: Int, col: Int, height: Int, comb: Comb) {
        rows[row][col].add(comb: comb)
        let r2 = height % 2 == 0 ? (row % 2 == 0 ? row + 1 : row - 1) : (row == 0 ? row : (row % 2 == 0 ? row - 1 : row + 1))
        rows[r2][col + 1].add(comb: comb.phi)
    }

    private func fillDiff(d: Int) {
        if d > 7 { fatalError("fillDiff: bad deg \(d)") }
        if d % 2 == 1 {
            rows[0][0].add(comb: SearchForMult.ly)
            rows[0][0].add(comb: SearchForMult.ry)
            rows[1][0].add(comb: SearchForMult.lx)
            rows[1][0].add(comb: SearchForMult.rx)
        }
        switch d % 4 {
        case 0:
            add(row: 0, col: 0, height: d + 1, comb: SearchForMult.delta(way: Way.x))
        case 1:
            add(row: 0, col: 1, height: d + 1, comb: SearchForMult.delta(way: Way.x))
            add(row: 0, col: 1, height: d + 1, comb: SearchForMult.ly)
            add(row: 1, col: 1, height: d + 1, comb: SearchForMult.rx)
        case 2:
            add(row: 0, col: 0, height: d + 1, comb: SearchForMult.delta(way: Way.x))
            add(row: 0, col: 0, height: d + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: 1, col: 0, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 2, col: 0, height: d + 1, comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            add(row: 0, col: 2, height: d + 1, comb: Comb.ex)
            add(row: 1, col: 2, height: d + 1, comb: SearchForMult.delta(way: Way.x))
        case 3:
            add(row: 0, col: 1, height: d + 1, comb: SearchForMult.deltaXWave)
            add(row: 1, col: 1, height: d + 1, comb: Comb(left: Way.e, right: Way.zx, label: ""))
            add(row: 1, col: 1, height: d + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: 2, col: 1, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 2, col: 3, height: d + 1, comb: SearchForMult.xWaveEPlusEX)
        default:
            fatalError()
        }
        switch d {
        case 0, 1, 2:
            break
        case 3:
            add(row: 0, col: 3, height: d + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: 1, col: 3, height: d + 1, comb: SearchForMult.ezxPlusRx)
        case 4:
            add(row: 1, col: 0, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 2, col: 0, height: d + 1, comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            add(row: 0, col: 2, height: d + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: 1, col: 2, height: d + 1, comb: SearchForMult.xEPlusEXWave)
            add(row: 3, col: 2, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 0, col: 4, height: d + 1, comb: Comb.ex)
            add(row: 1, col: 4, height: d + 1, comb: Comb.ex)
            add(row: 3, col: 4, height: d + 1, comb: SearchForMult.delta(way: Way.x))
        case 5:
            add(row: 2, col: 1, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 0, col: 3, height: d + 1, comb: SearchForMult.ly)
            add(row: 0, col: 3, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 1, col: 3, height: d + 1, comb: Comb(left: Way.e, right: Way.zx, label: ""))
            add(row: 1, col: 3, height: d + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: 1, col: 3, height: d + 1, comb: SearchForMult.rx)
            add(row: 2, col: 3, height: d + 1, comb: SearchForMult.deltaXWave)
            add(row: 4, col: 3, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 0, col: 5, height: d + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: 1, col: 5, height: d + 1, comb: SearchForMult.ezxPlusRx)
            add(row: 2, col: 5, height: d + 1, comb: Comb.ex)
            add(row: 4, col: 5, height: d + 1, comb: SearchForMult.xWaveEPlusEX)
        case 6:
            add(row: 0, col: 2, height: d + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: 3, col: 2, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 0, col: 4, height: d + 1, comb: Comb.ex)
            add(row: 0, col: 4, height: d + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: 1, col: 4, height: d + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: 3, col: 4, height: d + 1, comb: SearchForMult.xEPlusEXWave)
            add(row: 5, col: 4, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 0, col: 6, height: d + 1, comb: Comb.ex)
            add(row: 1, col: 6, height: d + 1, comb: Comb.ex)
            add(row: 3, col: 6, height: d + 1, comb: Comb.ex)
            add(row: 5, col: 6, height: d + 1, comb: SearchForMult.delta(way: Way.x))
        case 7:
            add(row: 0, col: 3, height: d + 1, comb: SearchForMult.eXWave)
            add(row: 1, col: 3, height: d + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: 4, col: 3, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 0, col: 5, height: d + 1, comb: SearchForMult.eXWave)
            add(row: 1, col: 5, height: d + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: 2, col: 5, height: d + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: 4, col: 5, height: d + 1, comb: SearchForMult.deltaXWave)
            add(row: 6, col: 5, height: d + 1, comb: SearchForMult.delta(way: Way.zy))
            add(row: 0, col: 7, height: d + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: 1, col: 7, height: d + 1, comb: SearchForMult.ezxPlusRx)
            add(row: 2, col: 7, height: d + 1, comb: Comb.ex)
            add(row: 4, col: 7, height: d + 1, comb: Comb.ex)
            add(row: 6, col: 7, height: d + 1, comb: SearchForMult.xWaveEPlusEX)
        default:
            fatalError("Unknown deg \(d)")
        }
    }

    private func putA(idx: Int, at pos: (Int, Int)) {
        let is0 = idx % 2 == 0
        add(row: pos.1, col: pos.0, height: pos.1, comb: is0 ? SearchForMult.xEPlusEXWave : SearchForMult.deltaXWave)
        add(row: pos.1 + 2, col: pos.0, height: pos.1, comb: SearchForMult.delta(way: Way.zy))
        add(row: pos.1, col: pos.0 + 2, height: pos.1, comb: SearchForMult.eXWave)
        add(row: pos.1 + 2, col: pos.0 + 2, height: pos.1, comb: is0 ? SearchForMult.delta(way: Way.x) : SearchForMult.xWaveEPlusEX)
        add(row: pos.1 + 4, col: pos.0 + 2, height: pos.1, comb: SearchForMult.delta(way: Way.zy))
        add(row: pos.1, col: pos.0 + 4, height: pos.1, comb: SearchForMult.eXWave)
        add(row: pos.1 + 2, col: pos.0 + 4, height: pos.1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
        add(row: pos.1 + 4, col: pos.0 + 4, height: pos.1, comb: is0 ? SearchForMult.xEPlusEXWave : SearchForMult.deltaXWave)
        add(row: pos.1 + 6, col: pos.0 + 4, height: pos.1, comb: SearchForMult.delta(way: Way.zy))
        add(row: pos.1, col: pos.0 + 6, height: pos.1, comb: Comb.ex)
        add(row: pos.1 + 2, col: pos.0 + 6, height: pos.1, comb: Comb.ex)
        add(row: pos.1 + 4, col: pos.0 + 6, height: pos.1, comb: Comb.ex)
        add(row: pos.1 + 6, col: pos.0 + 6, height: pos.1, comb: is0 ? SearchForMult.delta(way: Way.x) : SearchForMult.xWaveEPlusEX)
    }

    // /end
    private func putL(idx: Int, at pos: (Int, Int)) {
        let ezxPlusXWxPlusRx: () -> Comb = {
            let c = Comb()
            c.add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            c.add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            c.add(comb: SearchForMult.rx)
            c.updateLabel()
            return c
        }
        let ezxPlusRx: () -> Comb = {
            let c = Comb()
            c.add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            c.add(comb: SearchForMult.rx)
            c.updateLabel()
            return c
        }
        let exPlusYWx: () -> Comb = {
            let c = Comb()
            c.add(comb: Comb(left: Way.e, right: Way.x, label: ""))
            c.add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            c.updateLabel()
            return c
        }
        let lyPlusDeltaZy: () -> Comb = {
            let c = Comb()
            c.add(comb: SearchForMult.ly)
            c.add(comb: SearchForMult.delta(way: Way.zy))
            c.updateLabel()
            return c
        }
        let putExEx: ([Int], Int) -> Void = { ii, j in
            for i in ii {
                self.add(row: pos.1 + i, col: pos.0 + j, height: idx + 1, comb: Comb.ex)
            }
        }
        switch idx {
        case 0:
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: pos.1, col: pos.0 + 6, height: idx + 1, comb: Comb.ex)
        case 1:
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: lyPlusDeltaZy())
            add(row: pos.1 + 1, col: pos.0 + 4, height: idx + 1, comb: ezxPlusXWxPlusRx())
            add(row: pos.1, col: pos.0 + 6, height: idx + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: pos.1 + 1, col: pos.0 + 6, height: idx + 1, comb: ezxPlusRx())
        case 2:
            add(row: pos.1, col: pos.0 + 2, height: idx + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: exPlusYWx())
            add(row: pos.1 + 1, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            putExEx([0, 1], 6)
        case 3:
            add(row: pos.1, col: pos.0 + 2, height: idx + 1, comb: lyPlusDeltaZy())
            add(row: pos.1 + 1, col: pos.0 + 2, height: idx + 1, comb: ezxPlusXWxPlusRx())
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 1, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: pos.1 + 2, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 6, height: idx + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: pos.1 + 1, col: pos.0 + 6, height: idx + 1, comb: ezxPlusRx())
            add(row: pos.1 + 2, col: pos.0 + 6, height: idx + 1, comb: Comb.ex)
        case 4:
            add(row: pos.1, col: pos.0, height: idx + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: pos.1, col: pos.0 + 2, height: idx + 1, comb: Comb.ex)
            add(row: pos.1 + 1, col: pos.0 + 2, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
            add(row: pos.1 + 1, col: pos.0 + 4, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 3, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            putExEx([0, 1, 3], 6)
        case 5:
            add(row: pos.1, col: pos.0, height: idx + 1, comb: lyPlusDeltaZy())
            add(row: pos.1 + 1, col: pos.0, height: idx + 1, comb: ezxPlusXWxPlusRx())
            add(row: pos.1, col: pos.0 + 2, height: idx + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: pos.1 + 1, col: pos.0 + 2, height: idx + 1, comb: ezxPlusRx())
            add(row: pos.1 + 2, col: pos.0 + 2, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: lyPlusDeltaZy())
            add(row: pos.1 + 1, col: pos.0 + 4, height: idx + 1, comb: ezxPlusXWxPlusRx())
            add(row: pos.1 + 2, col: pos.0 + 4, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 4, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 6, height: idx + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: pos.1 + 1, col: pos.0 + 6, height: idx + 1, comb: ezxPlusRx())
            putExEx([2, 4], 6)
        case 6:
            add(row: pos.1, col: pos.0, height: idx + 1, comb: exPlusYWx())
            add(row: pos.1 + 1, col: pos.0, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 2, height: idx + 1, comb: exPlusYWx())
            add(row: pos.1 + 1, col: pos.0 + 2, height: idx + 1, comb: Comb.ex)
            add(row: pos.1 + 3, col: pos.0 + 2, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: exPlusYWx())
            add(row: pos.1 + 1, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1 + 3, col: pos.0 + 4, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 5, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            putExEx([0, 1, 3, 5], 6)
        case 7:
            add(row: pos.1, col: pos.0, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 1, col: pos.0, height: idx + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: pos.1 + 2, col: pos.0, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 2, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 1, col: pos.0 + 2, height: idx + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: pos.1 + 2, col: pos.0 + 2, height: idx + 1, comb: Comb.ex)
            add(row: pos.1 + 4, col: pos.0 + 2, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 4, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 1, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.x, right: Way.wx, label: ""))
            add(row: pos.1 + 2, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1 + 4, col: pos.0 + 4, height: idx + 1, comb: SearchForMult.eXWave)
            add(row: pos.1 + 6, col: pos.0 + 4, height: idx + 1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
            add(row: pos.1, col: pos.0 + 6, height: idx + 1, comb: SearchForMult.exPlusLyPlusZyE)
            add(row: pos.1 + 1, col: pos.0 + 6, height: idx + 1, comb: ezxPlusRx())
            putExEx([2, 4, 6], 6)
        default:
            fatalError("putL: bad index \(idx)")
        }
    }

    private func putLL(idx: Int, isWave: Bool, at pos: (Int, Int)) {
        let ezxPlusXWxPlusRx: () -> Comb = {
            let c = Comb()
            c.add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            c.add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            c.add(comb: SearchForMult.rx)
            c.updateLabel()
            return c
        }
        let lyPlusDeltaZy: () -> Comb = {
            let c = Comb()
            c.add(comb: SearchForMult.ly)
            c.add(comb: SearchForMult.delta(way: Way.zy))
            c.updateLabel()
            return c
        }
        switch idx {
        case 0, 1, 2, 3, 4, 5:
            break
        case 6:
            add(row: pos.1, col: pos.0 + 6, height: idx + 1, comb: Comb(left: Way.y, right: Way.wx, label: ""))
        case 7:
            add(row: pos.1, col: pos.0 + (isWave ? 7 : 6), height: idx + 1, comb: lyPlusDeltaZy())
            add(row: pos.1 + 1, col: pos.0 + (isWave ? 7 : 6), height: idx + 1, comb: ezxPlusXWxPlusRx())
        default:
            fatalError("putLL: bad index \(idx)")
        }
    }

    private func putB(at pos: (Int, Int)) {
        add(row: pos.1, col: pos.0, height: pos.1, comb: SearchForMult.eXWave)
        add(row: pos.1 + 2, col: pos.0, height: pos.1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
        add(row: pos.1, col: pos.0 + 2, height: pos.1, comb: SearchForMult.eXWave)
        add(row: pos.1 + 2, col: pos.0 + 2, height: pos.1, comb: Comb.ex)
        add(row: pos.1 + 4, col: pos.0 + 2, height: pos.1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
        add(row: pos.1, col: pos.0 + 4, height: pos.1, comb: SearchForMult.eXWave)
        add(row: pos.1 + 2, col: pos.0 + 4, height: pos.1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
        add(row: pos.1 + 4, col: pos.0 + 4, height: pos.1, comb: SearchForMult.eXWave)
        add(row: pos.1 + 6, col: pos.0 + 4, height: pos.1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
        add(row: pos.1, col: pos.0 + 6, height: pos.1, comb: Comb.ex)
        add(row: pos.1 + 2, col: pos.0 + 6, height: pos.1, comb: Comb.ex)
        add(row: pos.1 + 4, col: pos.0 + 6, height: pos.1, comb: Comb.ex)
        add(row: pos.1 + 6, col: pos.0 + 6, height: pos.1, comb: Comb.ex)
    }

    private func putBL(at pos: (Int, Int)) {
        add(row: pos.1, col: pos.0 + 6, height: pos.1, comb: Comb(left: Way.e, right: Way.zy, label: ""))
    }

    private func putP(idx: Int, at pos: (Int, Int)) {
        switch idx {
        case 0:
            add(row: pos.1, col: pos.0, height: pos.1, comb: SearchForMult.delta(way: Way.zy))
            add(row: pos.1 + 1, col: pos.0, height: pos.1, comb: Comb(left: Way.wy, right: Way.zx, label: ""))
        case 1, 2, 3, 4, 5, 6, 7:
            add(row: pos.1, col: pos.0 + idx, height: pos.1, comb: SearchForMult.delta(way: Way.zy))
        default:
            fatalError("putLL: bad index \(idx)")
        }
    }

    private func putP(at pos: (Int, Int)) {
        putP(idx: 6, at: pos)
    }

    // n! / k!(n-k)!
    private func hasKoef(n: Int, k: Int) -> Bool {
        return (n | k) == n
    }

    private func fillDiffGai(d: Int) {
        switch d {
        case 0:
            rows[0][0].add(comb: SearchForMult.delta(way: Way.x))
            rows[0][1].add(comb: SearchForMult.delta(way: Way.y))
        case 1:
            rows[0][0].add(comb: SearchForMult.delta(way: Way.x))
            rows[0][0].add(comb: SearchForMult.ly)
            rows[1][0].add(comb: SearchForMult.rx)
            rows[0][1].add(comb: SearchForMult.delta(way: Way.x))
            rows[1][1].add(comb: SearchForMult.delta(way: Way.y))
            rows[0][2].add(comb: SearchForMult.ry)
            rows[1][2].add(comb: SearchForMult.delta(way: Way.y))
            rows[1][2].add(comb: SearchForMult.lx)
        case 2:
            rows[0][0].add(comb: Comb.xe)
            rows[1][0].add(comb: Comb.ex)
            rows[2][0].add(comb: Comb.ex)
            rows[2][3].add(comb: Comb.ye)
            rows[1][3].add(comb: Comb.ey)
            rows[0][3].add(comb: Comb.ey)
            rows[0][1].add(comb: Comb.ye)
            rows[0][1].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            rows[1][1].add(comb: Comb.ye)
            rows[1][1].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            rows[1][1].add(comb: SearchForMult.delta(way: Way.zx))
            rows[2][1].add(comb: Comb.ey)
            rows[2][1].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            rows[2][2].add(comb: Comb.xe)
            rows[2][2].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            rows[1][2].add(comb: Comb.xe)
            rows[1][2].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            rows[1][2].add(comb: SearchForMult.delta(way: Way.zy))
            rows[0][2].add(comb: Comb.ex)
            rows[0][2].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
        default:
            break
        }
    }
}

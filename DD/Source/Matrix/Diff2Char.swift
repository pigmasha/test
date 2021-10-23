//
//  Diff2Char.swift
//  DD
//
//  Created by M on 23.10.2021.
//

import Foundation

extension Diff {
    func fillDiff2Char() {
        fillDiff2Char(deg: deg, pos: 0)
    }

    private func fillDiff2Char(deg d: Int, pos p: Int) {
        switch d {
        case 0: fillDiff2Char0(pos: p)
        case 1: fillDiff2Char1(pos: p)
        case 2: fillDiff2Char2(pos: p)
        case 3: fillDiff2Char3(pos: p)
        case 4: fillDiff2Char4(pos: p)
        default:
            let k = PathAlg.k
            let c = PathAlg.c
            rows[p][p].add(comb: d % 2 == 1 ? yWaveComb : yComb)
            let c01 = rhoComb
            c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
            rows[p][p+1].add(comb: c01)
            rows[p+1][p].add(comb: Comb(left: Way.e, right: Way.y, koef: PathAlg.d))
            rows[p+1][p+1].add(comb: d % 2 == 1 ? yComb : yWaveComb)
            rows[p+1][p+2].add(comb: rhoComb)
            fillDiff2Char(deg: d - 4, pos: p + 2)
        }
    }

    private func fillDiff2Char0(pos p: Int) {
        rows[p][p].add(comb: yComb)
        rows[p][p+1].add(comb: xComb)
    }

    private func fillDiff2Char1(pos p: Int) {
        let k = PathAlg.k
        let c00 = yComb
        for i in 0 ... k - 1 {
            c00.add(left: Way(type: .x, len: 2 * i + 1), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: PathAlg.d)
        }
        rows[p][p].add(comb: c00)
        let c01 = Comb()
        for i in 0 ... k - 1 {
            c01.add(left: Way(type: .y, len: 2 * i), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: 1)
        }
        for i in 0 ... k - 1 {
            c01.add(left: Way(type: .x, len: 2 * i + 1), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: PathAlg.c)
        }
        rows[p][p+1].add(comb: c01)
        let c10 = Comb()
        for i in 0 ... k - 1 {
            c10.add(left: Way(type: .x, len: 2 * i), right: Way(type: .y, len: 2 * (k - 1 - i) + 1), koef: PathAlg.d)
        }
        rows[p+1][p].add(comb: c10)
        let c11 = xComb
        for i in 0 ... k - 2 {
            c11.add(left: Way(type: .y, len: 2 * i + 1), right: Way(type: .y, len: 2 * (k - 2 - i) + 1), koef: 1)
        }
        for i in 0 ... k - 1 {
            c11.add(left: Way(type: .x, len: 2 * i), right: Way(type: .y, len: 2 * (k - 1 - i) + 1), koef: PathAlg.c)
        }
        rows[p+1][p+1].add(comb: c11)
    }

    private func fillDiff2Char2(pos p: Int) {
        let k = PathAlg.k
        let c = PathAlg.c
        let d = PathAlg.d
        rows[p][p].add(comb: yComb)
        let c01 = rhoComb
        c01.add(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .x, len: 2 * k), koef: c * c)
        c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
        rows[p][p+1].add(comb: c01)
        let c10 = Comb(left: Way.e, right: Way(type: .x, len: 2), koef: d)
        c10.add(left: Way.x, right: Way.y, koef: d)
        c10.add(left: Way.x, right: Way(type: .x, len: 2), koef: c * d)
        c10.add(left: Way(type: .y, len: 2 * k - 1), right: Way.y, koef: c * d)
        c10.add(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .x, len: 2), koef: c * c * d)
        rows[p+1][p].add(comb: c10)
        let c11 = xComb
        c11.compRight(comb: yComb)
        c11.add(left: Way(type: .y, len: 2 * k - 1), right: Way.y, koef: c)
        c11.add(left: Way(type: .x, len: 2 * k), right: Way.y, koef: c * c)
        c11.add(left: Way.x, right: Way(type: .x, len: 2), koef: c)
        c11.add(left: Way(type: .y, len: 2), right: Way.x, koef: c)
        c11.add(left: Way.x, right: Way(type: .x, len: 2 * k - 1), koef: d)
        c11.add(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .y, len: 2 * k - 2), koef: d)
        c11.add(left: Way(type: .x, len: 2 * k - 2), right: Way(type: .y, len: 2 * k - 1), koef: d)
        c11.add(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .x, len: 2 * k - 1), koef: c * d)
        rows[p+1][p+1].add(comb: c11)
    }

    private func fillDiff2Char3(pos p: Int) {
        let k = PathAlg.k
        let c = PathAlg.c
        let d = PathAlg.d
        rows[p][p].add(comb: yWaveComb)
        let c01 = rhoComb
        c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
        rows[p][p+1].add(comb: c01)
        let c10 = Comb(left: Way.e, right: Way.y, koef: d)
        for i in 0 ... k - 2 {
            c10.add(left: Way(type: .x, len: 2 * i + 1), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: d * d)
        }
        rows[p+1][p].add(comb: c10)
        let c11 = yComb
        for i in 0 ... k - 2 {
            c11.add(left: Way(type: .x, len: 2 * i + 1), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: d)
        }
        for i in 1 ... k - 1 {
            c11.add(left: Way(type: .y, len: 2 * i), right: Way(type: .x, len: 2 * (k - 1 - i) + 1), koef: d)
        }
        c11.add(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .y, len: 2 * k - 1), koef: c * d)
        rows[p+1][p+1].add(comb: c11)
        let c12 = Comb()
        for i in 0 ... k - 1 {
            c12.add(left: Way(type: .y, len: 2 * i), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: 1)
        }
        c12.compRight(comb: xComb)
        c12.add(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .y, len: 2 * k - 1), koef: c)
        rows[p+1][p+2].add(comb: c12)
    }

    private func fillDiff2Char4(pos p: Int) {
        let k = PathAlg.k
        let c = PathAlg.c
        rows[p][p].add(comb: yComb)
        let c01 = rhoComb
        c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
        rows[p][p+1].add(comb: c01)
        rows[p+1][p].add(left: Way.e, right: Way.y, koef: PathAlg.d)
        rows[p+1][p+1].add(comb: yWaveComb)
        rows[p+1][p+2].add(comb: rhoComb)
        let c13 = Comb(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .x, len: 2 * k - 2), koef: 1)
        c13.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k - 2), koef: c)
        rows[p+1][p+3].add(comb: c13)
        rows[p+2][p+2].add(comb: yComb)
        rows[p+2][p+3].add(comb: xComb)
    }

    private var xComb: Comb {
        let c = Comb(left: Way.x, right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way.x, koef: 1)
        return c
    }

    private var yComb: Comb {
        let c = Comb(left: Way.y, right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way.y, koef: 1)
        return c
    }

    private var yWaveComb: Comb {
        let c = Comb(left: Way.y, right: Way.e, koef: 1)
        c.add(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: PathAlg.d)
        c.add(left: Way.e, right: Way.y, koef: 1)
        return c
    }

    private var rhoComb: Comb {
        let c = Comb(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way(type: .x, len: 2 * PathAlg.k - 1), koef: 1)
        return c
    }
}

//
//  Created by M on 13.10.2021.
//

import Foundation

final class Diff: Matrix {
    let deg: Int

    init(emptyForDeg deg: Int) {
        self.deg = deg
        super.init()
        let sz = size(deg: deg)
        makeZeroMatrix(sz.0, h: sz.1)
    }

    convenience init(deg: Int) {
        self.init(emptyForDeg: deg)
        fillDiff(deg: deg, pos: 0)
    }

    private func fillDiff(deg d: Int, pos p: Int) {
        switch d {
        case 0: fillDiff0(pos: p)
        case 1: fillDiff1(pos: p)
        case 2: fillDiff2(pos: p)
        case 3: fillDiff3(pos: p)
        case 4: fillDiff4(pos: p)
        default:
            let k = PathAlg.k
            let c = PathAlg.c
            let c00 = Comb()
            if d % 2 == 1 {
                c00.add(comb: yPlus)
                c00.add(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: -PathAlg.d)
            } else {
                c00.add(comb: yMinus)
            }
            rows[p][p].add(comb: c00)
            let c01 = rhoMinus
            c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
            rows[p][p+1].add(comb: c01)
            rows[p+1][p].add(comb: Comb(left: Way.e, right: Way.y, koef: -PathAlg.d))
            let c11 = Comb()
            if d % 2 == 1 {
                let cc = yMinus
                cc.compKoef(-1)
                c11.add(comb: cc)
            } else {
                let cc = yPlus
                cc.compKoef(-1)
                c11.add(comb: cc)
                c11.add(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: PathAlg.d)
            }
            rows[p+1][p+1].add(comb: c11)
            rows[p+1][p+2].add(comb: rhoPlus)
            fillDiff(deg: d - 4, pos: p + 2)
        }
    }

    private func size(deg d: Int) -> (Int, Int) {
        switch d {
        case 0: return (2, 1)
        case 1, 2: return (2, 2)
        case 3: return (3, 2)
        case 4: return (4, 3)
        default:
            let sz = size(deg: d - 4)
            return (2 + sz.0, 2 + sz.1)
        }
    }

    private func fillDiff0(pos p: Int) {
        rows[p][p].add(comb: yMinus)
        rows[p][p+1].add(comb: xMinus)
    }

    private func fillDiff1(pos p: Int) {
        let k = PathAlg.k
        let c00 = yPlus
        for i in 0 ... k - 1 {
            c00.add(left: Way(type: .x, len: 2 * i + 1), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: -PathAlg.d)
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
            c10.add(left: Way(type: .x, len: 2 * i), right: Way(type: .y, len: 2 * (k - 1 - i) + 1), koef: -PathAlg.d)
        }
        rows[p+1][p].add(comb: c10)
        let c11 = xPlus
        c11.compKoef(-1)
        for i in 0 ... k - 2 {
            c11.add(left: Way(type: .y, len: 2 * i + 1), right: Way(type: .y, len: 2 * (k - 2 - i) + 1), koef: 1)
        }
        for i in 0 ... k - 1 {
            c11.add(left: Way(type: .x, len: 2 * i), right: Way(type: .y, len: 2 * (k - 1 - i) + 1), koef: PathAlg.c)
        }
        rows[p+1][p+1].add(comb: c11)
    }

    private func fillDiff2(pos p: Int) {
        let k = PathAlg.k
        let c = PathAlg.c
        let d = PathAlg.d
        rows[p][p].add(comb: yMinus)
        let c01 = rhoMinus
        c01.add(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .x, len: 2 * k), koef: c * c)
        c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
        rows[p][p+1].add(comb: c01)
        let c10 = Comb(left: Way.e, right: Way(type: .x, len: 2), koef: d)
        c10.add(left: Way.x, right: Way.y, koef: -d)
        c10.add(left: Way.x, right: Way(type: .x, len: 2), koef: -c * d)
        c10.add(left: Way(type: .y, len: 2 * k - 1), right: Way.y, koef: c * d)
        c10.add(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .x, len: 2), koef: c * c * d)
        rows[p+1][p].add(comb: c10)
        let c11 = xMinus
        c11.compKoef(-1)
        c11.compRight(comb: yPlus)
        c11.add(left: Way(type: .y, len: 2 * k - 1), right: Way.y, koef: c)
        c11.add(left: Way(type: .x, len: 2 * k), right: Way.y, koef: c * c)
        c11.add(left: Way.x, right: Way(type: .x, len: 2), koef: -c)
        c11.add(left: Way(type: .y, len: 2), right: Way.x, koef: -c)
        c11.add(left: Way.x, right: Way(type: .x, len: 2 * k - 1), koef: -d)
        c11.add(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .y, len: 2 * k - 2), koef: d)
        c11.add(left: Way(type: .x, len: 2 * k - 2), right: Way(type: .y, len: 2 * k - 1), koef: -d)
        c11.add(left: Way(type: .y, len: 2 * k - 1), right: Way(type: .x, len: 2 * k - 1), koef: c * d)
        rows[p+1][p+1].add(comb: c11)
    }

    private func fillDiff3(pos p: Int) {
        let k = PathAlg.k
        let c = PathAlg.c
        let d = PathAlg.d
        let c00 = yPlus
        c00.add(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: -d)
        rows[p][p].add(comb: c00)
        let c01 = rhoMinus
        c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
        rows[p][p+1].add(comb: c01)
        let c10 = Comb(left: Way.e, right: Way.y, koef: -d)
        for i in 0 ... k - 2 {
            c10.add(left: Way(type: .x, len: 2 * i + 1), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: -d * d)
        }
        rows[p+1][p].add(comb: c10)
        let c11 = yMinus
        c11.compKoef(-1)
        for i in 0 ... k - 2 {
            c11.add(left: Way(type: .x, len: 2 * i + 1), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: d)
        }
        for i in 1 ... k - 1 {
            c11.add(left: Way(type: .y, len: 2 * i), right: Way(type: .x, len: 2 * (k - 1 - i) + 1), koef: -d)
        }
        c11.add(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .y, len: 2 * k - 1), koef: c * d)
        rows[p+1][p+1].add(comb: c11)
        let c12 = Comb()
        for i in 0 ... k - 1 {
            c12.add(left: Way(type: .y, len: 2 * i), right: Way(type: .x, len: 2 * (k - 1 - i)), koef: 1)
        }
        c12.compRight(comb: xPlus)
        c12.add(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .y, len: 2 * k - 1), koef: -c)
        rows[p+1][p+2].add(comb: c12)
    }

    private func fillDiff4(pos p: Int) {
        let k = PathAlg.k
        let c = PathAlg.c
        let d = PathAlg.d
        rows[p][p].add(comb: yMinus)
        let c01 = rhoMinus
        c01.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k), koef: c * c * c)
        rows[p][p+1].add(comb: c01)
        rows[p+1][p].add(left: Way.e, right: Way.y, koef: -d)
        let c11 = yPlus
        c11.compKoef(-1)
        c11.add(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: d)
        rows[p+1][p+1].add(comb: c11)
        rows[p+1][p+2].add(comb: rhoPlus)
        let c13 = Comb(left: Way(type: .y, len: 2 * k - 2), right: Way(type: .x, len: 2 * k - 2), koef: 1)
        c13.add(left: Way(type: .x, len: 2 * k - 1), right: Way(type: .x, len: 2 * k - 2), koef: c)
        rows[p+1][p+3].add(comb: c13)
        rows[p+2][p+2].add(comb: yMinus)
        rows[p+2][p+3].add(comb: xMinus)
    }

    private var yPlus: Comb {
        let c = Comb(left: Way.y, right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way.y, koef: 1)
        return c
    }

    private var yMinus: Comb {
        let c = Comb(left: Way.y, right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way.y, koef: -1)
        return c
    }

    private var xPlus: Comb {
        let c = Comb(left: Way.x, right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way.x, koef: 1)
        return c
    }

    private var xMinus: Comb {
        let c = Comb(left: Way.x, right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way.x, koef: -1)
        return c
    }

    private var rhoMinus: Comb {
        let c = Comb(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way(type: .x, len: 2 * PathAlg.k - 1), koef: -1)
        return c
    }

    private var rhoPlus: Comb {
        let c = Comb(left: Way(type: .x, len: 2 * PathAlg.k - 1), right: Way.e, koef: 1)
        c.add(left: Way.e, right: Way(type: .x, len: 2 * PathAlg.k - 1), koef: 1)
        return c
    }
}

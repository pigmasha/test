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
        /*switch d {
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
        }*/
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
}

//
//  Created by M on 14.06.2022.
//

import Foundation

extension ShiftHH {
    func shiftT(_ label: String) -> Bool {
        switch label {
        case "t":
            shiftT()
            return true
        default:
            return false
        }
    }

    func addT0(row: Int, col: Int, leftType: ArrType, leftFrom: Int) {
        let k = PathAlg.kk
        let rightType = leftFrom % 2 == 0 ? leftType.next : leftType
        for i in 0 ... k - 2 {
            matrix.rows[row][col].add(comb: Comb(left: Way(type: leftType, len: 2 * i + leftFrom),
                                                 right: Way(type: rightType, len: 2 * (k - i - 1) - leftFrom),
                                                 label: ""))
        }
    }

    private func shiftT() {
        for i in 0 ... shiftDeg {
            matrix.rows[i][i].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
            matrix.rows[i][i + 2].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        if shiftDeg % 2 == 0 {
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
            if shiftDeg == 0 { return }
            matrix.rows[1][0].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
        } else {
            matrix.rows[0][0].add(comb: Comb(left: Way.wy, right: Way.wy, label: ""))
            addT0(row: 0, col: 0, leftType: .y, leftFrom: 1)
            matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.e, label: ""))
            addT0(row: 1, col: 0, leftType: .y, leftFrom: 0)
            matrix.rows[0][1].add(comb: Comb(left: Way.wx, right: Way.e, label: ""))
            addT0(row: 0, col: 1, leftType: .x, leftFrom: 0)
            matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.wx, label: ""))
            addT0(row: 1, col: 1, leftType: .x, leftFrom: 1)
        }
        let s = shiftDeg / 2 + 1
        let c1 = Comb(left: shiftDeg % 2 == 0 ? Way.wy : Way.e, right: Way.wx, label: "")
        let c2 = Comb(left: shiftDeg % 2 == 0 ? Way.wx : Way.e, right: Way.wy, label: "")
        let rowPos = shiftDeg % 2 == 0 ? 1 : 0
        let colPos = shiftDeg % 2 == 0 ? 1 : 2
        for i in 0 ... s - 1 {
            if hasKoef(n: s, k: s - i - 1) {
                matrix.rows[rowPos + 1][colPos + 2 * i].add(comb: c1)
                matrix.rows[rowPos][colPos + 1 + 2 * i].add(comb: c2)
            }
        }
    }
}

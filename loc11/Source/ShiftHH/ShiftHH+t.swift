//
//  Created by M on 14.06.2022.
//

import Foundation

extension ShiftHH {
    func shiftT(_ label: String) -> Bool {
        switch label {
        case "t":
            shiftDeg % 2 == 0 ? shiftTEven() : shiftTOdd()
            return true
        default:
            return false
        }
    }

    func addT0(row: Int, col: Int, leftType: ArrType, leftFrom: Int, label ll: String?) {
        let k = PathAlg.kk
        let rightType = leftFrom % 2 == 0 ? leftType.next : leftType
        var label = "\\sum\\limits_{i=0}^{k-2}"
        if leftFrom % 2 == 0 {
            label += "(" + leftType.str + leftType.next.str + ")^{i" + (leftFrom == 0 ? "" : "+\(leftFrom/2)") + "}"
        } else {
            label += leftType.str + "(" + leftType.next.str + leftType.str + ")^{i" + (leftFrom == 1 ? "" : "+\(leftFrom/2)") + "}"
        }
        label += "\\otimes "
        if leftFrom % 2 == 0 {
            label += "(" + rightType.str + rightType.next.str + ")^{k-i-\(leftFrom/2+1)}"
        } else {
            label += rightType.str + "(" + rightType.next.str + rightType.str + ")^{k-i-\((leftFrom+1)/2+1)}"
        }
        let c = PathAlg.isTex ? Comb(label: ll ?? label) : Comb()
        for i in 0 ... k - 2 {
            c.add(comb: Comb(left: Way(type: leftType, len: 2 * i + leftFrom),
                             right: Way(type: rightType, len: 2 * (k - i - 1) - leftFrom),
                             label: ""))
        }
        if !PathAlg.isTex { c.updateLabel() }
        /*c.label = nil
        c.updateLabel()
        OutputFile.writeLog(.normal, "$$" + label + "=" + c.label! + "$$")
        c.label = label*/
        ll.flatMap { OutputFile.writeLog(.normal, "$$" + $0 + "=" + label + "$$") }
        matrix.rows[row][col].add(comb: c)
    }

    private func shiftTEven() {
        if shiftDeg > 2 {
            for i in 3 ... shiftDeg {
                matrix.rows[i][i].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
            }
        }
        for i in 0 ... shiftDeg {
            matrix.rows[i][i + 2].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        matrix.rows[0][0].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        if shiftDeg == 0 { return }
        matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
        matrix.rows[1][0].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
        matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
        matrix.rows[2][2].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        matrix.rows[2][2].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
        let n = shiftDeg / 2
        for i in 0 ... n {
            if hasKoef(n: n + 1, k: i + 1) {
                matrix.rows[2][2 * i + 1].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
                matrix.rows[1][2 * i + 2].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
            }
        }
    }

    private func shiftTOdd() {
        if shiftDeg > 1 {
        for i in 2 ... shiftDeg {
            matrix.rows[i][i].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        }
        for i in 0 ... shiftDeg {
            matrix.rows[i][i + 2].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        matrix.rows[0][0].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        matrix.rows[0][0].add(comb: Comb(left: Way.wy, right: Way.wy, label: ""))
        addT0(row: 0, col: 0, leftType: .y, leftFrom: 1, label: "M_1")
        matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.e, label: ""))
        addT0(row: 1, col: 0, leftType: .y, leftFrom: 0, label: "M_3")
        matrix.rows[0][1].add(comb: Comb(left: Way.wx, right: Way.e, label: ""))
        addT0(row: 0, col: 1, leftType: .x, leftFrom: 0, label: "M_2")
        matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.wx, label: ""))
        addT0(row: 1, col: 1, leftType: .x, leftFrom: 1, label: "M_4")
        let n = shiftDeg / 2
        for i in 0 ... n {
            if hasKoef(n: n + 1, k: i + 1) {
                matrix.rows[1][2 * i + 2].add(comb: Comb(left: Way.e, right: Way.wx, label: ""))
                matrix.rows[0][2 * i + 3].add(comb: Comb(left: Way.e, right: Way.wy, label: ""))
            }
        }
    }
}

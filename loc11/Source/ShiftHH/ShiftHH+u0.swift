//
//  Created by M on 29.05.2022.
//

import Foundation

extension ShiftHH {
    func shiftU0(_ label: String) -> Bool {
        if shiftDeg > 1 { return false }
        switch label {
        case "u1":
            shiftDeg % 2 == 0 ? shiftU1Even() : shiftU1Odd()
            return true
        case "u2":
            shiftDeg % 2 == 0 ? shiftU2Even() : shiftU2Odd()
            return true
        case "u1'":
            shiftDeg % 2 == 0 ? shiftU5Even() : shiftU5Odd()
            return true
        case "u3":
            shiftDeg % 2 == 0 ? shiftU3Even() : shiftU3Odd()
            return true
        case "u4":
            shiftDeg % 2 == 0 ? shiftU4Even() : shiftU4Odd()
            return true
        default: return false
        }
    }

    private func addU0(row: Int, col: Int, leftType: ArrType) {
        let k = PathAlg.kk
        let label = "\\sum\\limits_{i=0}^{k-1}(" + leftType.str + leftType.next.str + ")^i\\otimes "
        + leftType.next.str + "(" + leftType.str + leftType.next.str + ")^{k-i-1}"
        let c = Comb(label: "M_"+leftType.str+"^\\prime")
        for i in 0 ... k - 1 {
            c.add(comb: Comb(left: Way(type: leftType, len: 2 * i),
                                                 right: Way(type: leftType.next, len: 2 * (k - i) - 1),
                                                 label: ""))
        }
        OutputFile.writeLog(.normal, "$$" + c.label! + "=" + label + "$$")
        matrix.rows[row][col].add(comb: c)
    }
    
    // MARK: - u1
    private func shiftU1Even() {
        matrix.rows[0][0].add(comb: Comb.xe)
    }

    private func shiftU1Odd() {
        matrix.rows[0][0].add(comb: Comb(comb: mx01,
                                         compRight: SearchForMult.delta(way: Way.y),
                                         updateLabel: true))
        matrix.rows[0][1].add(comb: Comb.ex)
        matrix.rows[0][1].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .l))
        matrix.rows[1][1].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .r))
        matrix.rows[0][2].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .r))
        matrix.rows[1][2].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .l))
        matrix.rows[1][0].add(comb: Comb(comb: my02,
                                         compRight: SearchForMult.delta(way: Way.xyx),
                                         updateLabel: true))
    }

    // MARK: - u2
    private func shiftU2Even() {
        matrix.rows[0][0].add(comb: Comb.xe)
        matrix.rows[0][1].add(comb: Comb.ye)
    }

    private func shiftU2Odd() {
        addU0(row: 0, col: 0, leftType: .x)
        addU0(row: 1, col: 0, leftType: .y)
        add(row: 0, col: 1, comb: Comb.ex)
        addU0(row: 1, col: 1, leftType: .y)
        addU0(row: 0, col: 2, leftType: .x)
    }

    // MARK: - u3
    private func shiftU3Even() {
        matrix.rows[0][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
    }

    private func shiftU3Odd() {
        for i in 0 ... shiftDeg / 2 {
            matrix.rows[2 * i][2 * i + 1].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
        }
        for j in jj(with: 0) + [0,2] {
            matrix.rows[1][j].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
        }
    }

    // MARK: - u4
    private func shiftU4Even() {
        for i in 0 ... shiftDeg / 2 {
            matrix.rows[2 * i][2 * i + 1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
        }
    }

    private func shiftU4Odd() {
        for i in 0 ... shiftDeg / 2 {
            matrix.rows[2 * i + 1][2 * i + 2].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
        }
        for j in jj(with: 1) + [0,1] {
            matrix.rows[0][j].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
        }
    }

    // MARK: - u1'
    private func shiftU5Even() {
        matrix.rows[0][0].add(comb: Comb(left: Way.xyx, right: Way.e, label: ""))
    }

    private func shiftU5Odd() {
        matrix.rows[0][0].add(comb: Comb(comb: mx22,
                                         compRight: SearchForMult.delta(way: Way.y),
                                         updateLabel: true))
        matrix.rows[1][0].add(comb: m(j1: 2, j2: 2, leftType: .y, tMode: .r))
        matrix.rows[1][0].add(comb: m(j1: 1, j2: 1, leftType: .y, tMode: .l))
        matrix.rows[0][1].add(comb: Comb(left: Way.xyx, right: Way.e, label: ""))
        matrix.rows[0][1].add(comb: m(j1: 2, j2: 2, leftType: .x, tMode: .l))
        matrix.rows[1][1].add(comb: m(j1: 2, j2: 2, leftType: .y, tMode: .r))
        matrix.rows[0][2].add(comb: m(j1: 2, j2: 2, leftType: .x, tMode: .r))
        matrix.rows[1][2].add(comb: m(j1: 1, j2: 1, leftType: .y, tMode: .l))
    }
}

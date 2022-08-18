//
//  Created by M on 08.06.2022.
//

import Foundation

extension ShiftHH {
    func shiftV0(_ label: String) -> Bool {
        switch label {
        case "v1":
            shiftDeg % 2 == 0 ? shiftV1Even() : shiftV1Odd()
            return true
        case "v2":
            shiftDeg % 2 == 0 ? shiftV2Even() : shiftV2Odd()
            return true
        case "v3":
            if shiftDeg < 3 {
                shiftDeg % 2 == 0 ? shiftV3Even() : shiftV3Odd()
            }
            return true
        case "v4":
            if shiftDeg < 3 {
                shiftDeg % 2 == 0 ? shiftV4Even() : shiftV4Odd()
            }
            return true
        case "v5":
            if shiftDeg < 3 {
                shiftDeg % 2 == 0 ? shiftV5Even() : shiftV5Odd()
            }
            return true
        case "v6":
            if shiftDeg < 3 {
                shiftDeg % 2 == 0 ? shiftV6Even() : shiftV6Odd()
            }
            return true
        default:
            return false
        }
    }

    // MARK: - v1
    private func shiftV1Even() {
        matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        if shiftDeg == 0 { return }
        let n = shiftDeg / 2
        for i in 1 ... n {
            matrix.rows[2*i-1][2*i+1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
        matrix.rows[2][2].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
        for i in 1 ... n {
            if hasKoef(n: n, k: i) {
                matrix.rows[2][2*i-1].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
            }
        }
    }

    private func shiftV1Odd() {
        let n = (shiftDeg - 1) / 2
        for i in 0 ... n {
            matrix.rows[2*i][2*(i+1)].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        addT0(row: 0, col: 0, leftType: .y, leftFrom: 1, label: "M_1")
        addT0(row: 1, col: 0, leftType: .y, leftFrom: 2, label: "M_2")
        matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.wx, label: ""))
        matrix.rows[1][0].add(comb: Comb(left: Way.e, right: Way.wx, label: ""))
        if n == 0 { return }
        for i in 1 ... n {
            if hasKoef(n: n, k: i) {
                matrix.rows[1][2*i].add(comb: Comb(left: Way.e, right: Way.wx, label: ""))
            }
        }
    }

    // MARK: - v2
    private func shiftV2Even() {
        let n = shiftDeg / 2
        for i in 0 ... n {
            matrix.rows[2*i][2*(i+1)].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        if shiftDeg == 0 { return }
        matrix.rows[1][0].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
        matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
        for i in 1 ... n {
            if hasKoef(n: n, k: i) {
                matrix.rows[1][2*i].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
            }
        }
    }

    private func shiftV2Odd() {
        let n = (shiftDeg - 1) / 2
        for i in 0 ... n {
            matrix.rows[2*i+1][2*i+3].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        matrix.rows[0][0].add(comb: Comb(left: Way.wy, right: Way.wy, label: ""))
        addT0(row: 0, col: 1, leftType: .x, leftFrom: 2, label: "M_1")
        addT0(row: 1, col: 1, leftType: .x, leftFrom: 1, label: "M_2")
        matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.wy, label: ""))
        if n == 0 { return }
        for i in 1 ... n {
            if hasKoef(n: n, k: i) {
                matrix.rows[0][2*i+1].add(comb: Comb(left: Way.e, right: Way.wy, label: ""))
            }
        }
    }

    // MARK: - v3
    private func shiftV3Even() {
        matrix.rows[0][1].add(comb: Comb.xe)
        if shiftDeg == 0 { return }
        for i in 0 ... shiftDeg / 2 - 1 {
            matrix.rows[2*i+1][2*i+3].add(comb: Comb.xe)
        }
        if shiftDeg == 2 {
            matrix.rows[0][0].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[2][1].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            matrix.rows[2][3].add(comb: Comb.ex)
            matrix.rows[2][3].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
        }
    }

    private func shiftV3Odd() {
        matrix.rows[0][0].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
        matrix.rows[1][0].add(comb: SearchForMult.delta(way: Way.y))
        for i in 0 ... (shiftDeg - 1) / 2 {
            matrix.rows[2 * i][2 * (i + 1)].add(comb: Comb.xe)
        }
        matrix.rows[0][1].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
        matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
    }

    // MARK: - v4
    private func shiftV4Even() {
        for i in 0 ... shiftDeg / 2 {
            matrix.rows[2*i][2*(i+1)].add(comb: Comb.ye)
        }
        if shiftDeg == 0 { return }
        if shiftDeg == 2 {
            matrix.rows[0][0].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[1][2].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[1][2].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[1][4].add(comb: Comb.ey)
            matrix.rows[1][4].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
        }
    }

    private func shiftV4Odd() {
        for i in 0 ... (shiftDeg - 1) / 2 {
            matrix.rows[2*i+1][2*i+3].add(comb: Comb.ye)
        }
        matrix.rows[0][1].add(comb: SearchForMult.delta(way: Way.x))
        matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
        matrix.rows[0][0].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
        matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
    }

    // MARK: - v5
    private func shiftV5Even() {
        if shiftDeg == 0 {
            matrix.rows[0][0].add(comb: Comb(left: Way.xy, right: Way.e, label: ""))
            matrix.rows[0][0].add(comb: Comb(left: Way.yx, right: Way.e, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.xy, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.xy, right: Way.e, label: ""))
            return
        }
        matrix.rows[0][0].add(comb: Comb(left: Way.x, right: Way.y, label: ""))
        matrix.rows[0][0].add(comb: Comb(left: Way.y, right: Way.x, label: ""))
        matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
        matrix.rows[2][0].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
        if shiftDeg == 2 {
            matrix.rows[1][1].add(comb: Comb(left: Way.y, right: Way.zy, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.x, right: Way.zx, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.y, right: Way.zy, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.xy, right: Way.e, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.yx, right: Way.e, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: Comb(left: Way.x, right: Way.y, label: ""))
            matrix.rows[2][4].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
        }
    }

    private func shiftV5Odd() {
        if shiftDeg == 1 {
            matrix.rows[0][0].add(comb: Comb(left: Way.xy, right: Way.e, label: ""))
            matrix.rows[0][0].add(comb: Comb(left: Way.y, right: Way.x, label: ""))
            matrix.rows[0][0].add(comb: Comb(left: Way.y, right: Way.zy, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.yx, right: Way.wx, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.xy, right: Way.wx, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.xy, right: Way.wy, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.x, right: Way.zy, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.yx, right: Way.e, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.y, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.yx, right: Way.e, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.yx, right: Way.e, label: ""))
        }
    }

    // MARK: - v6
    private func shiftV6Even() {
        for i in 0 ... shiftDeg {
            matrix.rows[i][i].add(comb: Comb(left: Way.xx, right: Way.e, label: ""))
        }
    }

    private func shiftV6Odd() {
        for i in 0 ... shiftDeg {
            matrix.rows[i][i].add(comb: Comb(left: Way.xx, right: Way.e, label: ""))
            matrix.rows[i][i + 2].add(comb: Comb(left: Way.xx, right: Way.e, label: ""))
        }
    }
}

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

    private enum KVMode {
        case minus3, minus4
    }
    private func addV0(row: Int, col: Int, leftType: ArrType, leftFrom: Int, kMode: KVMode) {
        let k = PathAlg.kk
        let kTo: Int
        switch kMode {
        case .minus3: kTo = k - 3
        case .minus4: kTo = k - 4
        }
        if kTo < 0 { return }
        let rightType = leftFrom % 2 == 0 ? leftType : leftType.next
        for i in 0 ... kTo {
            matrix.rows[row][col].add(comb: Comb(left: Way(type: leftType, len: 2 * i + leftFrom),
                                                 right: Way(type: rightType, len: 2 * (k - i) - 1 - leftFrom),
                                                 label: ""))
        }
    }

    // MARK: - v1
    private func shiftV1Even() {
        if shiftDeg == 0 {
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
            return
        }
        matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        for i in 0 ... shiftDeg / 2 - 1 {
            matrix.rows[2*i+1][2*i+3].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        for j in jj(with: 0) + [0,2] {
            matrix.rows[2][j].add(comb: Comb(left: Way.wy, right: Way.wx, label: ""))
        }
    }

    private func shiftV1Odd() {
        for i in 0 ... (shiftDeg - 1) / 2 {
            matrix.rows[2*i][2*(i+1)].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        addT0(row: 0, col: 0, leftType: .y, leftFrom: 1)
        addT0(row: 1, col: 0, leftType: .y, leftFrom: 2)
        matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.wx, label: ""))
        for j in jj(with: 1) + [0] {
            matrix.rows[1][j].add(comb: Comb(left: Way.e, right: Way.wx, label: ""))
        }
    }

    // MARK: - v2
    private func shiftV2Even() {
        matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        if shiftDeg == 0 { return }
        for i in 1 ... shiftDeg / 2 {
            matrix.rows[2*i][2*i+2].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        for j in jj(with: 1) + [0,1] {
            matrix.rows[1][j].add(comb: Comb(left: Way.wx, right: Way.wy, label: ""))
        }
    }

    private func shiftV2Odd() {
        for i in 0 ... (shiftDeg - 1) / 2 {
            matrix.rows[2*i+1][2*i+3].add(comb: Comb(left: Way.e, right: Way.e, label: ""))
        }
        matrix.rows[0][0].add(comb: Comb(left: Way.wy, right: Way.wy, label: ""))
        addT0(row: 0, col: 1, leftType: .x, leftFrom: 2)
        addT0(row: 1, col: 1, leftType: .x, leftFrom: 1)
        for j in jj(with: 2) + [1] {
            matrix.rows[0][j].add(comb: Comb(left: Way.e, right: Way.wy, label: ""))
        }
    }

    // MARK: - v3
    private func shiftV3Even() {
        let k = PathAlg.kk
        matrix.rows[0][1].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
        if shiftDeg == 0 { return }
        for i in 0 ... shiftDeg / 2 - 1 {
            matrix.rows[2*i+1][2*i+3].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
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
            matrix.rows[2][3].add(comb: SearchForMult.ex)
            matrix.rows[2][3].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
        }
        if shiftDeg == 4 {
            matrix.rows[2][0].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            if k == 2 {
                matrix.rows[1][1].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
                matrix.rows[2][1].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
                matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            }
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[2][1].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            if k == 2 {
                matrix.rows[0][2].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            }
            matrix.rows[2][2].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            if k == 2 {
                matrix.rows[2][3].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
                matrix.rows[2][3].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
                matrix.rows[4][3].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            } else {
                matrix.rows[0][3].add(comb: SearchForMult.delta(way: Way.x))
            }
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[2][3].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            matrix.rows[0][4].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            if k > 2 {
                matrix.rows[1][4].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            }
            addV0(row: 1, col: 4, leftType: .y, leftFrom: 3, kMode: .minus4)
            matrix.rows[2][4].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            matrix.rows[2][4].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
            matrix.rows[4][4].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            if k == 2 {
                matrix.rows[1][5].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            } else {
                matrix.rows[0][5].add(comb: SearchForMult.ex)
            }
            matrix.rows[2][5].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            matrix.rows[2][5].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[0][6].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            if k == 2 {
                matrix.rows[0][6].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            }
            matrix.rows[2][6].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
        }
    }

    private func shiftV3Odd() {
        let k = PathAlg.kk
        matrix.rows[0][0].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
        matrix.rows[1][0].add(comb: SearchForMult.delta(way: Way.y))
        for i in 0 ... (shiftDeg - 1) / 2 {
            matrix.rows[2 * i][2 * (i + 1)].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
        }
        if shiftDeg == 1 {
            matrix.rows[0][1].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
        }
        if shiftDeg == 3 {
            if k == 2 {
                matrix.rows[0][0].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            }
            addU0(row: 0, col: 0, leftType: .y, leftFrom: 3, kMode: .minus3)
            addU0(row: 1, col: 0, leftType: .y, leftFrom: 2, kMode: .minus3)
            matrix.rows[1][0].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[3][0].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[3][0].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[3][1].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[3][1].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            if k == 2 {
                matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
                matrix.rows[0][2].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
                matrix.rows[3][2].add(comb: Comb(left: Way.y, right: Way.xx, label: ""))
            } else {
                matrix.rows[0][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
                matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            }
            matrix.rows[1][2].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[3][2].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[3][2].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            addU0(row: 0, col: 3, leftType: .x, leftFrom: 3, kMode: .minus3)
            matrix.rows[0][3].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[3][3].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[3][3].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
        }
    }

    // MARK: - v4
    private func shiftV4Even() {
        let k = PathAlg.kk
        for i in 0 ... shiftDeg / 2 {
            matrix.rows[2*i][2*(i+1)].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
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
            matrix.rows[1][4].add(comb: SearchForMult.ey)
            matrix.rows[1][4].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
        }
        if shiftDeg == 4 {
            matrix.rows[1][0].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            if k == 2 {
                matrix.rows[1][0].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
                matrix.rows[3][0].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
                matrix.rows[3][0].add(comb: Comb(left: Way.xx, right: Way.y, label: ""))
                matrix.rows[3][0].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            } else {
                matrix.rows[1][0].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
                matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
                matrix.rows[1][0].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
                matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            }
            matrix.rows[3][1].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            if k == 2 {
                matrix.rows[0][1].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
                matrix.rows[1][1].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
                matrix.rows[3][1].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
            } else {
                matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
                matrix.rows[1][1].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            }
            matrix.rows[1][2].add(comb: SearchForMult.delta(way: Way.y))
            if k == 2 {
                matrix.rows[1][2].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
                matrix.rows[3][2].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
                matrix.rows[3][2].add(comb: Comb(left: Way.xx, right: Way.y, label: ""))
                matrix.rows[3][2].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            } else {
                matrix.rows[1][2].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
                matrix.rows[1][2].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            }
            matrix.rows[1][3].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            if k == 2 {
                matrix.rows[0][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
                matrix.rows[0][3].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
                matrix.rows[2][3].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
                matrix.rows[3][3].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
                matrix.rows[3][3].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
            } else {
                matrix.rows[0][3].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            }
            matrix.rows[1][4].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            if k == 2 {
                matrix.rows[1][4].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
                matrix.rows[1][4].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
                matrix.rows[1][4].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            } else {
                matrix.rows[0][4].add(comb: SearchForMult.delta(way: Way.y))
                matrix.rows[1][4].add(comb: SearchForMult.delta(way: Way.y))
                matrix.rows[1][4].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            }
            matrix.rows[1][5].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            if k == 2 {
                matrix.rows[0][5].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
                matrix.rows[1][5].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
                matrix.rows[3][5].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
            } else {
                matrix.rows[0][5].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            }
            matrix.rows[1][6].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            if k == 2 {
                matrix.rows[1][6].add(comb: Comb(left: Way.e, right: Way.y, label: ""))
                matrix.rows[1][6].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
                matrix.rows[3][6].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
                matrix.rows[3][6].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            } else {
                matrix.rows[0][6].add(comb: Comb(left: Way.e, right: Way.y, label: ""))
                matrix.rows[1][6].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            }
        }
    }

    private func shiftV4Odd() {
        let k = PathAlg.kk
        for i in 0 ... (shiftDeg - 1) / 2 {
            matrix.rows[2*i+1][2*i+3].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        }
        matrix.rows[0][1].add(comb: SearchForMult.delta(way: Way.x))
        matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
        if shiftDeg == 1 {
            matrix.rows[0][0].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
        }
        if shiftDeg == 3 {
            matrix.rows[0][0].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
            if k == 2 {
                matrix.rows[2][1].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            } else {
                matrix.rows[0][1].add(comb: Comb(left: Way.yx, right: Way(type: .y, len: 2*k-3), label: ""))
                matrix.rows[2][1].add(comb: Comb(left: Way(type: .y, len: 2*k-3), right: Way.xy, label: ""))
            }
            addU0(row: 0, col: 1, leftType: .x, leftFrom: 2, kMode: .minus3)
            addU0(row: 1, col: 1, leftType: .x, leftFrom: 3, kMode: .minus3)
            matrix.rows[0][2].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            if k == 2 {
                matrix.rows[1][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
                matrix.rows[3][2].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            } else {
                matrix.rows[1][2].add(comb: Comb(left: Way.zx, right: Way.wy, label: ""))
            }
            matrix.rows[1][2].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            if k == 2 {
                matrix.rows[1][3].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
                matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.zy))
                matrix.rows[2][3].add(comb: Comb(left: Way.x, right: Way.xx, label: ""))
            } else {
                matrix.rows[0][3].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
                matrix.rows[0][3].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
                matrix.rows[0][3].add(comb: SearchForMult.delta(way: Way.x))
                matrix.rows[1][3].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            }
            matrix.rows[2][5].add(comb: Comb(left: Way(type: .y, len: 2*k-3), right: Way.xy, label: ""))
        }
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
        if shiftDeg == 4 {
            matrix.rows[1][0].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.y, right: Way.x, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.wy, right: Way.xx, label: ""))
            matrix.rows[3][1].add(comb: Comb(left: Way.xx, right: Way.wy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.x, right: Way.y, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.wx, right: Way.xx, label: ""))
            matrix.rows[4][2].add(comb: Comb(left: Way.xx, right: Way.wx, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.y, right: Way.x, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
            matrix.rows[0][4].add(comb: Comb(left: Way.x, right: Way.y, label: ""))
            matrix.rows[1][4].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[2][4].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[0][5].add(comb: Comb(left: Way.y, right: Way.x, label: ""))
            matrix.rows[1][5].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
            matrix.rows[3][5].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[0][6].add(comb: Comb(left: Way.x, right: Way.y, label: ""))
            matrix.rows[2][6].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[4][6].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
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
        if shiftDeg == 3 {
            matrix.rows[1][0].add(comb: Comb(left: Way.x, right: Way.x, label: ""))
            matrix.rows[1][0].add(comb: SearchForMult.delta(way: Way.xx))
            matrix.rows[2][0].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.y, right: Way.y, label: ""))
            matrix.rows[0][1].add(comb: SearchForMult.delta(way: Way.xx))
            matrix.rows[3][1].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.y, right: Way.zy, label: ""))
            matrix.rows[3][2].add(comb: Comb(left: Way.zx, right: Way.zx, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.x, right: Way.zx, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.zy, right: Way.zy, label: ""))
            matrix.rows[1][4].add(comb: Comb(left: Way.x, right: Way.x, label: ""))
            matrix.rows[2][4].add(comb: Comb(left: Way.xy, right: Way.e, label: ""))
            matrix.rows[2][4].add(comb: Comb(left: Way.y, right: Way.x, label: ""))
            matrix.rows[2][4].add(comb: Comb(left: Way.zy, right: Way.zx, label: ""))
            matrix.rows[0][5].add(comb: Comb(left: Way.y, right: Way.y, label: ""))
            matrix.rows[3][5].add(comb: Comb(left: Way.zx, right: Way.zy, label: ""))
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

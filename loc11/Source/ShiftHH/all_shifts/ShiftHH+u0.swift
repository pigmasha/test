//
//  Created by M on 29.05.2022.
//

import Foundation

extension ShiftHH {
    func shiftU0(_ label: String) -> Bool {
        if shiftDeg > 1 { return false }
        switch label {
        case "u1":
            if shiftDeg < 5 {
                shiftDeg % 2 == 0 ? shiftU1Even() : shiftU1Odd1()
            }
            return true
        case "u2":
            if shiftDeg < 5 {
                shiftDeg % 2 == 0 ? shiftU2Even() : shiftU2Odd()
            }
            return true
        case "u1'":
            if shiftDeg < 5 {
                shiftDeg % 2 == 0 ? shiftU5Even() : shiftU5Odd()
            }
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

    enum KUMode {
        case minus1, minus2, minus3
    }
    func addU0(row: Int, col: Int, leftType: ArrType, leftFrom: Int, kMode: KUMode = .minus1) {
        let k = PathAlg.kk
        let kTo: Int
        switch kMode {
        case .minus1: kTo = k - 1
        case .minus2: kTo = k - 2
        case .minus3: kTo = k - 3
        }
        if kTo < 0 { return }
        let rightType = leftFrom % 2 == 0 ? leftType.next : leftType
        for i in 0 ... kTo {
            matrix.rows[row][col].add(comb: Comb(left: Way(type: leftType, len: 2 * i + leftFrom),
                                                 right: Way(type: rightType, len: 2 * (k - i) - 1 - leftFrom),
                                                 label: ""))
        }
    }
    
    // MARK: - u1
    private func shiftU1Even() {
        matrix.rows[0][0].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
        if shiftDeg == 2 {
            matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][1].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[0][2].add(comb: SearchForMult.ex)
            matrix.rows[1][2].add(comb: SearchForMult.ex)
            matrix.rows[0][3].add(comb: SearchForMult.ey)
        }
        if shiftDeg == 4 {
            matrix.rows[1][0].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.zx))
            matrix.rows[1][2].add(comb: SearchForMult.ex)
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[3][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][4].add(comb: SearchForMult.ex)
            matrix.rows[3][4].add(comb: SearchForMult.ex)
            matrix.rows[0][5].add(comb: SearchForMult.ey)
        }
    }

    private func shiftU1Odd1() {
        let x1 = w01(leftType: .x, leftFrom: 0, rightMode: .minus1, label: "X_1")!
        let x2 = w01(leftType: .x, leftFrom: 0, rightMode: .minus2, label: "X_2")!
        let x3 = w01(leftType: .y, leftFrom: 0, rightMode: .minus1, label: "Y_1")!
        let x4 = w01(leftType: .y, leftFrom: 0, rightMode: .minus2, label: "Y_2")!
        matrix.rows[0][0].add(comb: Comb(comb: x1,
                                         compRight: SearchForMult.delta(way: Way.y),
                                         updateLabel: true))
        matrix.rows[0][1].add(comb: SearchForMult.ex)
        matrix.rows[0][1].add(comb: Comb(comb: x1,
                                         compRight: Comb(left: Way.y, right: Way.e, label: ""),
                                         updateLabel: true))
        matrix.rows[1][1].add(comb: Comb(comb: x3,
                                         compRight: SearchForMult.ex,
                                         updateLabel: true))
        matrix.rows[0][2].add(comb: Comb(comb: x2,
                                         compRight: Comb(left: Way.xy, right: Way.y, label: ""),
                                         updateLabel: true))
        matrix.rows[1][2].add(comb: Comb(comb: x3,
                                         compRight: Comb(left: Way.x, right: Way.e, label: ""),
                                         updateLabel: true))
        matrix.rows[1][0].add(comb: Comb(comb: x4,
                                         compRight: SearchForMult.delta(way: Way.xyx),
                                         updateLabel: true))
    }

    private func shiftU1Odd() {
        let x1 = w01(leftType: .x, leftFrom: 0, rightMode: .minus1, label: "X_1")!
        let x2 = w01(leftType: .x, leftFrom: 0, rightMode: .minus2, label: "X_2")!
        let x3 = w01(leftType: .y, leftFrom: 0, rightMode: .minus1, label: "Y_1")!
        let x4 = w01(leftType: .y, leftFrom: 0, rightMode: .minus2, label: "Y_2")!
        if shiftDeg % 4 == 1 {
            //addW0(row: 0, col: 0, leftType: .x, leftFrom: 0)
            //addW0(row: 0, col: 0, leftType: .y, leftFrom: 1)
            matrix.rows[0][0].add(comb: Comb(comb: x1,
                                             compRight: SearchForMult.delta(way: Way.y),
                                             updateLabel: true))
            matrix.rows[0][1].add(comb: SearchForMult.ex)
            matrix.rows[0][1].add(comb: Comb(comb: x1,
                                             compRight: Comb(left: Way.y, right: Way.e, label: ""),
                                             updateLabel: true))
            //addW0(row: 0, col: 1, leftType: .y, leftFrom: 1)
            matrix.rows[1][1].add(comb: Comb(comb: x3,
                                             compRight: SearchForMult.ex,
                                             updateLabel: true))
            //addW0(row: 1, col: 1, leftType: .y, leftFrom: 0)
            matrix.rows[0][2].add(comb: Comb(comb: x2,
                                             compRight: Comb(left: Way.xy, right: Way.y, label: ""),
                                             updateLabel: true))
            //addW0(row: 0, col: 2, leftType: .x, leftFrom: 2)
            matrix.rows[1][2].add(comb: Comb(comb: x3,
                                             compRight: Comb(left: Way.x, right: Way.e, label: ""),
                                             updateLabel: true))
            //addW0(row: 1, col: 2, leftType: .x, leftFrom: 1)
        } else {
            addW0(row: 0, col: 0, leftType: .x, leftFrom: 2)
            addW0(row: 0, col: 0, leftType: .y, leftFrom: 3)
        }
        matrix.rows[1][0].add(comb: Comb(comb: x4, compRight: SearchForMult.delta(way: Way.xyx), updateLabel: true))
        //addW0(row: 1, col: 0, leftType: .y, leftFrom: 0)
        //addW0(row: 1, col: 0, leftType: .x, leftFrom: 3)
        if shiftDeg == 3 {
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.x, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 3, kMode: .minus2)
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 4, kMode: .minus2)
            matrix.rows[2][3].add(comb: SearchForMult.ex)
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 4, kMode: .minus2)
            matrix.rows[1][4].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 5, kMode: .minus2)
        }
    }

    // MARK: - u2
    private func shiftU2Even() {
        if shiftDeg == 0 {
            matrix.rows[0][0].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        }
        if shiftDeg == 2 {
            matrix.rows[0][0].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[0][0].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        }
        if shiftDeg == 4 {
            matrix.rows[0][0].add(comb: SearchForMult.ex)
            matrix.rows[1][0].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: SearchForMult.ex)
            matrix.rows[2][2].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            matrix.rows[3][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[2][3].add(comb: SearchForMult.ey)
            matrix.rows[2][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[4][3].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][4].add(comb: SearchForMult.ex)
            matrix.rows[3][4].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[4][5].add(comb: SearchForMult.ey)
        }
    }

    private func shiftU2Odd() {
        addU0(row: 0, col: 0, leftType: .x, leftFrom: 0)
        addU0(row: 1, col: 0, leftType: .y, leftFrom: 0)
        if shiftDeg == 1 {
            add(row: 0, col: 1, comb: SearchForMult.ex)
            addU0(row: 1, col: 1, leftType: .y, leftFrom: 0)
            addU0(row: 0, col: 2, leftType: .x, leftFrom: 0)
        }
        if shiftDeg == 3 {
            matrix.rows[0][1].add(comb: SearchForMult.ex)
            matrix.rows[0][1].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[1][2].add(comb: SearchForMult.ey)
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[3][2].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            addU0(row: 1, col: 3, leftType: .y, leftFrom: 2, kMode: .minus3)
            matrix.rows[2][3].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            addU0(row: 1, col: 4, leftType: .x, leftFrom: 1, kMode: .minus2)
            matrix.rows[3][4].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[3][4].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        }
    }

    // MARK: - u3
    private func shiftU3Even() {
        matrix.rows[0][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
        if shiftDeg == 0 { return }
        for i in 1 ... shiftDeg / 2 {
            matrix.rows[2 * i - 1][2 * i].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
        }
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

    // MARK: - u5
    func addU1(row: Int, col: Int, leftType: ArrType, leftFrom: Int, kMode: KWMode = .minus1) {
        let k = PathAlg.kk
        if kMode == .minus2 && k < 4 { return }
        let kTo: Int
        switch kMode {
        case .minus1: kTo = k / 2 - 1
        case .minus2: kTo = k / 2 - 2
        case .zero: kTo = k / 2
        }
        let rightType = leftFrom % 2 == 0 ? leftType.next : leftType
        for i in 0 ... kTo {
            matrix.rows[row][col].add(comb: Comb(left: Way(type: leftType, len: 4 * i + leftFrom),
                                                 right: Way(type: rightType, len: 2 * (k - 2 * i) + 1 - leftFrom),
                                                 label: ""))
        }
    }

    func addU2(row: Int, col: Int, leftType: ArrType, leftFrom: Int, kMode: KWMode = .minus1) {
        let k = PathAlg.kk
        if kMode == .minus2 && k < 4 { return }
        let kTo: Int
        switch kMode {
        case .minus1: kTo = k - 3
        case .minus2: kTo = k - 4
        case .zero: kTo = k
        }
        let rightType = leftFrom % 2 == 0 ? leftType.next : leftType
        for i in 0 ... kTo {
            matrix.rows[row][col].add(comb: Comb(left: Way(type: leftType, len: 2 * i + leftFrom),
                                                 right: Way(type: rightType, len: 2 * (k - i) + 1 - leftFrom),
                                                 label: ""))
        }
    }

    private func shiftU5Even() {
        matrix.rows[0][0].add(comb: Comb(left: Way.xyx, right: Way.e, label: ""))
        if shiftDeg == 0 { return }
        for i in 1 ... shiftDeg / 2 {
            matrix.rows[2*i-1][2*i].add(comb: Comb(left: Way.xyx, right: Way.e, label: ""))
        }
        if shiftDeg == 2 {
            matrix.rows[0][1].add(comb: Comb(left: Way.wx, right:  Way.xyx, label: ""))
        }
        if shiftDeg == 4 {
            matrix.rows[1][2].add(comb: Comb(left: Way.xyx, right: Way.wy, label: ""))
            matrix.rows[1][4].add(comb: Comb(left: Way.xyx, right: Way.wy, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.wx, right: Way.xyx, label: ""))
        }
    }

    private func shiftU5Odd() {
        addU1(row: 0, col: 0, leftType: .x, leftFrom: 4)
        addU1(row: 0, col: 0, leftType: .y, leftFrom: 5)
        addU1(row: 1, col: 0, leftType: .y, leftFrom: 4)
        addU1(row: 1, col: 0, leftType: .x, leftFrom: 3)
        matrix.rows[0][1].add(comb: Comb(left: Way.xyx, right: Way.e, label: ""))
        if shiftDeg == 1 {
            addU1(row: 0, col: 1, leftType: .y, leftFrom: 5)
            addU1(row: 1, col: 1, leftType: .y, leftFrom: 4)
            addU1(row: 0, col: 2, leftType: .x, leftFrom: 4)
            addU1(row: 1, col: 2, leftType: .x, leftFrom: 3)
        }
        if shiftDeg == 3 {
            matrix.rows[0][1].add(comb: Comb(left: Way.xyx, right: Way.wx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.xyx, right: Way.wx, label: ""))
            addU2(row: 0, col: 2, leftType: .y, leftFrom: 5, kMode: .minus2)
            addU2(row: 0, col: 2, leftType: .x, leftFrom: 4, kMode: .minus2)
            addU2(row: 1, col: 2, leftType: .y, leftFrom: 4)
            addU2(row: 1, col: 2, leftType: .x, leftFrom: 3)
            addU1(row: 0, col: 3, leftType: .y, leftFrom: 5)
            addU1(row: 1, col: 3, leftType: .y, leftFrom: 4)
            matrix.rows[2][3].add(comb: Comb(left: Way.xyx, right: Way.e, label: ""))
            matrix.rows[0][4].add(comb: Comb(left: Way.wx, right: Way.yxy, label: ""))
            addU1(row: 0, col: 4, leftType: .x, leftFrom: 6, kMode: .minus2)
            addU1(row: 1, col: 4, leftType: .x, leftFrom: 5, kMode: .minus2)
        }
    }
}

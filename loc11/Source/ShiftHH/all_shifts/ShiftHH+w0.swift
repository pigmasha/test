//
//  Created by M on 11.06.2022.
//

import Foundation

extension ShiftHH {
    func shiftW0(_ label: String) -> Bool {
        if shiftDeg > 3 { return false }
        switch label {
        case "w1":
            if shiftDeg < 5 {
                shiftDeg % 2 == 0 ? shiftW1Even() : shiftW1Odd()
            }
            return true
        case "w2":
            if shiftDeg < 5 {
                shiftDeg % 2 == 0 ? shiftW2Even() : shiftW2Odd()
            }
            return true
        case "w1'":
            if shiftDeg < 5 {
                shiftDeg % 2 == 0 ? shiftW1iEven() : shiftW1iOdd()
            }
            return true
        case "w2'":
            if shiftDeg < 5 {
                shiftDeg % 2 == 0 ? shiftW2iEven() : shiftW2iOdd()
            }
            return true
        default:
            return false
        }
    }

    enum KWMode {
        case minus1, minus2, zero

        var val: Int {
            switch self {
            case .minus1: return -1
            case .minus2: return -2
            case .zero: return 0
            }
        }
    }

    func w0(leftType: ArrType, leftFrom: Int, kMode: KWMode = .minus1) -> Comb? {
        let k = PathAlg.kk
        if kMode == .minus2 && k < 4 { return nil }
        let kTo: Int
        switch kMode {
        case .minus1: kTo = k / 2 - 1
        case .minus2: kTo = k / 2 - 2
        case .zero: kTo = k / 2
        }
        let rightType = leftFrom % 2 == 0 ? leftType.next : leftType
        var label = "\\sum\\limits_{i=0}^{" + (k % 2 == 0 ? "k/2" : "(k-1)/2")
        switch kMode {
        case .minus1: label += "-1"
        case .minus2: label += "-2"
        case .zero: break
        }
        label += "}"
        if leftFrom % 2 == 0 {
            label += "(" + leftType.str + leftType.next.str + ")^{2i" + (leftFrom == 0 ? "" : "+\(leftFrom/2)") + "}"
        } else {
            label += leftType.str + "(" + leftType.next.str + leftType.str + ")^{2i" + (leftFrom == 1 ? "" : "+\(leftFrom/2)") + "}"
        }
        label += "\\otimes "
        if leftFrom % 2 == 1 {
            label += "(" + rightType.str + rightType.next.str + ")^{k-2i-\((leftFrom+1)/2)}"
        } else {
            label += rightType.str + "(" + rightType.next.str + rightType.str + ")^{k-2i-\((leftFrom+2)/2)}"
        }
        let c = PathAlg.isTex ? Comb(label: label) : Comb()
        for i in 0 ... kTo {
            c.add(comb: Comb(left: Way(type: leftType, len: 4 * i + leftFrom),
                             right: Way(type: rightType, len: 2 * (k - 2 * i) - 1 - leftFrom),
                             label: ""))
        }
        if !PathAlg.isTex { c.updateLabel() }
        return c
    }

    func w01(leftType: ArrType, leftFrom: Int, rightMode: KWMode, kMode: KWMode = .minus1, label ll: String? = nil) -> Comb? {
        let k = PathAlg.kk
        if kMode == .minus2 && k < 4 { return nil }
        let kTo = k / 2 + kMode.val
        let rightType = leftFrom % 2 == 0 ? leftType.next : leftType
        var label = "\\sum\\limits_{i=0}^{" + (k % 2 == 0 ? "k/2" : "(k-1)/2") + (kMode.val == 0 ? "" : "\(kMode.val)")
        label += "}"
        if leftFrom % 2 == 0 {
            label += "(" + leftType.str + leftType.next.str + ")^{2i" + (leftFrom == 0 ? "" : "+\(leftFrom/2)") + "}"
        } else {
            label += leftType.str + "(" + leftType.next.str + leftType.str + ")^{2i" + (leftFrom == 1 ? "" : "+\(leftFrom/2)") + "}"
        }
        label += "\\otimes "
        if leftFrom % 2 == 0 {
            label += "(" + rightType.str + rightType.next.str + ")^{k-2i-\(leftFrom/2-rightMode.val)}"
        } else {
            label += rightType.str + "(" + rightType.next.str + rightType.str + ")^{k-2i-\((leftFrom+1)/2-rightMode.val)}"
        }
        let c = PathAlg.isTex ? Comb(label: ll ?? label) : Comb()
        for i in 0 ... kTo {
            c.add(comb: Comb(left: Way(type: leftType, len: 4 * i + leftFrom),
                             right: Way(type: rightType, len: 2 * (k - 2 * i + rightMode.val) - leftFrom),
                             label: ""))
        }
        if !PathAlg.isTex { c.updateLabel() }
        if PathAlg.isTex, let ll = ll {
            OutputFile.writeLog(.normal, "$$"+ll+"="+label+"$$")
        }
        return c
    }

    func addW0(row: Int, col: Int, leftType: ArrType, leftFrom: Int, kMode: KWMode = .minus1) {
        w0(leftType: leftType, leftFrom: leftFrom, kMode: kMode).flatMap {
            matrix.rows[row][col].add(comb: $0)
        }
    }

    // MARK: - w1
    private func shiftW1Even() {
        switch shiftDeg {
        case 0:
            matrix.rows[0][0].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        case 2:
            matrix.rows[0][0].add(comb: SearchForMult.ex)
            matrix.rows[1][0].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: SearchForMult.ex)
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[0][4].add(comb: SearchForMult.ex)
            matrix.rows[1][4].add(comb: SearchForMult.ex)
        case 4:
            matrix.rows[0][0].add(comb: SearchForMult.ex)
            matrix.rows[1][0].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[3][1].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[3][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[1][4].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][4].add(comb: SearchForMult.ex)
            matrix.rows[3][4].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[3][4].add(comb: SearchForMult.ex)
            matrix.rows[0][5].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[1][6].add(comb: SearchForMult.ex)
            matrix.rows[3][6].add(comb: SearchForMult.ex)
        default:
            break
        }
    }

    private func shiftW1Odd() {
        addW0(row: 0, col: 0, leftType: .x, leftFrom: 0)
        addW0(row: 0, col: 0, leftType: .y, leftFrom: 1)
        matrix.rows[0][3].add(comb: SearchForMult.ex)
        switch shiftDeg {
        case 1:
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 0)
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 3)
            matrix.rows[0][1].add(comb: SearchForMult.ex)
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[1][2].add(comb: SearchForMult.delta(way: Way.y))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 1)
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 0)
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 4, kMode: .minus2)
            matrix.rows[1][4].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 3)
        case 3:
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 2)
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 1)
            addW0(row: 0, col: 1, leftType: .y, leftFrom: 3, kMode: .minus2)
            matrix.rows[1][1].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            addW0(row: 1, col: 1, leftType: .y, leftFrom: 0)
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.x))
            addW0(row: 0, col: 2, leftType: .x, leftFrom: 0)
            addW0(row: 1, col: 2, leftType: .x, leftFrom: 1)
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 3)
            matrix.rows[1][3].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 4, kMode: .minus2)
            matrix.rows[2][3].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[0][4].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 4, kMode: .minus2)
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 1)
            matrix.rows[0][5].add(comb: SearchForMult.ex)
            addW0(row: 0, col: 5, leftType: .y, leftFrom: 3, kMode: .minus2)
            addW0(row: 1, col: 5, leftType: .y, leftFrom: 4, kMode: .minus2)
            matrix.rows[2][5].add(comb: SearchForMult.ex)
            addW0(row: 0, col: 6, leftType: .x, leftFrom: 4, kMode: .minus2)
            addW0(row: 1, col: 6, leftType: .x, leftFrom: 1)
        default:
            break
        }
    }

    // MARK: - w2
    private func shiftW2Even() {
        switch shiftDeg {
        case 0:
            matrix.rows[0][1].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
        case 2:
            matrix.rows[1][0].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[0][1].add(comb: SearchForMult.ey)
            matrix.rows[2][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][2].add(comb: SearchForMult.ex)
            matrix.rows[1][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[2][2].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[2][2].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[2][3].add(comb: SearchForMult.ey)
            matrix.rows[2][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: SearchForMult.ex)
            matrix.rows[1][4].add(comb: SearchForMult.ex)
            matrix.rows[2][4].add(comb: SearchForMult.ex)
            matrix.rows[0][5].add(comb: SearchForMult.ey)
            matrix.rows[2][5].add(comb: SearchForMult.ey)
        case 4:
            matrix.rows[0][0].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[2][0].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[4][0].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[4][0].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[0][1].add(comb: SearchForMult.ey)
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[4][1].add(comb: SearchForMult.delta(way: Way.zx))
            matrix.rows[0][2].add(comb: SearchForMult.ex)
            matrix.rows[2][2].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[4][2].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[4][2].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[0][3].add(comb: SearchForMult.ey)
            matrix.rows[1][3].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
            matrix.rows[4][3].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[0][4].add(comb: SearchForMult.ex)
            matrix.rows[0][4].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][4].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[4][4].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[0][5].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][5].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
            matrix.rows[2][5].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[4][5].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[4][5].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[0][6].add(comb: SearchForMult.ex)
            matrix.rows[4][6].add(comb: SearchForMult.ex)
            matrix.rows[4][7].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        default:
            break
        }
    }

    private func shiftW2Odd() {
        switch shiftDeg {
        case 1:
            addW0(row: 0, col: 0, leftType: .x, leftFrom: 0)
            addW0(row: 0, col: 0, leftType: .y, leftFrom: 3)
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 0)
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 1)
            matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[1][1].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[1][2].add(comb: SearchForMult.ey)
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 3)
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 0)
            matrix.rows[1][4].add(comb: SearchForMult.ey)
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 1)
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 4, kMode: .minus2)
        case 3:
            addW0(row: 0, col: 0, leftType: .x, leftFrom: 0)
            addW0(row: 0, col: 0, leftType: .y, leftFrom: 3)
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 3)
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 2)
            addW0(row: 0, col: 1, leftType: .y, leftFrom: 3, kMode: .minus2)
            matrix.rows[1][1].add(comb: SearchForMult.ey)
            addW0(row: 1, col: 1, leftType: .y, leftFrom: 2, kMode: .minus2)
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[3][1].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[3][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[3][1].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[3][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            addW0(row: 0, col: 2, leftType: .x, leftFrom: 0)
            addW0(row: 1, col: 2, leftType: .x, leftFrom: 3, kMode: .minus2)
            matrix.rows[3][2].add(comb: SearchForMult.delta(way: Way.zx))
            matrix.rows[3][2].add(comb: SearchForMult.delta(way: Way.y))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 1)
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 0)
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[3][3].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[3][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 4, kMode: .minus2)
            matrix.rows[1][4].add(comb: SearchForMult.ey)
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 3)
            matrix.rows[3][4].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[3][4].add(comb: SearchForMult.delta(way: Way.zx))
            addW0(row: 0, col: 5, leftType: .y, leftFrom: 3, kMode: .minus2)
            addW0(row: 1, col: 5, leftType: .y, leftFrom: 2, kMode: .minus2)
            matrix.rows[2][5].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[2][5].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[3][5].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            addW0(row: 0, col: 6, leftType: .x, leftFrom: 4, kMode: .minus2)
            matrix.rows[1][6].add(comb: SearchForMult.ey)
            addW0(row: 1, col: 6, leftType: .x, leftFrom: 3, kMode: .minus2)
            matrix.rows[3][6].add(comb: SearchForMult.ey)
        default:
            break
        }
    }

    // MARK: - w1'
    private func shiftW1iEven() {
        matrix.rows[0][0].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
        matrix.rows[0][2].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
        switch shiftDeg {
        case 2:
            matrix.rows[0][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: SearchForMult.ex)
            matrix.rows[1][4].add(comb: SearchForMult.ex)
            matrix.rows[0][5].add(comb: SearchForMult.ey)
        case 4:
            matrix.rows[1][1].add(comb: Comb(left: Way.zy, right: Way.wy, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[4][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[1][4].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[3][4].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[3][4].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[0][5].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[2][5].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[2][5].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[3][6].add(comb: SearchForMult.ex)
            matrix.rows[4][7].add(comb: SearchForMult.ey)
        default:
            break
        }
    }

    private func shiftW1iOdd() {
        switch shiftDeg {
        case 1:
            addW0(row: 0, col: 0, leftType: .y, leftFrom: 3)
            addW0(row: 0, col: 0, leftType: .x, leftFrom: 2)
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 1, kMode: .zero)
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 2)
            matrix.rows[0][1].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 3)
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 2)
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 4)
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 3)
        case 3:
            matrix.rows[0][0].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            addW0(row: 0, col: 0, leftType: .x, leftFrom: 2)
            addW0(row: 0, col: 0, leftType: .y, leftFrom: 3)
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 1, kMode: .zero)
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 2)
            matrix.rows[0][1].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            matrix.rows[0][1].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            addW0(row: 0, col: 1, leftType: .y, leftFrom: 3)
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            addW0(row: 1, col: 1, leftType: .y, leftFrom: 2)
            addW0(row: 0, col: 2, leftType: .x, leftFrom: 2)
            addW0(row: 1, col: 2, leftType: .x, leftFrom: 1, kMode: .zero)
            matrix.rows[3][2].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 3)
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 2)
            matrix.rows[2][3].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[0][4].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 4, kMode: .minus2)
            matrix.rows[1][4].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 3)
            matrix.rows[3][4].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[0][5].add(comb: SearchForMult.ex)
            addW0(row: 0, col: 5, leftType: .y, leftFrom: 1)
            addW0(row: 1, col: 5, leftType: .y, leftFrom: 4)
            matrix.rows[0][6].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
            addW0(row: 0, col: 6, leftType: .x, leftFrom: 2)
            matrix.rows[1][6].add(comb: SearchForMult.ey)
            addW0(row: 1, col: 6, leftType: .x, leftFrom: 1)
        default:
            break
        }
    }

    // MARK: - w2'
    private func shiftW2iEven() {
        matrix.rows[0][1].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        matrix.rows[0][3].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
        switch shiftDeg {
        case 2:
            matrix.rows[0][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[0][4].add(comb: SearchForMult.ex)
            matrix.rows[0][5].add(comb: SearchForMult.ey)
            matrix.rows[2][5].add(comb: SearchForMult.ey)
        case 4:
            matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.zx, right: Way.wx, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[3][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[2][3].add(comb: SearchForMult.ey)
            matrix.rows[2][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[1][4].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            matrix.rows[1][4].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[2][5].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[4][5].add(comb: SearchForMult.ey)
            matrix.rows[4][5].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[3][6].add(comb: SearchForMult.ex)
        default:
            break
        }
    }

    private func shiftW2iOdd() {
        switch shiftDeg {
        case 1:
            addW0(row: 0, col: 0, leftType: .y, leftFrom: 1, kMode: .zero)
            addW0(row: 0, col: 0, leftType: .x, leftFrom: 2)
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 3)
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 2)
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 3)
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 4)
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 2)
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 3)
        case 3:
            addW0(row: 0, col: 0, leftType: .x, leftFrom: 2)
            addW0(row: 0, col: 0, leftType: .y, leftFrom: 1, kMode: .zero)
            matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            addW0(row: 1, col: 0, leftType: .x, leftFrom: 3)
            addW0(row: 1, col: 0, leftType: .y, leftFrom: 2)
            addW0(row: 0, col: 1, leftType: .y, leftFrom: 1, kMode: .zero)
            addW0(row: 1, col: 1, leftType: .y, leftFrom: 2)
            matrix.rows[2][1].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            addW0(row: 0, col: 2, leftType: .x, leftFrom: 2)
            matrix.rows[1][2].add(comb: Comb(left: Way.y, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            addW0(row: 1, col: 2, leftType: .x, leftFrom: 3)
            matrix.rows[0][3].add(comb: Comb(left: Way.x, right: Way.e, label: ""))
            addW0(row: 0, col: 3, leftType: .y, leftFrom: 3)
            matrix.rows[1][3].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][3].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            addW0(row: 1, col: 3, leftType: .y, leftFrom: 4, kMode: .minus2)
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.x))
            addW0(row: 0, col: 4, leftType: .x, leftFrom: 4)
            matrix.rows[1][4].add(comb: SearchForMult.ey)
            addW0(row: 1, col: 4, leftType: .x, leftFrom: 1)
            matrix.rows[3][4].add(comb: SearchForMult.ey)
            matrix.rows[3][4].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][5].add(comb: SearchForMult.ex)
            addW0(row: 0, col: 5, leftType: .y, leftFrom: 1)
            matrix.rows[1][5].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            addW0(row: 1, col: 5, leftType: .y, leftFrom: 2)
            addW0(row: 0, col: 6, leftType: .x, leftFrom: 4)
            matrix.rows[1][6].add(comb: SearchForMult.ey)
            addW0(row: 1, col: 6, leftType: .x, leftFrom: 1)
        default:
            break
        }
    }
}

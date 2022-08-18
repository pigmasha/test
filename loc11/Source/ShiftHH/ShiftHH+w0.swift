//
//  Created by M on 11.06.2022.
//

import Foundation

extension ShiftHH {
    func shiftW0(_ label: String) -> Bool {
        if shiftDeg > 3 { return false }
        switch label {
        case "w1":
            shiftDeg % 2 == 0 ? shiftW1Even() : shiftW1Odd()
            return true
        case "w2":
            shiftDeg % 2 == 0 ? shiftW2Even() : shiftW2Odd()
            return true
        case "w1'":
            shiftDeg % 2 == 0 ? shiftW1iEven() : shiftW1iOdd()
            return true
        case "w2'":
            shiftDeg % 2 == 0 ? shiftW2iEven() : shiftW2iOdd()
            return true
        default:
            return false
        }
    }

    var mx02: Comb { return m(j1: 0, j2: 2, leftType: .x) }
    var my02: Comb { return m(j1: 0, j2: 2, leftType: .y) }
    var mx12: Comb { return m(j1: 1, j2: 2, leftType: .x) }
    var my12: Comb { return m(j1: 1, j2: 2, leftType: .y) }
    var mx22: Comb { return m(j1: 2, j2: 2, leftType: .x) }
    var mx01: Comb { return m(j1: 0, j2: 1, leftType: .x) }
    var my01: Comb { return m(j1: 0, j2: 1, leftType: .y) }

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

    enum KTMode {
        case l, r
        var str: String {
            switch self {
            case .l: return "l"
            case .r: return "r"
            }
        }
    }

    func m(j1: Int, j2: Int, leftType: ArrType, kMode: KWMode = .minus1, tMode: KTMode? = nil) -> Comb {
        let k = PathAlg.kk
        let kTo = k / 2 + kMode.val
        if kTo < 0 { return Comb() }
        var label = "M_"
        if let tMode = tMode {
            label += "{" + leftType.str + "," + tMode.str + "}"
        } else {
            label += leftType.str
        }
        label += "^{(\(j1),\(j2)" + (kMode == .minus1 ? "" : ",\(-kMode.val)") + ")}"
        let c = PathAlg.isTex ? Comb(label: label) : Comb()
        for i in 0 ... kTo {
            c.add(comb: Comb(left: Way(type: leftType, len: 2 * (2*i + j1)),
                             right: Way(type: leftType.next, len: 2 * (k - 2 * i - j2)),
                             label: ""))
        }
        if !PathAlg.isTex { c.updateLabel() }
        if let tMode = tMode {
            let w = Way(type: leftType.next, len: 1)
            let c1: Comb
            switch tMode {
            case .l:
                c1 = Comb(comb: c, compRight: Comb(left: w, right: Way.e, label: ""))
            case .r:
                c1 = Comb(comb: c, compRight: Comb(left: Way.e, right: w, label: ""))
            }
            c1.label = label
            return c1
        } else {
            return c
        }
    }

    // MARK: - w1
    private func shiftW1Even() {
        switch shiftDeg {
        case 0:
            matrix.rows[0][0].add(comb: Comb.xe)
            matrix.rows[0][3].add(comb: Comb.ye)
        case 2:
            matrix.rows[0][0].add(comb: Comb.ex)
            matrix.rows[1][0].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.wx, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: Comb.ex)
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.x, right: Way.wy, label: ""))
            matrix.rows[0][4].add(comb: Comb.ex)
            matrix.rows[1][4].add(comb: Comb.ex)
        default:
            break
        }
    }

    private func shiftW1Odd() {
        matrix.rows[0][0].add(comb: Comb(comb: mx01, compRight: SearchForMult.delta(way: Way.y), updateLabel: true))
        matrix.rows[0][3].add(comb: Comb.ex)
        switch shiftDeg {
        case 1:
            matrix.rows[1][0].add(comb: Comb(comb: my02, compRight: SearchForMult.delta(way: Way.xyx), updateLabel: true))
            matrix.rows[0][1].add(comb: Comb.ex)
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[1][2].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[0][3].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .l))
            matrix.rows[1][3].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .r))
            matrix.rows[0][4].add(comb: m(j1: 2, j2: 3, leftType: .x, kMode: .minus2, tMode: .r))
            matrix.rows[1][4].add(comb: Comb.ye)
            matrix.rows[1][4].add(comb:m(j1: 1, j2: 2, leftType: .y, tMode: .l))
        case 3:
            let c1 = Comb(comb: my02,
                          compRight: Comb(left: Way.x, right: Way.x, label: ""),
                          updateLabel: true)
            matrix.rows[1][0].add(comb: Comb(comb: c1,
                                             compRight: SearchForMult.delta(way: Way.y),
                                             updateLabel: true))
            matrix.rows[0][1].add(comb: m(j1: 1, j2: 2, leftType: .x, kMode: .minus2, tMode: .l))
            matrix.rows[1][1].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            matrix.rows[1][1].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .r))
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[0][2].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .r))
            matrix.rows[1][2].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .l))
            matrix.rows[0][3].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .l))
            matrix.rows[1][3].add(comb: Comb(left: Way.zy, right: Way.wx, label: ""))
            matrix.rows[1][3].add(comb: m(j1: 2, j2: 3, leftType: .y, kMode: .minus2, tMode: .r))
            matrix.rows[2][3].add(comb: Comb.xe)
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[0][4].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[0][4].add(comb: m(j1: 2, j2: 3, leftType: .x, kMode: .minus2, tMode: .r))
            matrix.rows[1][4].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .l))
            matrix.rows[0][5].add(comb: Comb.ex)
            matrix.rows[0][5].add(comb: m(j1: 1, j2: 2, leftType: .x, kMode: .minus2, tMode: .l))
            matrix.rows[1][5].add(comb: m(j1: 2, j2: 3, leftType: .y, kMode: .minus2, tMode: .r))
            matrix.rows[2][5].add(comb: Comb.ex)
            matrix.rows[0][6].add(comb: m(j1: 2, j2: 3, leftType: .x, kMode: .minus2, tMode: .r))
            matrix.rows[1][6].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .l))
        default:
            break
        }
    }

    // MARK: - w2
    private func shiftW2Even() {
        switch shiftDeg {
        case 0:
            matrix.rows[0][1].add(comb: Comb.ye)
            matrix.rows[0][2].add(comb: Comb.xe)
        case 2:
            matrix.rows[1][0].add(comb: SearchForMult.delta(way: Way.zy))
            matrix.rows[2][0].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[2][0].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[0][1].add(comb: Comb.ey)
            matrix.rows[2][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][2].add(comb: Comb.ex)
            matrix.rows[1][2].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[2][2].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[2][2].add(comb: Comb(left: Way.y, right: Way.wx, label: ""))
            matrix.rows[2][2].add(comb: Comb(left: Way.wy, right: Way.zx, label: ""))
            matrix.rows[0][3].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[2][3].add(comb: Comb.ey)
            matrix.rows[2][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: Comb.ex)
            matrix.rows[1][4].add(comb: Comb.ex)
            matrix.rows[2][4].add(comb: Comb.ex)
            matrix.rows[0][5].add(comb: Comb.ey)
            matrix.rows[2][5].add(comb: Comb.ey)
        default:
            break
        }
    }

    private func addWithLabel(i: Int, j: Int, combs: [Comb]) {
        let c = Comb(label: "t_{\(i),\(j)}")
        combs.forEach { c.add(comb: $0) }
        matrix.rows[i][j].add(comb: c)
        c.label = nil
        OutputFile.writeLog(.normal, "$$t_{\(i),\(j)}="+c.str+"$$")
    }

    private func shiftW2Odd() {
        matrix.rows[0][0].add(comb: Comb(comb: mx02, compRight: SearchForMult.delta(way: Way.yxy), updateLabel: true))
        switch shiftDeg {
        case 1:
            matrix.rows[1][0].add(comb: Comb(comb: my01, compRight: SearchForMult.delta(way: Way.x), updateLabel: true))
            matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[1][1].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[1][2].add(comb: Comb.ey)
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][3].add(comb: Comb.xe)
            matrix.rows[0][3].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .l))
            matrix.rows[1][3].add(comb: m(j1: 2, j2: 3, leftType: .y, kMode: .minus2, tMode: .r))
            matrix.rows[0][4].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .r))
            matrix.rows[1][4].add(comb: Comb.ey)
            matrix.rows[1][4].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .l))
        case 3:
            matrix.rows[1][0].add(comb: Comb(comb: my12, compRight: SearchForMult.delta(way: Way.x), updateLabel: true))
            matrix.rows[0][1].add(comb: m(j1: 1, j2: 2, leftType: .x, kMode: .minus2, tMode: .l))
            matrix.rows[1][1].add(comb: Comb.ey)
            matrix.rows[1][1].add(comb: m(j1: 1, j2: 2, leftType: .y, kMode: .minus2, tMode: .r))
            matrix.rows[2][1].add(comb: SearchForMult.delta(way: Way.zy))
            addWithLabel(i: 3, j: 1, combs: [
                SearchForMult.delta(way: Way.y),
                Comb(left: Way.x, right: Way.wx, label: ""),
                Comb(left: Way.wy, right: Way.x, label: ""),
                Comb(left: Way.e, right: Way.zx, label: "")
            ])
            matrix.rows[0][2].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            matrix.rows[0][2].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .r))
            matrix.rows[1][2].add(comb: m(j1: 1, j2: 2, leftType: .y, kMode: .minus2, tMode: .l))
            matrix.rows[3][2].add(comb: SearchForMult.delta(way: Way.zx))
            matrix.rows[3][2].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[0][3].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .l))
            matrix.rows[1][3].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .r))
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.x))
            addWithLabel(i: 3, j: 3, combs: [
                Comb(left: Way.x, right: Way.wx, label: ""),
                Comb(left: Way.e, right: Way.zx, label: "")
            ])
            matrix.rows[0][4].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: m(j1: 2, j2: 3, leftType: .x, kMode: .minus2, tMode: .r))
            matrix.rows[1][4].add(comb: Comb.ey)
            matrix.rows[1][4].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .l))
            matrix.rows[3][4].add(comb: Comb.ye)
            matrix.rows[3][4].add(comb: SearchForMult.delta(way: Way.zx))
            matrix.rows[0][5].add(comb: m(j1: 1, j2: 2, leftType: .x, kMode: .minus2, tMode: .l))
            matrix.rows[1][5].add(comb: m(j1: 1, j2: 2, leftType: .y, kMode: .minus2, tMode: .r))
            addWithLabel(i: 2, j: 5, combs: [
                Comb.xe,
                Comb(left: Way.zy, right: Way.e, label: "")
            ])
            matrix.rows[3][5].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[0][6].add(comb: m(j1: 2, j2: 3, leftType: .x, kMode: .minus2, tMode: .r))
            matrix.rows[1][6].add(comb: Comb.ey)
            matrix.rows[1][6].add(comb: m(j1: 1, j2: 2, leftType: .y, kMode: .minus2, tMode: .l))
            matrix.rows[3][6].add(comb: Comb.ey)
        default:
            break
        }
    }

    // MARK: - w1'
    private func shiftW1iEven() {
        matrix.rows[0][0].add(comb: Comb.xe)
        matrix.rows[0][2].add(comb: Comb.xe)
        switch shiftDeg {
        case 2:
            matrix.rows[0][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[2][1].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[1][2].add(comb: Comb.xe)
            matrix.rows[0][3].add(comb: Comb(left: Way.wx, right: Way.x, label: ""))
            matrix.rows[2][3].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][4].add(comb: Comb.ex)
            matrix.rows[1][4].add(comb: Comb.ex)
            matrix.rows[0][5].add(comb: Comb.ey)
        default:
            break
        }
    }

    private func shiftW1iOdd() {
        matrix.rows[0][0].add(comb: Comb(comb: mx12, compRight: SearchForMult.delta(way: Way.y), updateLabel: true))
        matrix.rows[1][0].add(comb: m(j1: 0, j2: 1, leftType: .y, kMode: .zero, tMode: .l))
        matrix.rows[1][0].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .r))
        switch shiftDeg {
        case 1:
            matrix.rows[0][1].add(comb: Comb.xe)
            matrix.rows[0][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[0][3].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .l))
            matrix.rows[1][3].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .r))
            matrix.rows[0][4].add(comb: m(j1: 2, j2: 3, leftType: .x, tMode: .r))
            matrix.rows[1][4].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .l))
        case 3:
            matrix.rows[0][0].add(comb: Comb(left: Way.wx, right: Way.zx, label: ""))
            addWithLabel(i: 0, j: 1, combs: [
                Comb(left: Way.wx, right: Way.zx, label: ""),
                Comb.xe,
                m(j1: 1, j2: 2, leftType: .x, tMode: .l)
            ])
            addWithLabel(i: 1, j: 1, combs: [
                Comb(left: Way.x, right: Way.wx, label: ""), m(j1: 1, j2: 2, leftType: .y, tMode: .r)
            ])
            matrix.rows[0][2].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .r))
            matrix.rows[1][2].add(comb: m(j1: 0, j2: 1, leftType: .y, kMode: .zero, tMode: .l))
            matrix.rows[3][2].add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
            matrix.rows[0][3].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .l))
            matrix.rows[1][3].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .r))
            matrix.rows[2][3].add(comb: Comb.xe)
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.zy))
            addWithLabel(i: 0, j: 4, combs: [
                Comb(left: Way.wx, right: Way.zx, label: ""),
                Comb(left: Way.zy, right: Way.e, label: ""),
                m(j1: 2, j2: 3, leftType: .x, kMode: .minus2, tMode: .r)
            ])
            addWithLabel(i: 1, j: 4, combs: [
                Comb.ye, m(j1: 1, j2: 2, leftType: .y, tMode: .l)
            ])
            matrix.rows[3][4].add(comb: SearchForMult.delta(way: Way.y))
            matrix.rows[0][5].add(comb: Comb.ex)
            matrix.rows[0][5].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .l))
            matrix.rows[1][5].add(comb: m(j1: 2, j2: 3, leftType: .y, tMode: .r))
            matrix.rows[0][6].add(comb: Comb(left: Way.wx, right: Way.y, label: ""))
            matrix.rows[0][6].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .r))
            matrix.rows[1][6].add(comb: Comb.ey)
            matrix.rows[1][6].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .l))
        default:
            break
        }
    }

    // MARK: - w2'
    private func shiftW2iEven() {
        matrix.rows[0][1].add(comb: Comb.ye)
        matrix.rows[0][3].add(comb: Comb.ye)
        switch shiftDeg {
        case 2:
            matrix.rows[0][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[1][0].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            matrix.rows[0][2].add(comb: Comb(left: Way.wy, right: Way.y, label: ""))
            matrix.rows[1][2].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[2][3].add(comb: Comb.ye)
            matrix.rows[0][4].add(comb: Comb.ex)
            matrix.rows[0][5].add(comb: Comb.ey)
            matrix.rows[2][5].add(comb: Comb.ey)
        default:
            break
        }
    }

    private func shiftW2iOdd() {
        matrix.rows[0][0].add(comb: m(j1: 0, j2: 1, leftType: .x, kMode: .zero, tMode: .l))
        matrix.rows[0][0].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .r))
        matrix.rows[1][0].add(comb: Comb(comb: my12, compRight: SearchForMult.delta(way: Way.x), updateLabel: true))
        switch shiftDeg {
        case 1:
            matrix.rows[0][1].add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
            matrix.rows[1][1].add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
            matrix.rows[1][2].add(comb: Comb.ye)
            matrix.rows[0][3].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .l))
            matrix.rows[1][3].add(comb: m(j1: 2, j2: 3, leftType: .y, tMode: .r))
            matrix.rows[0][4].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .r))
            matrix.rows[1][4].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .l))
        case 3:
            matrix.rows[1][0].add(comb: Comb(left: Way.wy, right: Way.zy, label: ""))
            matrix.rows[0][1].add(comb: m(j1: 0, j2: 1, leftType: .x, kMode: .zero, tMode: .l))
            matrix.rows[1][1].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .r))
            matrix.rows[2][1].add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
            addWithLabel(i: 0, j: 2, combs: [
                Comb(left: Way.y, right: Way.wy, label: ""),
                m(j1: 1, j2: 2, leftType: .x, tMode: .r)
            ])
            addWithLabel(i: 1, j: 2, combs: [
                Comb.ye,
                Comb(left: Way.zy, right: Way.wx, label: ""),
                m(j1: 1, j2: 2, leftType: .y, tMode: .l)
            ])
            matrix.rows[0][3].add(comb: Comb.xe)
            matrix.rows[0][3].add(comb: m(j1: 1, j2: 2, leftType: .x, tMode: .l))
            addWithLabel(i: 1, j: 3, combs: [
                Comb(left: Way.zx, right: Way.e, label: ""),
                Comb(left: Way.wy, right: Way.zy, label: ""),
                m(j1: 2, j2: 3, leftType: .y, kMode: .minus2, tMode: .r)
            ])
            matrix.rows[2][3].add(comb: SearchForMult.delta(way: Way.x))
            matrix.rows[0][4].add(comb: m(j1: 2, j2: 3, leftType: .x, tMode: .r))
            addWithLabel(i: 1, j: 4, combs: [Comb.ey, m(j1: 0, j2: 1, leftType: .y, tMode: .l)])
            addWithLabel(i: 3, j: 4, combs: [Comb.ey, Comb(left: Way.e, right: Way.zx, label: "")])
            matrix.rows[0][5].add(comb: Comb.ex)
            matrix.rows[0][5].add(comb: m(j1: 0, j2: 1, leftType: .x, tMode: .l))
            matrix.rows[1][5].add(comb: Comb(left: Way.wy, right: Way.x, label: ""))
            matrix.rows[1][5].add(comb: m(j1: 1, j2: 2, leftType: .y, tMode: .r))
            matrix.rows[0][6].add(comb: m(j1: 2, j2: 3, leftType: .x, tMode: .r))
            matrix.rows[1][6].add(comb: Comb.ey)
            matrix.rows[1][6].add(comb: m(j1: 0, j2: 1, leftType: .y, tMode: .l))
        default:
            break
        }
    }
}

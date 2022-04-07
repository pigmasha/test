//
//  ShiftHH+u0.swift
//
//  Created by M on 25.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftU0(_ label: String) -> Bool {
        switch label {
        case "y2":
            if PathAlg.N > 3 || shiftDeg < 9 {
                shiftDeg % 2 == 0 ? shiftU1Even() : shiftU1Odd()
            }
            return true
        case "y3":
            if PathAlg.N > 3 || shiftDeg < 9 {
                shiftDeg % 2 == 0 ? shiftU2Even() : shiftU2Odd()
            }
            return true
        default: return false
        }
    }

    private func putU1(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: k)
        matrix.rows[pos.1][pos.0 + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: k)
    }

    private func putU2(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.beta1(deg: n2 - 1), koef: k)
        matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.beta2(deg: n3 - 1), koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.beta3(deg: n1 - 1), koef: k)
    }

    private func putU3(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: k)
    }

    private func putU4(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: k)
        matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: k)
    }

    private func putU5(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1][pos.0].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: k)
    }

    private func putU7(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: k)
        matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: k)
    }

    private func putU9(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e3, koef: k)
        matrix.rows[pos.1][pos.0 + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e1, koef: k)
    }

    private func putU12(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 2][pos.0].add(left: Way.e1, right: Way(type: .a32, len: 1), koef: k)
        matrix.rows[pos.1][pos.0 + 1].add(left: Way.e2, right: Way(type: .a13, len: 1), koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way.e3, right: Way(type: .a21, len: 1), koef: k)
    }

    private func putU13(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.e1, right: Way(type: .a21, len: 1), koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.e2, right: Way(type: .a32, len: 1), koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.e3, right: Way(type: .a13, len: 1), koef: k)
    }

    private func putU14(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way(type: .a21, len: 1), right: Way.e1, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a32, len: 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a13, len: 1), right: Way.e3, koef: k)
    }

    private func putU15(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a13, len: 1), right: Way.e1, koef: k)
        matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a21, len: 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a32, len: 1), right: Way.e3, koef: k)
    }

    private func putU16(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a13, len: 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a21, len: 1), right: Way.e3, koef: k)
        matrix.rows[pos.1][pos.0 + 2].add(left: Way(type: .a32, len: 1), right: Way.e1, koef: k)
    }

    private func putU17(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 1][pos.0].add(left: Way.e2, right: Way(type: .a21, len: 1), koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way.e3, right: Way(type: .a32, len: 1), koef: k)
        matrix.rows[pos.1][pos.0 + 2].add(left: Way.e1, right: Way(type: .a13, len: 1), koef: k)
    }

    private func putU18(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.alpha2(deg: n1 - 1), koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.alpha3(deg: n2 - 1), koef: k)
        matrix.rows[pos.1][pos.0 + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha1(deg: n3 - 1), koef: k)
    }

    private func putU19(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n1 == 1 {
            matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.beta1(deg: n2 - 1), koef: k)
        }
        if n2 == 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.beta2(deg: n3 - 1), koef: k)
        }
        if n3 == 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.beta3(deg: n1 - 1), koef: k)
        }
    }

    private func putU20(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n2 == 1 {
            matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.alpha2(deg: n1 - 1), koef: k)
        }
        if n3 == 1 {
            matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha3(deg: n2 - 1), koef: k)
        }
    }

    private func putU21(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n2 == 1 && n3 == 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha2(deg: n1 - 1), koef: k)
        }
    }

    // MARK: - u1
    private func shiftU1Even() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        putU1(at: (3, 0), koef: 1)
        if shiftDeg == 0 { return }
        for i in 0 ..< shiftDeg - 1 {
            let i0 = i % 6
            switch i0 {
            case 0: putU4(at: (3 * (i + 4), 3 * (i + 1)), koef: 1)
            case 1: putU3(at: (3 * (i + 4), 3 * (i + 3)), koef: 1)
            case 3: putU1(at: (3 * (i + 4), 3 * (i + 2)), koef: -1)
            default: break
            }
        }
        putU19(at: (0, 6), koef: 1)

        if shiftDeg == 2 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[10][8].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[11][6].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[9][7].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: 1)
        }
        if shiftDeg == 4 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[19][9].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[20][10].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[18][11].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: 1)
        }
        if shiftDeg == 6 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[26][18].add(left: Way.alpha1(deg: n3 - 1), right: Way(type: .a31, len: 1), koef: Utils.minusDeg(shiftDeg / 2))
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[24][19].add(left: Way.alpha2(deg: n1 - 1), right: Way(type: .a12, len: 1), koef: Utils.minusDeg(shiftDeg / 2))
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[25][20].add(left: Way.alpha3(deg: n2 - 1), right: Way(type: .a23, len: 1), koef: Utils.minusDeg(shiftDeg / 2))
        }
    }

    private func shiftU1Odd() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        putU2(at: (3, 0), koef: 1)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            switch i0 {
            case 0: putU3(at: (3 * (i + 2), 3 * (i + 1)), koef: 1)
            case 2: putU1(at: (3 * (i + 2), 3 * i), koef: -1)
            case 5: putU4(at: (3 * (i + 2), 3 * (i - 1)), koef: 1)
            default: break
            }
        }
        if shiftDeg == 1 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[10][0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[11][1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[9][2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: 1)
        }
        if shiftDeg == 3 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[15][9].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[16][10].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[17][11].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: 1)
        }
        if shiftDeg == 5 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[19][17].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[20][15].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[18][16].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: 1)
        }
        if shiftDeg == 7 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[27][17].add(left: Way.alpha1(deg: n3 - 1), right: Way(type: .a13, len: 1), koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[28][15].add(left: Way.alpha2(deg: n1 - 1), right: Way(type: .a21, len: 1), koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[29][16].add(left: Way.alpha3(deg: n2 - 1), right: Way(type: .a32, len: 1), koef: 1)
        }
    }

    // MARK: - u2
    private func shiftU2Even() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... shiftDeg {
            let i0 = i % 6
            switch i0 {
            case 0:
                let pos = (3 * (i + 2), 3 * i)
                if i < shiftDeg - 1 {
                    putU1(at: pos, koef: -1)
                    matrix.putFi(at: pos)
                } else {
                    putU5(at: pos, koef: 1)
                }
            case 1:
                let pos = (3 * (i + 2), 3 * (i + 1))
                if i < shiftDeg - 1 {
                    putU4(at: pos, koef: -1)
                    matrix.putFi(at: pos)
                } else {
                    putU9(at: pos, koef: 1)
                }
            case 4:
                let pos = (3 * (i + 2), 3 * (i - 1))
                if i < shiftDeg - 1 {
                    putU3(at: pos, koef: -1)
                    matrix.putFi(at: pos)
                } else {
                    putU7(at: pos, koef: 1)
                }
            default: break
            }
        }
        if shiftDeg == 0 { return }
        if n1 == 1 {
            matrix.rows[3][0].add(left: Way.beta1(deg: n2 - 1), right: Way(type: .a21, len: 2 * n3 - 1), koef: -1)
        }
        if n2 == 1 {
            matrix.rows[4][1].add(left: Way.beta2(deg: n3 - 1), right: Way(type: .a32, len: 2 * n1 - 1), koef: -1)
        }
        if n3 == 1 {
            matrix.rows[5][2].add(left: Way.beta3(deg: n1 - 1), right: Way(type: .a13, len: 2 * n2 - 1), koef: -1)
        }
        if shiftDeg == 2 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[12][0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.alpha1(deg: n3 - 1), koef: 1)
            if n3 != 1 {
                matrix.rows[12][0].add(left: Way(type: .a12, len: 2 * n3 - 3), right: Way.alpha1(deg: n3), koef: 1)
            }
            matrix.rows[12][1].add(left: Way.beta2(deg: n3 - 1), right: Way(type: .a12, len: 2 * n3 - 1), koef: -Utils.minusDeg(shiftDeg / 2))
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[13][1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.alpha2(deg: n1 - 1), koef: 1)
            if n1 != 1 {
                matrix.rows[13][1].add(left: Way(type: .a23, len: 2 * n1 - 3), right: Way.alpha2(deg: n1), koef: 1)
            }
            matrix.rows[13][2].add(left: Way.beta3(deg: n1 - 1), right: Way(type: .a23, len: 2 * n1 - 1), koef: -Utils.minusDeg(shiftDeg / 2))
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[14][2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.alpha3(deg: n2 - 1), koef: 1)
            if n2 != 1 {
                matrix.rows[14][2].add(left: Way(type: .a31, len: 2 * n2 - 3), right: Way.alpha3(deg: n2), koef: 1)
            }
            matrix.rows[14][0].add(left: Way.beta1(deg: n2 - 1), right: Way(type: .a31, len: 2 * n2 - 1), koef: -Utils.minusDeg(shiftDeg / 2))
        }
        if PathAlg.N > 3 { return }
        switch shiftDeg {
        case 4:
            putU12(at: (3, 12), koef: 1)
        case 6:
            putU12(at: (3, 12), koef: 1)
            putU14(at: (12, 15), koef: 1)
        case 8:
            putU16(at: (3, 12), koef: 1)
            putU17(at: (12, 15), koef: -1)
            putU13(at: (15, 21), koef: 1)
        default:
            break
        }
    }

    private func shiftU2Odd() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        putU2(at: (0, 3), koef: -1)
        matrix.putFi(at: (0, 3))
        for i in 0 ..< shiftDeg {
            let i0 = i % 6
            switch i0 {
            case 0:
                let pos = (3 * (i + 3), 3 * i)
                if i < shiftDeg - 2 {
                    putU3(at: pos, koef: -1)
                    matrix.putFi(at: pos)
                } else {
                    putU7(at: pos, koef: 1)
                }
            case 2:
                let pos = (3 * (i + 3), 3 * (i + 1))
                if i < shiftDeg - 2 {
                    putU1(at: pos, koef: -1)
                    matrix.putFi(at: pos)
                } else {
                    putU5(at: pos, koef: 1)
                }
            case 3:
                let pos = (3 * (i + 3), 3 * (i + 2))
                if i < shiftDeg - 2 {
                    putU4(at: pos, koef: -1)
                    matrix.putFi(at: pos)
                } else {
                    putU9(at: pos, koef: 1)
                }
            default: break
            }
        }
        if shiftDeg == 1 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[6][3].add(left: Way(type: .a21, len: 1), right: Way.alpha1(deg: n3 - 1), koef: Utils.minusDeg((shiftDeg + 1) / 2))
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[7][4].add(left: Way(type: .a32, len: 1), right: Way.alpha2(deg: n1 - 1), koef: Utils.minusDeg((shiftDeg + 1) / 2))
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[8][5].add(left: Way(type: .a13, len: 1), right: Way.alpha3(deg: n2 - 1), koef: Utils.minusDeg((shiftDeg + 1) / 2))
        }
        if shiftDeg == 3 { return }
        if PathAlg.N > 3 { return }
        if shiftDeg == 5 {
            putU13(at: (6, 12), koef: -1)
        }
        if shiftDeg == 7 {
            putU15(at: (6, 12), koef: -1)
            putU12(at: (12, 21), koef: -1)
        }
    }
}

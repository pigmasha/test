//
//  ShiftHH+u0.swift
//
//  Created by M on 25.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftU0(_ label: String) -> Bool {
        switch label {
        case "u1":
            if PathAlg.N > 3 || shiftDeg < 9 {
                shiftDeg % 2 == 0 ? shiftU1Even() : shiftU1Odd()
            }
            return true
        case "u2":
            switch shiftDeg {
            case 0: shiftU20()
            case 1: shiftU21()
            case 2: shiftU22()
            default: break
            }
            return true
        case "u1_h":
            shiftDeg % 2 == 1 ? shiftU1hOdd() : shiftU1hEven()
            return true
        case "u2_h":
            shiftDeg % 2 == 1 ? shiftU2hOdd() : shiftU2hEven()
            return true
        default: return false
        }
    }

    private func putU1(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: k)
        matrix.rows[pos.1 + 0][pos.0 + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: k)
    }

    private func putU2(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: k)
        matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: k)
    }

    private func putU3(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: k)
    }

    private func putU4(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.beta1(deg: n2 - 1), koef: k)
        matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.beta2(deg: n3 - 1), koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.beta3(deg: n1 - 1), koef: k)
    }

    private func shiftU1Even() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        putU1(at: (3, 0), koef: 1)
        if shiftDeg == 0 { return }
        for i in 0 ..< shiftDeg - 1 {
            let i0 = i % 6
            switch i0 {
            case 0:
                putU2(at: (3 * (i + 4), 3 * (i + 1)), koef: 1)
            case 1:
                putU3(at: (3 * (i + 4), 3 * (i + 3)), koef: 1)
            case 3:
                putU1(at: (3 * (i + 4), 3 * (i + 2)), koef: -1)
            default: break
            }
        }

        if n1 == 1 {
            matrix.rows[6][0].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.beta1(deg: n2 - 1), koef: 1)
        }
        if n2 == 1 {
            matrix.rows[7][1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.beta2(deg: n3 - 1), koef: 1)
        }
        if n3 == 1 {
            matrix.rows[8][2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
        }
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
        putU4(at: (3, 0), koef: 1)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            switch i0 {
            case 0:
                putU3(at: (3 * (i + 2), 3 * (i + 1)), koef: 1)
            case 2:
                putU1(at: (3 * (i + 2), 3 * i), koef: -1)
            case 5:
                putU2(at: (3 * (i + 2), 3 * (i - 1)), koef: 1)
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

    private func shiftU20() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][6].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        matrix.rows[1][7].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        matrix.rows[2][8].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: 1)
    }

    private func shiftU21() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][10].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: 1)
        matrix.rows[1][11].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: 1)
        matrix.rows[2][9].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: 1)
        matrix.rows[3][2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha1(deg: n3 - 1), koef: 1)
        matrix.rows[4][0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.alpha2(deg: n1 - 1), koef: 1)
        matrix.rows[5][1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.alpha3(deg: n2 - 1), koef: 1)
    }

    private func shiftU22() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n1 == 1 {
            matrix.rows[5][0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.alpha1(deg: n3 - 1), koef: 1)
        }
        if n2 == 1 {
            matrix.rows[3][1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.alpha2(deg: n1 - 1), koef: 1)
        }
        if n3 == 1 {
            matrix.rows[4][2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha3(deg: n2 - 1), koef: 1)
        }
        matrix.rows[0][6].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        matrix.rows[0][9].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: -1)
        matrix.rows[0][11].add(left: Way(type: .a31, len: 1), right: Way.e1, koef: -1)
        matrix.rows[1][7].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        matrix.rows[1][9].add(left: Way(type: .a12, len: 1), right: Way.e2, koef: -1)
        matrix.rows[1][10].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: -1)
        matrix.rows[2][8].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: 1)
        matrix.rows[2][10].add(left: Way(type: .a23, len: 1), right: Way.e3, koef: -1)
        matrix.rows[2][11].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: -1)
        matrix.rows[6][10].add(left: Way.e2, right: Way(type: .a13, len: 2 * n2 - 1), koef: 1)
        matrix.rows[7][11].add(left: Way.e3, right: Way(type: .a21, len: 2 * n3 - 1), koef: 1)
        matrix.rows[8][9].add(left: Way.e1, right: Way(type: .a32, len: 2 * n1 - 1), koef: 1)
    }

    // MARK: - u1_h
    private func shiftU1hEven() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        putU1(at: (12, 0), koef: 1)
        if shiftDeg == 0 { return }
        for i in 0 ..< shiftDeg - 1 {
            let i0 = i % 6
            switch i0 {
            case 0:
                putU2(at: (3 * (i + 7), 3 * (i + 1)), koef: 1)
            case 1:
                putU3(at: (3 * (i + 7), 3 * (i + 3)), koef: 1)
            case 3:
                putU1(at: (3 * (i + 7), 3 * (i + 2)), koef: -1)
            default: break
            }
        }
        if n2 == 1 {
            matrix.rows[7][7].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.beta2(deg: n3 - 1), koef: -1)
        }
        if n3 == 1 {
            matrix.rows[8][8].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.beta3(deg: n1 - 1), koef: -1)
        }
    }

    private func shiftU1hOdd() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        putU4(at: (12, 0), koef: 1)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            switch i0 {
            case 0:
                putU3(at: (3 * (i + 5), 3 * (i + 1)), koef: 1)
            case 2:
                putU1(at: (3 * (i + 5), 3 * i), koef: -1)
            case 5:
                putU2(at: (3 * (i + 5), 3 * (i - 1)), koef: 1)
            default: break
            }
        }
        if shiftDeg > 1 && n2 == 1 && n3 == 1 {
            matrix.rows[11][4].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
        }
    }

    // MARK: - u2_h
    private func shiftU2hEven() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6)
            switch i0 {
            case 0:
                matrix.rows[3 * i][3 * (i + 5)].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: k)
                matrix.rows[3 * i + 1][3 * (i + 5) + 1].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: k)
                matrix.rows[3 * i + 2][3 * (i + 5) + 2].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: k)
            case 1:
                matrix.rows[3 * (i + 1) + 1][3 * (i + 5)].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e2, koef: -k)
                matrix.rows[3 * (i + 1) + 2][3 * (i + 5) + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e3, koef: -k)
                matrix.rows[3 * (i + 1)][3 * (i + 5) + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e1, koef: -k)
            case 4:
                matrix.rows[3 * (i - 1) + 2][3 * (i + 5)].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: k)
                matrix.rows[3 * (i - 1)][3 * (i + 5) + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: k)
                matrix.rows[3 * (i - 1) + 1][3 * (i + 5) + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: k)
            default: break
            }
        }
        if shiftDeg > 0 && n2 == 1 {
            matrix.rows[3][10].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.alpha2(deg: n1 - 1), koef: -Utils.minusDeg(shiftDeg / 2))
        }
        if shiftDeg > 0 && n3 == 1 {
            matrix.rows[4][11].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha3(deg: n2 - 1), koef: -Utils.minusDeg(shiftDeg / 2))
        }
    }

    private func shiftU2hOdd() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let k = Utils.minusDeg(shiftDeg / 2)
        matrix.rows[4][9].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.alpha2(deg: n1 - 1), koef: -k)
        matrix.rows[5][10].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.alpha3(deg: n2 - 1), koef: -k)
        matrix.rows[3][11].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha1(deg: n3 - 1), koef: -k)
        for i in 0 ..< shiftDeg {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6)
            switch i0 {
            case 0:
                matrix.rows[3 * i + 2][3 * (i + 6)].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: k)
                matrix.rows[3 * i][3 * (i + 6) + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: k)
                matrix.rows[3 * i + 1][3 * (i + 6) + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: k)
            case 2:
                matrix.rows[3 * (i + 1)][3 * (i + 6)].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: -k)
                matrix.rows[3 * (i + 1) + 1][3 * (i + 6) + 1].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: -k)
                matrix.rows[3 * (i + 1) + 2][3 * (i + 6) + 2].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: -k)
            case 3:
                matrix.rows[3 * (i + 2) + 1][3 * (i + 6)].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e2, koef: k)
                matrix.rows[3 * (i + 2) + 2][3 * (i + 6) + 1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e3, koef: k)
                matrix.rows[3 * (i + 2)][3 * (i + 6) + 2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e1, koef: k)
            default: break
            }
        }
        if shiftDeg > 1 && n2 == 1 && n3 == 1 {
            matrix.rows[7][7].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.alpha2(deg: n1 - 1), koef: Utils.minusDeg(shiftDeg / 2))
        }
    }
}

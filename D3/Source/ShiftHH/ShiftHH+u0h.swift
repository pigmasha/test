//
//  ShiftHH+u0h.swift
//
//  Created by M on 05.12.2021.
//

import Foundation

extension ShiftHH {
    func shiftU0h(_ label: String) -> Bool {
        switch label {
        case "u1_h":
            switch shiftDeg {
            case 0: shiftU1h0()
            case 1: shiftU1h1()
            default: shiftDeg % 2 == 1 ? shiftU1hOdd() : shiftU1Even()
            }
            return true
        case "u2_h":
            shiftDeg % 2 == 1 ? shiftU2hOdd() : shiftU2hEven()
            return true
        default: return false
        }
    }
    
    // MARK: - u1_h
    private func shiftU1h0() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][12].add(left: Way.alpha1(deg: n3 - 1), right: Way(type: .a12, len: 1), koef: 1)
        matrix.rows[1][13].add(left: Way.alpha2(deg: n1 - 1), right: Way(type: .a23, len: 1), koef: 1)
        matrix.rows[2][14].add(left: Way.alpha3(deg: n2 - 1), right: Way(type: .a31, len: 1), koef: 1)
    }

    private func shiftU1h1() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][15].add(left: Way.alpha1(deg: n3 - 1), right: Way(type: .a21, len: 1), koef: 1)
        matrix.rows[2][15].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: -1)
        matrix.rows[3][15].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        matrix.rows[0][16].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: -1)
        matrix.rows[1][16].add(left: Way.alpha2(deg: n1 - 1), right: Way(type: .a32, len: 1), koef: 1)
        matrix.rows[4][16].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        matrix.rows[1][17].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: -1)
        matrix.rows[2][17].add(left: Way.alpha3(deg: n2 - 1), right: Way(type: .a13, len: 1), koef: 1)
        matrix.rows[5][17].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: 1)
        if n2 == 1 {
            matrix.rows[2][12].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: 1)
        }
        if n3 == 1 {
            matrix.rows[0][13].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: 1)
        }
    }

    private func shiftU1Even() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6) * (i == 0 ? -1 : 1)
            switch i0 {
            case 0:
                if i > shiftDeg - 1 {
                    matrix.rows[3 * (i - 1) + 1][3 * (i + 4)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: -k)
                    matrix.rows[3 * (i - 1) + 2][3 * (i + 4) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: -k)
                    matrix.rows[3 * (i - 1)][3 * (i + 4) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: -k)
                } else {
                    let i0 = i == 0 ? 0 : -3
                    matrix.rows[3 * i + i0][3 * (i + 4)].add(left: Way.e1, right: Way(type: .a12, len: 2 * n3 - 1), koef: -k)
                    matrix.rows[3 * i + i0 + 1][3 * (i + 4) + 1].add(left: Way.e2, right: Way(type: .a23, len: 2 * n1 - 1), koef: -k)
                    matrix.rows[3 * i + i0 + 2][3 * (i + 4) + 2].add(left: Way.e3, right: Way(type: .a31, len: 2 * n2 - 1), koef: -k)
                }
            case 3:
                if i > shiftDeg - 1 {
                    matrix.rows[3 * i - 4][3 * (i + 4)].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: -k)
                    matrix.rows[3 * i - 6][3 * (i + 4) + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: -k)
                    matrix.rows[3 * i - 5][3 * (i + 4) + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: -k)
                } else {
                    matrix.rows[3 * i - 5][3 * (i + 4)].add(left: Way.e2, right: Way(type: .a31, len: 2 * n2 - 1), koef: -k)
                    matrix.rows[3 * i - 4][3 * (i + 4) + 1].add(left: Way.e3, right: Way(type: .a12, len: 2 * n3 - 1), koef: -k)
                    matrix.rows[3 * (i - 2)][3 * (i + 4) + 2].add(left: Way.e1, right: Way(type: .a23, len: 2 * n1 - 1), koef: -k)
                }
            case 4:
                if i > shiftDeg - 1 {
                    matrix.rows[3 * i][3 * (i + 4)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: k)
                    matrix.rows[3 * i + 1][3 * (i + 4) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: k)
                    matrix.rows[3 * i + 2][3 * (i + 4) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: k)
                 } else {
                     matrix.rows[3 * i + 2][3 * (i + 4)].add(left: Way.e1, right: Way(type: .a31, len: 2 * n2 - 1), koef: k)
                     matrix.rows[3 * i][3 * (i + 4) + 1].add(left: Way.e2, right: Way(type: .a12, len: 2 * n3 - 1), koef: k)
                     matrix.rows[3 * i + 1][3 * (i + 4) + 2].add(left: Way.e3, right: Way(type: .a23, len: 2 * n1 - 1), koef: k)
                 }
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
        let k = Utils.minusDeg(shiftDeg / 2)
        matrix.rows[1][12].add(left: Way.alpha2(deg: n1 - 1), right: Way(type: .a31, len: 2 * n2 - 1), koef: -k)
        matrix.rows[2][13].add(left: Way.alpha3(deg: n2 - 1), right: Way(type: .a12, len: 2 * n3 - 1), koef: -k)
        matrix.rows[0][14].add(left: Way.alpha1(deg: n3 - 1), right: Way(type: .a23, len: 2 * n1 - 1), koef: -k)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6)
            switch i0 {
            case 0:
                if i > shiftDeg - 2 {
                    matrix.rows[3 * (i + 1)][3 * (i + 5)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: k)
                    matrix.rows[3 * (i + 1) + 1][3 * (i + 5) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: k)
                    matrix.rows[3 * (i + 1) + 2][3 * (i + 5) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: k)
                } else {
                    matrix.rows[3 * (i + 1) + 2][3 * (i + 5)].add(left: Way.e1, right: Way(type: .a31, len: 2 * n2 - 1), koef: k)
                    matrix.rows[3 * (i + 1)][3 * (i + 5) + 1].add(left: Way.e2, right: Way(type: .a12, len: 2 * n3 - 1), koef: k)
                    matrix.rows[3 * (i + 1) + 1][3 * (i + 5) + 2].add(left: Way.e3, right: Way(type: .a23, len: 2 * n1 - 1), koef: k)
                }
            case 2:
                if i > shiftDeg - 2 {
                    matrix.rows[3 * i + 1][3 * (i + 5)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: k)
                    matrix.rows[3 * i + 2][3 * (i + 5) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: k)
                    matrix.rows[3 * i][3 * (i + 5) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: k)
                } else {
                    matrix.rows[3 * i][3 * (i + 5)].add(left: Way.e1, right: Way(type: .a12, len: 2 * n3 - 1), koef: k)
                    matrix.rows[3 * i + 1][3 * (i + 5) + 1].add(left: Way.e2, right: Way(type: .a23, len: 2 * n1 - 1), koef: k)
                    matrix.rows[3 * i + 2][3 * (i + 5) + 2].add(left: Way.e3, right: Way(type: .a31, len: 2 * n2 - 1), koef: k)
                }
            case 5:
                if i > shiftDeg - 2 {
                    matrix.rows[3 * i - 1][3 * (i + 5)].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: k)
                    matrix.rows[3 * i - 3][3 * (i + 5) + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: k)
                    matrix.rows[3 * i - 2][3 * (i + 5) + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: k)
                } else {
                    matrix.rows[3 * i - 2][3 * (i + 5)].add(left: Way.e2, right: Way(type: .a31, len: 2 * n2 - 1), koef: k)
                    matrix.rows[3 * i - 1][3 * (i + 5) + 1].add(left: Way.e3, right: Way(type: .a12, len: 2 * n3 - 1), koef: k)
                    matrix.rows[3 * i - 3][3 * (i + 5) + 2].add(left: Way.e1, right: Way(type: .a23, len: 2 * n1 - 1), koef: k)
                }
            default:
                break
            }
        }
        if n2 == 1 {
            matrix.rows[10][12].add(left: Way.alpha2(deg: n1 - 1), right: Way(type: .a21, len: 2 * n3 - 1), koef: -1)
            matrix.rows[10][13].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.beta2(deg: n3 - 1), koef: -Utils.minusDeg(shiftDeg / 2))
        }
        if n3 == 1 {
            matrix.rows[11][13].add(left: Way.alpha3(deg: n2 - 1), right: Way(type: .a32, len: 2 * n1 - 1), koef: -1)
            matrix.rows[11][14].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.beta3(deg: n1 - 1), koef: -Utils.minusDeg(shiftDeg / 2))
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[10][4].add(left: Way.alpha2(deg: n1 - 1), right: Way(type: .a23, len: 2 * n1 - 1), koef: Utils.minusDeg(shiftDeg / 2))
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

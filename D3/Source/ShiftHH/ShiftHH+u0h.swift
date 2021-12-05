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
            shiftDeg % 2 == 1 ? shiftU1hOdd() : shiftU1hEven()
            return true
        case "u2_h":
            shiftDeg % 2 == 1 ? shiftU2hOdd() : shiftU2hEven()
            return true
        default: return false
        }
    }
    
    // MARK: - u1_h
    private func shiftU1hEven() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[1][12].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: 1)
        matrix.rows[2][13].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: 1)
        matrix.rows[0][14].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: 1)
        if shiftDeg == 0 { return }
        for i in 0 ..< shiftDeg - 1 {
            let i0 = i % 6
            switch i0 {
            case 0:
                matrix.rows[3 * i + 5][3 * (i + 7)].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: 1)
                matrix.rows[3 * i + 3][3 * (i + 7) + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: 1)
                matrix.rows[3 * i + 4][3 * (i + 7) + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: 1)
            case 1:
                matrix.rows[3 * (i + 3)][3 * (i + 7)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: 1)
                matrix.rows[3 * (i + 3) + 1][3 * (i + 7) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: 1)
                matrix.rows[3 * (i + 3) + 2][3 * (i + 7) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: 1)
            case 3:
                matrix.rows[3 * (i + 2) + 1][3 * (i + 7)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: -1)
                matrix.rows[3 * (i + 2) + 2][3 * (i + 7) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: -1)
                matrix.rows[3 * (i + 2)][3 * (i + 7) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: -1)
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
        matrix.rows[2][12].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.beta1(deg: n2 - 1), koef: 1)
        matrix.rows[0][13].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.beta2(deg: n3 - 1), koef: 1)
        matrix.rows[1][14].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            switch i0 {
            case 0:
                matrix.rows[3 * (i + 1)][3 * (i + 5)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: 1)
                matrix.rows[3 * (i + 1) + 1][3 * (i + 5) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: 1)
                matrix.rows[3 * (i + 1) + 2][3 * (i + 5) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: 1)
            case 2:
                matrix.rows[3 * i + 1][3 * (i + 5)].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: -1)
                matrix.rows[3 * i + 2][3 * (i + 5) + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: -1)
                matrix.rows[3 * i][3 * (i + 5) + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: -1)
            case 5:
                matrix.rows[3 * (i - 1) + 2][3 * (i + 5)].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: 1)
                matrix.rows[3 * (i - 1)][3 * (i + 5) + 1].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: 1)
                matrix.rows[3 * (i - 1) + 1][3 * (i + 5) + 2].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: 1)
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

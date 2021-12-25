//
//  ShiftHH+w00.swift
//
//  Created by M on 23.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftW00(_ label: String) -> Bool {
        switch label {
        case "w":
            switch shiftDeg {
            case 0: shiftW0()
            case 1: shiftW1()
            case 2: shiftW2()
            default: break
            }
            return true
        case "w23":
            switch shiftDeg {
            case 0: shiftW230()
            case 1: shiftW231()
            case 2: shiftW232()
            default: break
            }
            return true
        case "w31":
            switch shiftDeg {
            case 0: shiftW310()
            case 1: shiftW311()
            case 2: shiftW312()
            default: break
            }
            return true
        case "w12":
            switch shiftDeg {
            case 0: shiftW120()
            case 1: shiftW121()
            case 2: shiftW122()
            default: break
            }
            return true
        case "w23_h":
            switch shiftDeg {
            case 0: shiftW23h0()
            case 1, 3, 5: shiftW23hOdd()
            case 2, 4, 6: shiftW23hEven()
            default: break
            }
            return true
        case "w31_h":
            switch shiftDeg {
            case 0: shiftW31h0()
            case 1, 3, 5: shiftW31hOdd()
            case 2, 4, 6: shiftW31hEven()
            default: break
            }
            return true
        case "w12_h":
            switch shiftDeg {
            case 1, 3, 5: shiftW12hOdd()
            case 0, 2, 4, 6: shiftW12hEven()
            default: break
            }
            return true
        default:
            return false
        }
    }

    // MARK: - w
    private func shiftW0() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: n1 * n2)
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: n2 * n3)
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: n3 * n1)
    }

    private func putW123_1(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: k)
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: i), right: Way(type: .a32, len: 2 * (n1 - i) - 1), koef: k)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: i), right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: k)
        }
    }

    private func putW12_1(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -k * (i + 1))
        }
        if n3 > 1 {
            for i in 1 ... n3 - 1 {
                matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a21, len: 2 * (n3 - i) - 1), right: Way.beta2(deg: i), koef: -k * i)
            }
        }
    }

    private func putW12_1_1(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -k * (i + 1))
        }
        if n3 > 1 {
            for i in 1 ... n3 - 1 {
                matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a21, len: 2 * (n3 - i) - 1), right: Way.beta2(deg: i), koef: k * i)
            }
        }
    }

    private func putW12_2(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way.alpha1(deg: n3 - i - 1), koef: -k * (i + 1))
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0 + 1].add(left: Way.beta2(deg: n3 - i - 1), right: Way(type: .a12, len: 2 * i + 1), koef: -k * (i + 1))
        }
    }

    private func putW12_2_1(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way.alpha1(deg: n3 - i - 1), koef: -k * (i + 1))
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0 + 1].add(left: Way.beta2(deg: n3 - i - 1), right: Way(type: .a12, len: 2 * i + 1), koef: k * (i + 1))
        }
    }

    private func putW23_1(at pos: (Int, Int), koef k: Int, overline: Bool) {
        let n1 = PathAlg.n1
        for i in 0 ... n1 - 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: i), right: Way(type: .a32, len: 2 * (n1 - i) - 1), koef: -k * (i + 1))
        }
        if n1 > 1 {
            for i in 1 ... n1 - 1 {
                matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a32, len: 2 * (n1 - i) - 1), right: Way.beta3(deg: i),
                                                      koef: overline ? k * i : -k * i)
            }
        }
    }

    private func putW23_2(at pos: (Int, Int), koef k: Int, overline: Bool) {
        let n1 = PathAlg.n1
        for i in 0 ... n1 - 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a23, len: 2 * i + 1), right: Way.alpha2(deg: n1 - i - 1), koef: -k * (i + 1))
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way.beta3(deg: n1 - i - 1), right: Way(type: .a23, len: 2 * i + 1),
                                                  koef: overline ? k * (i + 1) : -k * (i + 1))
        }
    }

    private func putW31_1(at pos: (Int, Int), koef k: Int) {
        let n2 = PathAlg.n2
        for i in 0 ... n2 - 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: i), right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: -k * (i + 1))
        }
        if n2 > 1 {
            for i in 1 ... n2 - 1 {
                matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a13, len: 2 * (n2 - i) - 1), right: Way.beta1(deg: i), koef: -k * i)
            }
        }
    }

    private func putW31_2(at pos: (Int, Int), koef k: Int) {
        let n2 = PathAlg.n2
        for i in 0 ... n2 - 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a31, len: 2 * i + 1), right: Way.alpha3(deg: n2 - i - 1), koef: -k * (i + 1))
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[pos.1 + 2][pos.0].add(left: Way.beta1(deg: n2 - i - 1), right: Way(type: .a31, len: 2 * i + 1), koef: -k * (i + 1))
        }
    }

    private func putW1(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way.e3, right: Way(type: .a12, len: 1), koef: k)
    }

    private func putW2(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0 + 2].add(left: Way.e1, right: Way(type: .a23, len: 1), koef: k)
    }

    private func putW3(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 1][pos.0].add(left: Way.e2, right: Way(type: .a31, len: 1), koef: k)
    }

    private func putW4(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: k)
    }

    private func putW5(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way.e3, right: Way(type: .a21, len: 2 * PathAlg.n3 - 1), koef: k)
    }

    private func putW6(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a23, len: 1), right: Way.e2, koef: k)
    }

    private func putW7(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a32, len: 2 * PathAlg.n1 - 1), right: Way.e2, koef: k)
    }

    private func putW8(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: k)
    }

    private func putW14(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a13, len: 2 * PathAlg.n2 - 1), right: Way.e3, koef: k)
    }

    private func putW15(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: k)
    }

    private func shiftW1() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        putW123_1(at: (0, 0), koef: n1 * n2 * n3)
        matrix.putFi(from: (0, 0), to: (0, 3), koef: 1)
        putW12_1(at: (0, 0), koef: n1 * n2)
        putW12_2(at: (0, 3), koef: n1 * n2)
        putW23_1(at: (0, 0), koef: n2 * n3, overline: false)
        putW23_2(at: (0, 3), koef: n2 * n3, overline: false)
        putW31_1(at: (0, 0), koef: n3 * n1)
        putW31_2(at: (0, 3), koef: n3 * n1)
        putW1(at: (6, 0), koef: n1 * n2)
        putW2(at: (6, 0), koef: n2 * n3)
        putW3(at: (6, 0), koef: n3 * n1)
    }

    private func shiftW2() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: -n1 * n2)
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: -n2 * n3)
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: -n1 * n3)
        matrix.rows[8][0].add(left: Way.e1, right: Way(type: .a32, len: 2 * n1 - 1), koef: (n1 - 1) * n2 * n3)
        matrix.rows[6][1].add(left: Way.e2, right: Way(type: .a13, len: 2 * n2 - 1), koef: n1 * (n2 - 1) * n3)
        matrix.rows[7][2].add(left: Way.e3, right: Way(type: .a21, len: 2 * n3 - 1), koef: n1 * n2 * (n3 - 1))
        matrix.rows[0][3].add(left: Way(type: .a21, len: 1), right: Way.e1, koef: -n1 * n2 * n3)
        matrix.rows[1][3].add(left: Way.e2, right: Way(type: .a21, len: 1), koef: -n1 * n2 * n3)
        matrix.rows[5][3].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: n1 * n2 * n3)
        matrix.rows[1][4].add(left: Way(type: .a32, len: 1), right: Way.e2, koef: -n1 * n2 * n3)
        matrix.rows[2][4].add(left: Way.e3, right: Way(type: .a32, len: 1), koef: -n1 * n2 * n3)
        matrix.rows[3][4].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: n1 * n2 * n3)
        matrix.rows[0][5].add(left: Way.e1, right: Way(type: .a13, len: 1), koef: -n1 * n2 * n3)
        matrix.rows[2][5].add(left: Way(type: .a13, len: 1), right: Way.e3, koef: -n1 * n2 * n3)
        matrix.rows[4][5].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: n1 * n2 * n3)
        matrix.rows[8][9].add(left: Way.e1, right: Way(type: .a31, len: 1), koef: n1 * n3)
        matrix.rows[6][10].add(left: Way.e2, right: Way(type: .a12, len: 1), koef: n1 * n2)
        matrix.rows[7][11].add(left: Way.e3, right: Way(type: .a23, len: 1), koef: n2 * n3)
    }

    // MARK: - w23
    private func shiftW230() {
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: 1)
    }

    private func shiftW231() {
        putW23_1(at: (0, 0), koef: 1, overline: false)
        putW23_2(at: (0, 3), koef: 1, overline: false)
        putW2(at: (6, 0), koef: 1)
    }

    private func shiftW232() {
        let n2 = PathAlg.n2
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: -1)
        matrix.rows[1][0].add(left: Way(type: .a12, len: 1), right: Way.e2, koef: -1)
        matrix.rows[7][0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e2, koef: -1)
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: -1)
        matrix.rows[7][11].add(left: Way.e3, right: Way(type: .a23, len: 1), koef: 1)
    }

    // MARK: - w31
    private func shiftW310() {
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: 1)
    }

    private func shiftW311() {
        putW31_1(at: (0, 0), koef: 1)
        putW31_2(at: (0, 3), koef: 1)
        putW3(at: (6, 0), koef: 1)
    }

    private func shiftW312() {
        let n3 = PathAlg.n3
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: -1)
        matrix.rows[2][1].add(left: Way(type: .a23, len: 1), right: Way.e3, koef: -1)
        matrix.rows[8][1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e3, koef: -1)
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: -1)
        matrix.rows[8][9].add(left: Way.e1, right: Way(type: .a31, len: 1), koef: 1)
    }

    // MARK: - w23
    private func shiftW120() {
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: 1)
    }

    private func shiftW121() {
        putW12_1(at: (0, 0), koef: 1)
        putW12_2(at: (0, 3), koef: 1)
        putW1(at: (6, 0), koef: 1)
    }

    private func shiftW122() {
        let n1 = PathAlg.n1
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: -1)
        matrix.rows[0][2].add(left: Way(type: .a31, len: 1), right: Way.e1, koef: -1)
        matrix.rows[6][2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e1, koef: -1)
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: -1)
        matrix.rows[6][10].add(left: Way.e2, right: Way(type: .a12, len: 1), koef: 1)
    }

    // MARK: - w23_h
    private func shiftW23h0() {
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: 1)
    }

    private func shiftW23hOdd() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        putW23_1(at: (0, 0), koef: shiftDeg == 3 ? -1 : 1, overline: shiftDeg != 3)
        putW23_2(at: (0, 3), koef: shiftDeg == 3 ? -1 : 1, overline: shiftDeg != 3)
        putW2(at: (6, 0), koef: 1)
        if shiftDeg == 1 { return }
        if shiftDeg == 3 {
            putW14(at: (6, 9), koef: 1)
            putW15(at: (9, 9), koef: -1)
            return
        }
        matrix.rows[11][7].add(left: Way.e3, right: Way(type: .a32, len: 2 * n1 - 1), koef: 1)
        matrix.rows[10][10].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: 1)
        matrix.rows[17][10].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e3, koef: 1)
        matrix.rows[15][18].add(left: Way(type: .a12, len: 1), right: Way.e1, koef: 1)
    }

    private func shiftW23hEven() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        let k = Utils.minusDeg(shiftDeg / 2)
        matrix.rows[8][0].add(left: Way.e1, right: Way(type: .a32, len: 2 * n1 - 1), koef: k)
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: 1)
        if shiftDeg == 2 {
            matrix.rows[8][11].add(left: Way(type: .a31, len: 1), right: Way.e3, koef: 1)
            return
        }
        matrix.rows[7][11].add(left: Way.e3, right: Way(type: .a23, len: 1), koef: 1)
        if shiftDeg == 4 {
            matrix.rows[10][11].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: 1)
            matrix.rows[10][15].add(left: Way.e2, right: Way(type: .a31, len: 1), koef: -1)
            return
        }
        matrix.rows[10][10].add(left: Way.e2, right: Way(type: .a32, len: 2 * n1 - 1), koef: 1)
        matrix.rows[18][15].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: -1)
        matrix.rows[10][17].add(left: Way(type: .a12, len: 1), right: Way.e3, koef: -1)
        matrix.rows[18][18].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: 1)
    }

    // MARK: - w31_h
    private func shiftW31h0() {
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: 1)
    }

    private func shiftW31hOdd() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let k = Utils.minusDeg(shiftDeg / 2)
        for i in 0 ... n2 - 1 {
            matrix.rows[2][2].add(left: Way.alpha3(deg: i), right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: k * (-i - 1))
        }
        for i in 1 ... n2 - 1 {
            matrix.rows[2][0].add(left: Way(type: .a13, len: 2 * (n2 - i) - 1), right: Way.beta1(deg: i), koef: i)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][2].add(left: Way(type: .a31, len: 2 * i + 1), right: Way.alpha3(deg: n2 - i - 1), koef: k * (-i - 1))
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][0].add(left: Way.beta1(deg: n2 - i - 1), right: Way(type: .a31, len: 2 * i + 1), koef: i + 1)
        }
        matrix.rows[1][6].add(left: Way.e2, right: Way(type: .a31, len: 1), koef: 1)
        if shiftDeg == 1 { return }
        if shiftDeg == 3 {
            matrix.rows[9][6].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: 1)
            matrix.rows[9][9].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: -1)
            return
        }
        matrix.rows[9][8].add(left: Way.e1, right: Way(type: .a13, len: 2 * n2 - 1), koef: 1)
        matrix.rows[11][11].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: 1)
        matrix.rows[15][11].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e1, koef: 1)
        matrix.rows[16][19].add(left: Way(type: .a23, len: 1), right: Way.e2, koef: 1)
    }

    private func shiftW31hEven() {
        let (n1, n2) = (PathAlg.n1, PathAlg.n2)
        let k = Utils.minusDeg(shiftDeg / 2)
        matrix.rows[6][1].add(left: Way.e2, right: Way(type: .a13, len: 2 * n2 - 1), koef: k)
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: 1)
        if shiftDeg == 2 {
            matrix.rows[6][9].add(left: Way(type: .a12, len: 1), right: Way.e1, koef: 1)
            return
        }
        matrix.rows[8][9].add(left: Way.e1, right: Way(type: .a31, len: 1), koef: 1)
        if shiftDeg == 4 {
            matrix.rows[11][9].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: 1)
            matrix.rows[11][16].add(left: Way.e3, right: Way(type: .a12, len: 1), koef: -1)
            return
        }
        matrix.rows[11][11].add(left: Way.e3, right: Way(type: .a13, len: 2 * n2 - 1), koef: 1)
        matrix.rows[19][16].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: -1)
        matrix.rows[11][15].add(left: Way(type: .a23, len: 1), right: Way.e1, koef: -1)
        matrix.rows[19][19].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: 1)
    }

    // MARK: - w12_h
    private func shiftW12hOdd() {
        let (n2, n3) = (PathAlg.n2, PathAlg.n3)
        if shiftDeg == 3 {
            putW12_1(at: (0, 0), koef: -1)
            putW12_2(at: (0, 3), koef: -1)
        } else {
            putW12_1_1(at: (0, 0), koef: 1)
            putW12_2_1(at: (0, 3), koef: 1)
        }
        putW1(at: (6, 0), koef: 1)
        if shiftDeg == 1 { return }
        if shiftDeg == 3 {
            putW7(at: (6, 9), koef: 1)
            putW8(at: (9, 9), koef: -1)
            return
        }
        matrix.rows[10][6].add(left: Way.e2, right: Way(type: .a21, len: 2 * n3 - 1), koef: 1)
        matrix.rows[9][9].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: 1)
        matrix.rows[16][9].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e2, koef: 1)
        matrix.rows[17][20].add(left: Way(type: .a31, len: 1), right: Way.e3, koef: 1)
    }

    private func shiftW12hEven() {
        let (n2, n3) = (PathAlg.n2, PathAlg.n3)
        putW4(at: (0, 0), koef: 1)
        if shiftDeg == 0 { return }
        if shiftDeg == 2 {
            putW5(at: (0, 6), koef: -1)
            putW6(at: (9, 6), koef: 1)
            return
        }
        putW5(at: (0, 6), koef: Utils.minusDeg(shiftDeg / 2))
        matrix.rows[6][10].add(left: Way.e2, right: Way(type: .a12, len: 1), koef: 1)
        if shiftDeg == 4 {
            matrix.rows[9][10].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: 1)
            matrix.rows[9][17].add(left: Way.e1, right: Way(type: .a23, len: 1), koef: -1)
            return
        }
        matrix.rows[9][9].add(left: Way.e1, right: Way(type: .a21, len: 2 * n3 - 1), koef: 1)
        matrix.rows[20][17].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: -1)
        matrix.rows[9][16].add(left: Way(type: .a31, len: 1), right: Way.e2, koef: -1)
        matrix.rows[20][20].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: 1)
    }
}

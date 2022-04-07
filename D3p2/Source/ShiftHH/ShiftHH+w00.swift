//
//  ShiftHH+w00.swift
//
//  Created by M on 23.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftW00(_ label: String) -> Bool {
        switch label {
        case "x1":
            switch shiftDeg {
            case 0: shiftX10()
            case 1: shiftX11()
            default: break
            }
            return true
        case "x2":
            switch shiftDeg {
            case 0: shiftX20()
            case 1: shiftX21()
            default: break
            }
            return true
        case "x1_1":
            switch shiftDeg {
            case 0: shiftX110()
            case 1: shiftX111()
            default: break
            }
            return true
        case "x1_2":
            switch shiftDeg {
            case 0: shiftX120()
            case 1: shiftX121()
            default: break
            }
            return true
        case "x2_1":
            switch shiftDeg {
            case 0: shiftX210()
            case 1: shiftX211()
            default: break
            }
            return true
        case "x2_2":
            switch shiftDeg {
            case 0: shiftX220()
            case 1: shiftX221()
            default: break
            }
            return true
        default:
            return false
        }
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

    // MARK: - x1
    private func shiftX10() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: n1 * n2)
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: n2 * n3)
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: n3 * n1)
    }
    
    private func shiftX11() {
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

    // MARK: - x2
    private func shiftX20() {
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: 1)
        matrix.putFi(from: (0, 0), to: (3, 0), koef: 1)
    }

    private func shiftX21() {
        let n3 = PathAlg.n3
        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: Way.alpha1(deg: i), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: 1)
        }
        matrix.putFi(from: (0, 0), to: (0, 3), koef: 1)
        matrix.rows[2][7].add(left: Way.e3, right: Way(type: .a12, len: 1), koef: 1)
        matrix.putFi(from: (6, 0), to: (3, 3), koef: 1)
    }

    // MARK: - x1_1
    private func shiftX110() {
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: 1)
    }

    private func shiftX111() {
        putW23_1(at: (0, 0), koef: 1, overline: false)
        putW23_2(at: (0, 3), koef: 1, overline: false)
        putW2(at: (6, 0), koef: 1)
    }

    // MARK: - x1_2
    private func shiftX120() {
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: 1)
    }

    private func shiftX121() {
        putW31_1(at: (0, 0), koef: 1)
        putW31_2(at: (0, 3), koef: 1)
        putW3(at: (6, 0), koef: 1)
    }

    // MARK: - x2_1
    private func shiftX210() {
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: 1)
    }

    private func shiftX211() {
        putW12_1(at: (0, 0), koef: 1)
        putW12_2(at: (0, 3), koef: 1)
        putW1(at: (6, 0), koef: 1)
    }

    // MARK: - x2_2
    private func shiftX220() {
        matrix.rows[0][3].add(left: Way(type: .a21, len: 1), right: Way.e1, koef: 1)
    }

    private func shiftX221() {
        let n3 = PathAlg.n3
        if n3 > 1 {
            for i in 1 ... n3 - 1 {
                matrix.rows[0][0].add(left: Way.alpha1(deg: i), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: i)
            }
            for i in 1 ... n3 - 1 {
                matrix.rows[0][1].add(left: Way(type: .a21, len: 2 * (n3 - i) - 1), right: Way.beta2(deg: i), koef: i)
            }
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[3][0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way.alpha1(deg: n3 - i - 1), koef: i)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[3][1].add(left: Way.beta2(deg: n3 - i - 1), right: Way(type: .a12, len: 2 * i + 1), koef: i + 1)
        }
        matrix.rows[3][4].add(left: Way.e2, right: Way(type: .a13, len: 1), koef: 1)
    }
}

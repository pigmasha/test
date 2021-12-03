//
//  ShiftHH+x0.swift
//
//  Created by M on 02.12.2021.
//

import Foundation

extension ShiftHH {
    func shiftX0(_ label: String) -> Bool {
        switch label {
        case "x1":
            switch shiftDeg {
            case 0: shiftX10()
            case 1: shiftX11()
            case 2: shiftX12()
            default: break
            }
            return true
        case "x3":
            switch shiftDeg {
            case 0: shiftX30()
            case 1: shiftX31()
            case 2: shiftX32()
            default: break
            }
            return true
        case "x1_h":
            switch shiftDeg {
            case 0: shiftX1h0()
            case 1: shiftX1h1()
            case 2: shiftX1h2()
            case 3: shiftX1h3()
            case 4: shiftX1h4()
            default: break
            }
            return true
        case "x3_h":
            switch shiftDeg {
            case 0: shiftX3h0()
            case 1: shiftX3h1()
            case 2: shiftX3h2()
            case 3: shiftX3h3()
            case 4: shiftX3h4()
            default: break
            }
            return true
        default:
            return false
        }
    }

    // MARK: - x1
    private func shiftX10() {
        matrix.rows[0][0].add(left: Way.alpha1, right: Way(type: .a12, len: 1), koef: 1)
    }

    private func shiftX11() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: Way.alpha1(deg: i + 1), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -i - 1)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[0][1].add(left: Way(type: .a21, len: 2 * (n3 - i) + 1), right: Way.beta2(deg: i), koef: -i)
        }
        matrix.rows[1][1].add(left: Way.beta2, right: Way(type: .a32, len: 2 * n1 - 1), koef: n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[3][0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way.alpha1(deg: n3 - i), koef: -i)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[3][1].add(left: Way.beta2(deg: n3 - i), right: Way(type: .a12, len: 2 * i + 1), koef: -i - 1)
        }
    }

    private func shiftX12() {
        let n3 = PathAlg.n3
        matrix.rows[0][0].add(left: Way.alpha1, right: Way(type: .a12, len: 1), koef: -1)
        matrix.rows[1][0].add(left: Way(type: .a12, len: 3), right: Way.e2, koef: n3)
        matrix.rows[1][1].add(left: Way.beta2, right: Way(type: .a23, len: 1), koef: n3)
        matrix.rows[0][3].add(left: Way(type: .a21, len: 1), right: Way.alpha1, koef: n3)
    }

    // MARK: - x3
    private func shiftX30() {
        matrix.rows[2][2].add(left: Way.alpha3, right: Way(type: .a31, len: 1), koef: 1)
    }

    private func shiftX31() {
        let (n2, n3) = (PathAlg.n2, PathAlg.n3)
        for i in 0 ... n2 - 1 {
            matrix.rows[2][2].add(left: Way.alpha3(deg: i + 1), right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: -i - 1)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[2][0].add(left: Way(type: .a13, len: 2 * (n2 - i) + 1), right: Way.beta1(deg: i), koef: -i)
        }
        matrix.rows[0][0].add(left: Way.beta1, right: Way(type: .a21, len: 2 * n3 - 1), koef: n2)
        for i in 0 ... n2 - 1 {
            matrix.rows[5][2].add(left: Way(type: .a31, len: 2 * i + 1), right: Way.alpha3(deg: n2 - i), koef: -i)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][0].add(left: Way.beta1(deg: n2 - i), right: Way(type: .a31, len: 2 * i + 1), koef: -i - 1)
        }
    }

    private func shiftX32() {
        let n2 = PathAlg.n2
        matrix.rows[2][2].add(left: Way.alpha3, right: Way(type: .a31, len: 1), koef: -1)
        matrix.rows[0][2].add(left: Way(type: .a31, len: 3), right: Way.e1, koef: n2)
        matrix.rows[0][0].add(left: Way.beta1, right: Way(type: .a12, len: 1), koef: n2)
        matrix.rows[2][5].add(left: Way(type: .a13, len: 1), right: Way.alpha3, koef: n2)
    }

    // MARK: - x1_h
    private func shiftX1h0() {
        matrix.rows[0][0].add(left: Way.alpha1, right: Way(type: .a12, len: 1), koef: 1)
    }

    private func shiftX1h1() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: Way.alpha1(deg: i + 1), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -i - 1)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[0][1].add(left: Way(type: .a21, len: 2 * (n3 - i) + 1), right: Way.beta2(deg: i), koef: i)
        }
        matrix.rows[1][1].add(left: Way.beta2, right: Way(type: .a32, len: 2 * n1 - 1), koef: -n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[3][0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way.alpha1(deg: n3 - i), koef: -i)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[3][1].add(left: Way.beta2(deg: n3 - i), right: Way(type: .a12, len: 2 * i + 1), koef: i + 1)
        }
    }

    private func shiftX1h2() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        matrix.rows[0][0].add(left: Way.alpha1, right: Way(type: .a12, len: 1), koef: n3 + 1)
        matrix.rows[1][1].add(left: Way.beta2, right: Way(type: .a23, len: 1), koef: n3)
        matrix.rows[8][0].add(left: Way.alpha1, right: Way(type: .a32, len: 2 * n1 - 1), koef: -n3)
        matrix.rows[0][3].add(left: Way(type: .a21, len: 1), right: Way.alpha1, koef: -n3)
    }

    private func shiftX1h3() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: Way.alpha1(deg: i + 1), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: i + 1)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[0][1].add(left: Way(type: .a21, len: 2 * (n3 - i) + 1), right: Way.beta2(deg: i), koef: i)
        }
        matrix.rows[1][1].add(left: Way.beta2, right: Way(type: .a32, len: 2 * n1 - 1), koef: 2 * n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[3][0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way.alpha1(deg: n3 - i), koef: i)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[3][1].add(left: Way.beta2(deg: n3 - i), right: Way(type: .a12, len: 2 * i + 1), koef: i + 1)
        }
        matrix.rows[0][8].add(left: Way.alpha1, right: Way(type: .a23, len: 1), koef: n3)
    }

    private func shiftX1h4() {
        let n3 = PathAlg.n3
        matrix.rows[0][0].add(left: Way.alpha1, right: Way(type: .a12, len: 1), koef: -n3 + 1)
        matrix.rows[1][0].add(left: Way(type: .a12, len: 3), right: Way.e2, koef: 2 * n3)
        matrix.rows[1][1].add(left: Way.beta2, right: Way(type: .a23, len: 1), koef: 2 * n3)
        matrix.rows[0][3].add(left: Way(type: .a21, len: 1), right: Way.alpha1, koef: -n3)
    }

    // MARK: - x3_h
    private func shiftX3h0() {
        matrix.rows[2][2].add(left: Way.alpha3, right: Way(type: .a31, len: 1), koef: 1)
    }

    private func shiftX3h1() {
        let (n2, n3) = (PathAlg.n2, PathAlg.n3)
        for i in 0 ... n2 - 1 {
            matrix.rows[2][2].add(left: Way.alpha3(deg: i + 1), right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: -i - 1)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[2][0].add(left: Way(type: .a13, len: 2 * (n2 - i) + 1), right: Way.beta1(deg: i), koef: i)
        }
        matrix.rows[0][0].add(left: Way.beta1, right: Way(type: .a21, len: 2 * n3 - 1), koef: -n2)
        for i in 0 ... n2 - 1 {
            matrix.rows[5][2].add(left: Way(type: .a31, len: 2 * i + 1), right: Way.alpha3(deg: n2 - i), koef: -i)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][0].add(left: Way.beta1(deg: n2 - i), right: Way(type: .a31, len: 2 * i + 1), koef: i + 1)
        }
    }

    private func shiftX3h2() {
        let (n2, n3) = (PathAlg.n2, PathAlg.n3)
        matrix.rows[2][2].add(left: Way.alpha3, right: Way(type: .a31, len: 1), koef: n2 + 1)
        matrix.rows[0][0].add(left: Way.beta1, right: Way(type: .a12, len: 1), koef: n2)
        matrix.rows[7][2].add(left: Way.alpha3, right: Way(type: .a21, len: 2 * n3 - 1), koef: -n2)
        matrix.rows[2][5].add(left: Way(type: .a13, len: 1), right: Way.alpha3, koef: -n2)
    }

    private func shiftX3h3() {
        let (n2, n3) = (PathAlg.n2, PathAlg.n3)
        for i in 0 ... n2 - 1 {
            matrix.rows[2][2].add(left: Way.alpha3(deg: i + 1), right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: i + 1)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[2][0].add(left: Way(type: .a13, len: 2 * (n2 - i) + 1), right: Way.beta1(deg: i), koef: i)
        }
        matrix.rows[0][0].add(left: Way.beta1, right: Way(type: .a21, len: 2 * n3 - 1), koef: 2 * n2)
        for i in 0 ... n2 - 1 {
            matrix.rows[5][2].add(left: Way(type: .a31, len: 2 * i + 1), right: Way.alpha3(deg: n2 - i), koef: i)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][0].add(left: Way.beta1(deg: n2 - i), right: Way(type: .a31, len: 2 * i + 1), koef: i + 1)
        }
        matrix.rows[2][7].add(left: Way.alpha3, right: Way(type: .a12, len: 1), koef: n2)
    }

    private func shiftX3h4() {
        let n2 = PathAlg.n2
        matrix.rows[2][2].add(left: Way.alpha3, right: Way(type: .a31, len: 1), koef: -n2 + 1)
        matrix.rows[0][2].add(left: Way(type: .a31, len: 3), right: Way.e1, koef: 2 * n2)
        matrix.rows[0][0].add(left: Way.beta1, right: Way(type: .a12, len: 1), koef: 2 * n2)
        matrix.rows[2][5].add(left: Way(type: .a13, len: 1), right: Way.alpha3, koef: -n2)
    }
}

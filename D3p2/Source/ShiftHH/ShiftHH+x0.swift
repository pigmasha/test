//
//  ShiftHH+x0.swift
//
//  Created by M on 02.12.2021.
//

import Foundation

extension ShiftHH {
    func shiftX0(_ label: String) -> Bool {
        switch label {
        case "x3":
            switch shiftDeg {
            case 0: shiftX10()
            case 1: shiftX11()
            default: break
            }
            return true
        case "x4":
            switch shiftDeg {
            case 0: shiftX30()
            case 1: shiftX31()
            default: break
            }
            return true
        default:
            return false
        }
    }

    private func putX1(at pos: (Int, Int), koef k: Int, overline: Bool) {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i + 1), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -k * (i + 1))
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a21, len: 2 * (n3 - i) + 1), right: Way.beta2(deg: i),
                                              koef: overline ? k * i : -k * i)
        }
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.beta2, right: Way(type: .a32, len: 2 * n1 - 1),
                                              koef: overline ? -k * n3 : k * n3)
    }

    private func putX2(at pos: (Int, Int), koef k: Int, overline: Bool) {
        let n3 = PathAlg.n3
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way.alpha1(deg: n3 - i), koef: -k * i)
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0 + 1].add(left: Way.beta2(deg: n3 - i), right: Way(type: .a12, len: 2 * i + 1),
                                              koef: overline ? k * (i + 1) : -k * (i + 1))
        }
    }

    private func putY1(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.alpha1, right: Way(type: .a12, len: 1), koef: k)
    }

    // MARK: - x1
    private func shiftX10() {
        matrix.rows[0][0].add(left: Way.alpha1, right: Way(type: .a12, len: 1), koef: 1)
    }

    private func shiftX11() {
        putX1(at: (0, 0), koef: 1, overline: false)
        putX2(at: (0, 3), koef: 1, overline: false)
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
}

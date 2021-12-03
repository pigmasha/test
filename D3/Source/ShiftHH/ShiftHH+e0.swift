//
//  ShiftHH+e0.swift
//  D3
//
//  Created by M on 27.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftE0(_ label: String) -> Bool {
        switch label {
        case "e":
            shiftDeg % 2 == 0 ? shiftEEven() : shiftEOdd()
            return true
        case "h1":
            shiftDeg % 2 == 0 ? shiftE1Even() : shiftE1Odd()
            return true
        case "h2":
            shiftDeg % 2 == 0 ? shiftE2Even() : shiftE2Odd()
            return true
        default:
            return false
        }
    }

    // MARK: - e
    private func shiftEEven() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            matrix.rows[3 * i][3 * i].add(left: i0 == 2 || i0 == 4 ? Way.e2 : Way.e1,
                                          right: i0 == 1 || i0 == 3 ? Way.e2 : Way.e1, koef: 1)
            matrix.rows[3 * i + 1][3 * i + 1].add(left: i0 == 2 || i0 == 4 ? Way.e3 : Way.e2,
                                                  right: i0 == 1 || i0 == 3 ? Way.e3 : Way.e2, koef: 1)
            matrix.rows[3 * i + 2][3 * i + 2].add(left: i0 == 2 || i0 == 4 ? Way.e1 : Way.e3,
                                                  right: i0 == 1 || i0 == 3 ? Way.e1 : Way.e3, koef: 1)
        }
    }

    private func shiftEOdd() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            matrix.rows[3 * i][3 * i].add(left: i0 == 1 || i0 == 5 ? Way.e2 : Way.e1,
                                          right: i0 == 0 || i0 == 4 ? Way.e2 : Way.e1, koef: 1)
            matrix.rows[3 * i + 1][3 * i + 1].add(left: i0 == 1 || i0 == 5 ? Way.e3 : Way.e2,
                                                  right: i0 == 0 || i0 == 4 ? Way.e3 : Way.e2, koef: 1)
            matrix.rows[3 * i + 2][3 * i + 2].add(left: i0 == 1 || i0 == 5 ? Way.e1 : Way.e3,
                                                  right: i0 == 0 || i0 == 4 ? Way.e1 : Way.e3, koef: 1)
        }
    }

    // MARK: - e1
    private func shiftE1Even() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[0][15].add(left: Way.e1, right: Way.e1, koef: 1)
        matrix.rows[1][16].add(left: Way.e2, right: Way.e2, koef: 1)
        matrix.rows[2][17].add(left: Way.e3, right: Way.e3, koef: 1)
        if shiftDeg == 0 { return }
        matrix.rows[6][12].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta1(deg: n2 - 1), koef: 1)
        matrix.rows[7][13].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta2(deg: n3 - 1), koef: 1)
        matrix.rows[8][14].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            if i0 == 0 || i0 == 2 || i0 == 3 { continue }
            matrix.rows[3 * i][3 * (i + 6)].add(left: i0 == 4 ? Way.e2 : Way.e1, right: i0 == 1 ? Way.e2 : Way.e1, koef: -1)
            matrix.rows[3 * i + 1][3 * (i + 6) + 1].add(left: i0 == 4 ? Way.e3 : Way.e2, right: i0 == 1 ? Way.e3 : Way.e2, koef: -1)
            matrix.rows[3 * i + 2][3 * (i + 6) + 2].add(left: i0 == 4 ? Way.e1 : Way.e3, right: i0 == 1 ? Way.e1 : Way.e3, koef: -1)
        }
        if shiftDeg == 2 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[9][3].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta2(deg: n3 - 1), koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[10][4].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[11][5].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta1(deg: n2 - 1), koef: 1)
        }
        if n1 != 1 || n2 != 1 || n3 != 1 || shiftDeg < 6 { return }
        for i in 0 ..< shiftDeg - 5 {
            let i0 = i % 6
            if i0 == 1 || i0 == 4 || i0 == 5 { continue }
            matrix.rows[3 * (i + 6)][3 * i].add(left: i0 == 2 ? Way.e2 : Way.e1, right: i0 == 3 ? Way.e2 : Way.e1, koef: 1)
            matrix.rows[3 * (i + 6) + 1][3 * i + 1].add(left: i0 == 2 ? Way.e3 : Way.e2, right: i0 == 3 ? Way.e3 : Way.e2, koef: 1)
            matrix.rows[3 * (i + 6) + 2][3 * i + 2].add(left: i0 == 2 ? Way.e1 : Way.e3, right: i0 == 3 ? Way.e1 : Way.e3, koef: 1)
        }
    }

    private func shiftE1Odd() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[0][12].add(left: Way.alpha1(deg: i), right: Way.beta2(deg: n3 - 1 - i), koef: -1)
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[1][13].add(left: Way.alpha2(deg: i), right: Way.beta3(deg: n1 - 1 - i), koef: -1)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[2][14].add(left: Way.alpha3(deg: i), right: Way.beta1(deg: n2 - 1 - i), koef: -1)
        }
        if n3 != 1 {
            for i in 0 ... n3 - 2 {
                matrix.rows[3][12].add(left: Way(type: .a12, len: 2 * i + 1), right: Way(type: .a12, len: 2 * (n3 - i - 1) - 1), koef: -1)
            }
        }
        if n1 != 1 {
            for i in 0 ... n1 - 2 {
                matrix.rows[4][13].add(left: Way(type: .a23, len: 2 * i + 1), right: Way(type: .a23, len: 2 * (n1 - i - 1) - 1), koef: -1)
            }
        }
        if n2 != 1 {
            for i in 0 ... n2 - 2 {
                matrix.rows[5][14].add(left: Way(type: .a31, len: 2 * i + 1), right: Way(type: .a31, len: 2 * (n2 - i - 1) - 1), koef: -1)
            }
        }
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            if i0 == 0 || i0 == 3 || i0 == 5 { continue }
            matrix.rows[3 * i][3 * (i + 6)].add(left: i0 == 1 ? Way.e2 : Way.e1, right: i0 == 4 ? Way.e2 : Way.e1, koef: -1)
            matrix.rows[3 * i + 1][3 * (i + 6) + 1].add(left: i0 == 1 ? Way.e3 : Way.e2, right: i0 == 4 ? Way.e3 : Way.e2, koef: -1)
            matrix.rows[3 * i + 2][3 * (i + 6) + 2].add(left: i0 == 1 ? Way.e1 : Way.e3, right: i0 == 4 ? Way.e1 : Way.e3, koef: -1)
        }
        if shiftDeg == 1 { return }
        if n3 == 1 {
            matrix.rows[11][8].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
        }
        if n1 == 1 {
            matrix.rows[9][6].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta1(deg: n2 - 1), koef: 1)
        }
        if n2 == 1 {
            matrix.rows[10][7].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta2(deg: n3 - 1), koef: 1)
        }
        if n1 != 1 || n2 != 1 || n3 != 1 || shiftDeg < 5 { return }
        matrix.rows[15][3].add(left: Way.e2, right: Way.e1, koef: 1)
        matrix.rows[16][4].add(left: Way.e3, right: Way.e2, koef: 1)
        matrix.rows[17][5].add(left: Way.e1, right: Way.e3, koef: 1)
        for i in 0 ..< shiftDeg - 5 {
            let i0 = i % 6
            if i0 == 1 || i0 == 2 || i0 == 4 { continue }
            matrix.rows[3 * (i + 6)][3 * i].add(left: i0 == 5 ? Way.e2 : Way.e1, right: i0 == 0 ? Way.e2 : Way.e1, koef: 1)
            matrix.rows[3 * (i + 6) + 1][3 * i + 1].add(left: i0 == 5 ? Way.e3 : Way.e2, right: i0 == 0 ? Way.e3 : Way.e2, koef: 1)
            matrix.rows[3 * (i + 6) + 2][3 * i + 2].add(left: i0 == 5 ? Way.e1 : Way.e3, right: i0 == 0 ? Way.e1 : Way.e3, koef: 1)
        }
    }

    // MARK: - e2
    private func shiftE2Even() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            if i0 == 1 || i0 == 4 || i0 == 5 { continue }
            matrix.rows[3 * i][3 * (i + 6)].add(left: i0 == 2 ? Way.e2 : Way.e1, right: i0 == 3 ? Way.e2 : Way.e1, koef: 1)
            matrix.rows[3 * i + 1][3 * (i + 6) + 1].add(left: i0 == 2 ? Way.e3 : Way.e2, right: i0 == 3 ? Way.e3 : Way.e2, koef: 1)
            matrix.rows[3 * i + 2][3 * (i + 6) + 2].add(left: i0 == 2 ? Way.e1 : Way.e3, right: i0 == 3 ? Way.e1 : Way.e3, koef: 1)
        }
        if shiftDeg == 0 { return }
        matrix.rows[3][9].add(left: Way.beta1(deg: n2 - 1), right: Way.alpha2(deg: n1 - 1), koef: 1)
        matrix.rows[4][10].add(left: Way.beta2(deg: n3 - 1), right: Way.alpha3(deg: n2 - 1), koef: 1)
        matrix.rows[5][11].add(left: Way.beta3(deg: n1 - 1), right: Way.alpha1(deg: n3 - 1), koef: 1)
        if shiftDeg == 2 { return }
        if n1 == 1 && n2 == 1 {
            matrix.rows[12][6].add(left: Way.beta2(deg: n3 - 1), right: Way.alpha1(deg: n3 - 1), koef: 1)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[13][7].add(left: Way.beta3(deg: n1 - 1), right: Way.alpha2(deg: n1 - 1), koef: 1)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[14][8].add(left: Way.beta1(deg: n2 - 1), right: Way.alpha3(deg: n2 - 1), koef: 1)
        }
        if n1 != 1 || n2 != 1 || n3 != 1 || shiftDeg < 6 { return }
        matrix.rows[15][0].add(left: Way.e1, right: Way.e1, koef: 1)
        matrix.rows[16][1].add(left: Way.e2, right: Way.e2, koef: 1)
        matrix.rows[17][2].add(left: Way.e3, right: Way.e3, koef: 1)
        for i in 0 ..< shiftDeg - 5 {
            let i0 = i % 6
            if i0 == 0 || i0 == 2 || i0 == 3 { continue }
            matrix.rows[3 * (i + 6)][3 * i].add(left: i0 == 4 ? Way.e2 : Way.e1, right: i0 == 1 ? Way.e2 : Way.e1, koef: -1)
            matrix.rows[3 * (i + 6) + 1][3 * i + 1].add(left: i0 == 4 ? Way.e3 : Way.e2, right: i0 == 1 ? Way.e3 : Way.e2, koef: -1)
            matrix.rows[3 * (i + 6) + 2][3 * i + 2].add(left: i0 == 4 ? Way.e1 : Way.e3, right: i0 == 1 ? Way.e1 : Way.e3, koef: -1)
        }
    }

    private func shiftE2Odd() {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[3][15].add(left: Way.beta2(deg: i), right: Way.alpha1(deg: n3 - 1 - i), koef: 1)
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[4][16].add(left: Way.beta3(deg: i), right: Way.alpha2(deg: n1 - 1 - i), koef: 1)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][17].add(left: Way.beta1(deg: i), right: Way.alpha3(deg: n2 - 1 - i), koef: 1)
        }
        if n3 != 1 {
            for i in 0 ... n3 - 2 {
                matrix.rows[0][15].add(left: Way(type: .a21, len: 2 * i + 1), right: Way(type: .a21, len: 2 * (n3 - i - 1) - 1), koef: 1)
            }
        }
        if n1 != 1 {
            for i in 0 ... n1 - 2 {
                matrix.rows[1][16].add(left: Way(type: .a32, len: 2 * i + 1), right: Way(type: .a32, len: 2 * (n1 - i - 1) - 1), koef: 1)
            }
        }
        if n2 != 1 {
            for i in 0 ... n2 - 2 {
                matrix.rows[2][17].add(left: Way(type: .a13, len: 2 * i + 1), right: Way(type: .a13, len: 2 * (n2 - i - 1) - 1), koef: 1)
            }
        }
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            if i0 == 1 || i0 == 2 || i0 == 4 { continue }
            matrix.rows[3 * i][3 * (i + 6)].add(left: i0 == 5 ? Way.e2 : Way.e1, right: i0 == 0 ? Way.e2 : Way.e1, koef: 1)
            matrix.rows[3 * i + 1][3 * (i + 6) + 1].add(left: i0 == 5 ? Way.e3 : Way.e2, right: i0 == 0 ? Way.e3 : Way.e2, koef: 1)
            matrix.rows[3 * i + 2][3 * (i + 6) + 2].add(left: i0 == 5 ? Way.e1 : Way.e3, right: i0 == 0 ? Way.e1 : Way.e3, koef: 1)
        }
        if shiftDeg == 1 { return }
        if n3 == 1 {
            matrix.rows[8][11].add(left: Way.beta3(deg: n1 - 1), right: Way.alpha3(deg: n2 - 1), koef: 1)
        }
        if n1 == 1 {
            matrix.rows[6][9].add(left: Way.beta1(deg: n2 - 1), right: Way.alpha1(deg: n3 - 1), koef: 1)
        }
        if n2 == 1 {
            matrix.rows[7][10].add(left: Way.beta2(deg: n3 - 1), right: Way.alpha2(deg: n1 - 1), koef: 1)
        }
        if n1 != 1 || n2 != 1 || n3 != 1 || shiftDeg < 5 { return }
        matrix.rows[12][0].add(left: Way.e1, right: Way.e2, koef: -1)
        matrix.rows[13][1].add(left: Way.e2, right: Way.e3, koef: -1)
        matrix.rows[14][2].add(left: Way.e3, right: Way.e1, koef: -1)
        for i in 0 ..< shiftDeg - 5 {
            let i0 = i % 6
            if i0 == 0 || i0 == 3 || i0 == 5 { continue }
            matrix.rows[3 * (i + 6)][3 * i].add(left: i0 == 1 ? Way.e2 : Way.e1, right: i0 == 4 ? Way.e2 : Way.e1, koef: -1)
            matrix.rows[3 * (i + 6) + 1][3 * i + 1].add(left: i0 == 1 ? Way.e3 : Way.e2, right: i0 == 4 ? Way.e3 : Way.e2, koef: -1)
            matrix.rows[3 * (i + 6) + 2][3 * i + 2].add(left: i0 == 1 ? Way.e1 : Way.e3, right: i0 == 4 ? Way.e1 : Way.e3, koef: -1)
        }
    }
}

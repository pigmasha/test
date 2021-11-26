//
//  ShiftHH+w.swift
//
//  Created by M on 23.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftW() {
        switch shiftDeg {
        case 0: shiftW0()
        case 1: shiftW1()
        case 2: shiftW2()
        default: break
        }
    }

    private func shiftW0() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: n1 * n2)
        matrix.rows[1][1].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: n2 * n3)
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: n3 * n1)
    }

    private func shiftW1() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3

        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: i == 0 ? Way.e1 : Way(type: .a12, len: 2 * i),
                                  right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: n1 * n2 * n3)
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[1][1].add(left: i == 0 ? Way.e2 : Way(type: .a23, len: 2 * i),
                                  right: Way(type: .a32, len: 2 * (n1 - i) - 1), koef: n1 * n2 * n3)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[2][2].add(left: i == 0 ? Way.e3 : Way(type: .a31, len: 2 * i),
                                  right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: n1 * n2 * n3)
        }
        ///
        for i in 0 ...  n3 - 1 {
            matrix.rows[3][0].add(left: Way(type: .a12, len: 2 * i + 1),
                                  right: i == n3 - 1 ? Way.e1 : Way(type: .a12, len: 2 * (n3 - i - 1)), koef: n1 * n2 * n3)
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[4][1].add(left: Way(type: .a23, len: 2 * i + 1),
                                  right: i == n1 - 1 ? Way.e2 : Way(type: .a23, len: 2 * (n1 - i - 1)), koef: n1 * n2 * n3)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][2].add(left: Way(type: .a31, len: 2 * i + 1),
                                  right: i == n2 - 1 ? Way.e3 : Way(type: .a31, len: 2 * (n2 - i - 1)), koef: n1 * n2 * n3)
        }
        ///
        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: i == 0 ? Way.e1 : Way(type: .a12, len: 2 * i),
                                  right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -n1 * n2 * (i + 1))
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[1][1].add(left: i == 0 ? Way.e2 : Way(type: .a23, len: 2 * i),
                                  right: Way(type: .a32, len: 2 * (n1 - i) - 1), koef: -n2 * n3 * (i + 1))
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[2][2].add(left: i == 0 ? Way.e3 : Way(type: .a31, len: 2 * i),
                                  right: Way(type: .a13, len: 2 * (n2 - i) - 1), koef: -n1 * n3 * (i + 1))
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[3][0].add(left: Way(type: .a12, len: 2 * i + 1),
                                  right: i == n3 - 1 ? Way.e1 : Way(type: .a12, len: 2 * (n3 - i - 1)), koef: -n1 * n2 * (i + 1))
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[4][1].add(left: Way(type: .a23, len: 2 * i + 1),
                                  right: i == n1 - 1 ? Way.e2 : Way(type: .a23, len: 2 * (n1 - i - 1)), koef: -n2 * n3 * (i + 1))
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][2].add(left: Way(type: .a31, len: 2 * i + 1),
                                  right: i == n2 - 1 ? Way.e3 : Way(type: .a31, len: 2 * (n2 - i - 1)), koef: -n1 * n3 * (i + 1))
        }
        for i in 0 ... n3 - 1 {
            matrix.rows[3][1].add(left: i == n3 - 1 ? Way.e2 : Way(type: .a21, len: 2 * (n3 - i - 1)),
                                  right: Way(type: .a12, len: 2 * i + 1), koef: -n1 * n2 * (i + 1))
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[4][2].add(left: i == n1 - 1 ? Way.e3 : Way(type: .a32, len: 2 * (n1 - i - 1)),
                                  right: Way(type: .a23, len: 2 * i + 1), koef: -n2 * n3 * (i + 1))
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[5][0].add(left: i == n2 - 1 ? Way.e1 : Way(type: .a13, len: 2 * (n2 - i - 1)),
                                  right: Way(type: .a31, len: 2 * i + 1), koef: -n3 * n1 * (i + 1))
        }
        if n3 > 1 {
            for i in 1 ... n3 - 1 {
                matrix.rows[0][1].add(left: Way(type: .a21, len: 2 * (n3 - i) - 1),
                                      right: Way(type: .a21, len: 2 * i), koef: -n1 * n2 * i)
            }
        }
        if n1 > 1 {
            for i in 1 ... n1 - 1 {
                matrix.rows[1][2].add(left: Way(type: .a32, len: 2 * (n1 - i) - 1),
                                      right: Way(type: .a32, len: 2 * i), koef: -n2 * n3 * i)
            }
        }
        if n2 > 1 {
            for i in 1 ... n2 - 1 {
                matrix.rows[2][0].add(left: Way(type: .a13, len: 2 * (n2 - i) - 1),
                                      right: Way(type: .a13, len: 2 * i), koef: -n3 * n1 * i)
            }
        }
        matrix.rows[1][6].add(left: Way.e2, right: Way(type: .a31, len: 1), koef: n1 * n3)
        matrix.rows[2][7].add(left: Way.e3, right: Way(type: .a12, len: 1), koef: n1 * n2)
        matrix.rows[0][8].add(left: Way.e1, right: Way(type: .a23, len: 1), koef: n2 * n3)
    }

    private func shiftW2() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
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
}

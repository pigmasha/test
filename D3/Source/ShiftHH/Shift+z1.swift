//
//  Shift+z1.swift
//  D3
//
//  Created by M on 23.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftZ1() {
        switch shiftDeg {
        case 0: shiftZ10()
        case 1: shiftZ11()
        case 2: shiftZ12()
        default: break
        }
    }

    private func shiftZ10() {
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: 1)
        matrix.rows[0][3].add(left: Way(type: .a21, len: 1), right: Way.e1, koef: -1)
    }

    private func shiftZ11() {
        let n3 = PathAlg.n3
        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: i == 0 ? Way.e1 : Way(type: .a12, len: 2 * i),
                                  right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -1)
        }
        matrix.putFi(from: (0, 0), to: (0, 3), koef: 1)

        matrix.rows[2][7].add(left: Way.e3, right: Way(type: .a12, len: 1), koef: 1)
        matrix.putFi(from: (6, 0), to: (3, 3), koef: 1)
    }

    private func shiftZ12() {
        let n1 = PathAlg.n1
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: -1)
        matrix.rows[0][2].add(left: Way(type: .a31, len: 1), right: Way.e1, koef: -1)
        matrix.rows[0][3].add(left: Way(type: .a21, len: 1), right: Way.e1, koef: 1)
        matrix.rows[0][5].add(left: Way.e1, right: Way(type: .a13, len: 1), koef: 1)
        matrix.rows[2][2].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: -1)
        matrix.rows[2][5].add(left: Way(type: .a13, len: 1), right: Way.e3, koef: 1)
        matrix.rows[3][5].add(left: Way.e1, right: Way(type: .a23, len: 2 * n1 - 1), koef: 1)
        matrix.rows[3][7].add(left: Way(type: .a21, len: 1), right: Way.e2, koef: -1)
        matrix.rows[6][2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e1, koef: -1)
        matrix.rows[6][10].add(left: Way.e2, right: Way(type: .a12, len: 1), koef: 1)
    }
}

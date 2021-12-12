//
//  Shift+z1.swift
//  D3
//
//  Created by M on 23.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftZ1() {
        if shiftDeg < 8 {
            shiftDeg % 2 == 0 ? shiftZ1Even() : shiftZ1Odd()
        }
    }

    private func shiftZ1Odd() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        let k = Utils.minusDeg(shiftDeg / 2)
        for i in 0 ... n3 - 1 {
            matrix.rows[0][0].add(left: Way.alpha1(deg: i), right: Way(type: .a21, len: 2 * (n3 - i) - 1), koef: -1)
        }
        matrix.putFi(from: (0, 0), to: (0, 3), koef: 1)
        matrix.rows[2][7].add(left: Way.e3, right: Way(type: .a12, len: 1), koef: k)
        matrix.putFi(from: (6, 0), to: (3, 3), koef: 1)
        if shiftDeg == 1 { return }
        matrix.rows[7][4].add(left: Way.e2, right: Way(type: .a23, len: 2 * n1 - 1), koef: k)
        matrix.putFi(from: (3, 6), to: (6, 9), koef: 1)
        matrix.rows[10][10].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: -k)
        matrix.putFi(from: (9, 9), to: (12, 6), koef: 1)
        if shiftDeg == 3 { return }
        matrix.rows[17][10].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e3, koef: -k)
        matrix.putFi(from: (9, 15), to: (12, 12), koef: -1)
        matrix.rows[12][15].add(left: Way.e1, right: Way(type: .a21, len: 1), koef: 1)
        matrix.putFi(from: (15, 12), to: (18, 15), koef: -1)
        if shiftDeg == 5 { return }
        matrix.rows[21][15].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        matrix.putFi(from: (15, 21), to: (18, 18), koef: -1)
        matrix.rows[21][22].add(left: Way.e2, right: Way(type: .a13, len: 1), koef: -1)
        matrix.putFi(from: (21, 21), to: (24, 18), koef: 1)
    }

    private func shiftZ1Even() {
        let (n1, n3) = (PathAlg.n1, PathAlg.n3)
        let k = Utils.minusDeg(shiftDeg / 2)
        matrix.rows[0][0].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: k)
        matrix.putFi(from: (0, 0), to: (3, 0), koef: -1)
        if shiftDeg == 0 { return }
        matrix.rows[7][2].add(left: Way.e3, right: Way(type: .a21, len: 2 * n3 - 1), koef: -1)
        matrix.putFi(from: (0, 6), to: (3, 3), koef: -1)
        matrix.rows[4][7].add(left: Way.e2, right: Way(type: .a32, len: 1), koef: -1)
        matrix.putFi(from: (6, 3), to: (9, 6), koef: -1)
        if shiftDeg == 2 { return }
        matrix.rows[13][7].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        matrix.putFi(from: (6, 12), to: (9, 9), koef: -1)
        matrix.rows[13][14].add(left: Way.e3, right: Way(type: .a21, len: 1), koef: 1)
        matrix.putFi(from: (12, 12), to: (15, 9), koef: 1)
        if shiftDeg == 4 { return }
        matrix.rows[15][12].add(left: Way.e1, right: Way(type: .a12, len: 2 * n3 - 1), koef: -1)
        matrix.putFi(from: (12, 15), to: (15, 18), koef: 1)
        matrix.rows[18][18].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: 1)
        matrix.putFi(from: (18, 18), to: (21, 15), koef: 1)
    }
}

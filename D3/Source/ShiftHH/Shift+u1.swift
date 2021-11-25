//
//  Shift+u1.swift
//
//  Created by M on 25.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftU1() {
        if shiftDeg == 0 { shiftU10() }
        //if shiftDeg == 1 { shiftZ11() }
    }

    private func shiftU10() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        matrix.rows[0][3].add(left: n3 == 1 ? Way.e1 : Way(type: .a12, len: 2 * n3 - 2), right: Way(type: .a12, len: 1), koef: 1)
        matrix.rows[1][4].add(left: n1 == 1 ? Way.e2 : Way(type: .a23, len: 2 * n1 - 2), right: Way(type: .a23, len: 1), koef: 1)
        matrix.rows[2][5].add(left: n2 == 1 ? Way.e3 : Way(type: .a31, len: 2 * n2 - 2), right: Way(type: .a31, len: 1), koef: 1)
    }
}

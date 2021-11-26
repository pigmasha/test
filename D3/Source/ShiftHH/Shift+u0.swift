//
//  Shift+u0.swift
//
//  Created by M on 25.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftU0(_ label: String) -> Bool {
        switch label {
        case "u1":
            switch shiftDeg {
            case 0: shiftU10()
            case 1: shiftU11()
            case 2: shiftU12()
            default: break
            }
            return true
        case "u2":
            switch shiftDeg {
            case 0: shiftU20()
            case 1: shiftU21()
            case 2: shiftU22()
            default: break
            }
            return true
        default: return false
        }
    }

    private func shiftU10() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        matrix.rows[0][3].add(left: n3 == 1 ? Way.e1 : Way(type: .a12, len: 2 * n3 - 2), right: Way(type: .a12, len: 1), koef: 1)
        matrix.rows[1][4].add(left: n1 == 1 ? Way.e2 : Way(type: .a23, len: 2 * n1 - 2), right: Way(type: .a23, len: 1), koef: 1)
        matrix.rows[2][5].add(left: n2 == 1 ? Way.e3 : Way(type: .a31, len: 2 * n2 - 2), right: Way(type: .a31, len: 1), koef: 1)
    }

    private func shiftU20() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        matrix.rows[0][6].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        matrix.rows[1][7].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        matrix.rows[2][8].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: 1)
    }

    private func shiftU11() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        if n1 == 1 {
            matrix.rows[1][5].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: -1)
        }
        if n2 == 1 {
            matrix.rows[2][3].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: -1)
        }
        if n3 == 1 {
            matrix.rows[0][4].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: -1)
        }
        matrix.rows[0][6].add(left: n3 == 1 ? Way.e1 : Way(type: .a12, len: 2 * n3 - 2), right: Way(type: .a21, len: 1), koef: 1)
        matrix.rows[0][7].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: -1)
        matrix.rows[1][7].add(left: n1 == 1 ? Way.e2 : Way(type: .a23, len: 2 * n1 - 2), right: Way(type: .a32, len: 1), koef: 1)
        matrix.rows[1][8].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: -1)
        matrix.rows[2][6].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: -1)
        matrix.rows[2][8].add(left: n2 == 1 ? Way.e3 : Way(type: .a31, len: 2 * n2 - 2), right: Way(type: .a13, len: 1), koef: 1)
        matrix.rows[3][6].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        matrix.rows[4][7].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        matrix.rows[5][8].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e3, koef: 1)
    }

    private func shiftU21() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        matrix.rows[0][10].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: 1)
        matrix.rows[1][11].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: 1)
        matrix.rows[2][9].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: 1)
        matrix.rows[3][2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: n3 == 1 ? Way.e1 : Way(type: .a12, len: 2 * n3 - 2), koef: 1)
        matrix.rows[4][0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: n1 == 1 ? Way.e2 : Way(type: .a23, len: 2 * n1 - 2), koef: 1)
        matrix.rows[5][1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: n2 == 1 ? Way.e3 : Way(type: .a31, len: 2 * n2 - 2), koef: 1)
    }

    private func shiftU12() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        if n1 == 1 {
            matrix.rows[8][0].add(left: n3 == 1 ? Way.e1 : Way(type: .a12, len: 2 * n3 - 2), right: Way(type: .a31, len: 2 * n2 - 1), koef: -1)
        }
        if n2 == 1 {
            matrix.rows[6][1].add(left: n1 == 1 ? Way.e2 : Way(type: .a23, len: 2 * n1 - 2), right: Way(type: .a12, len: 2 * n3 - 1), koef: -1)
        }
        if n3 == 1 {
            matrix.rows[7][2].add(left: n2 == 1 ? Way.e3 : Way(type: .a31, len: 2 * n2 - 2), right: Way(type: .a23, len: 2 * n1 - 1), koef: -1)
        }
        matrix.rows[0][3].add(left: Way.e1, right: Way(type: .a12, len: 2 * n3 - 1), koef: -1)
        matrix.rows[0][12].add(left: Way(type: .a21, len: 1), right: Way.e1, koef: 1)
        matrix.rows[0][14].add(left: Way.e1, right: Way(type: .a13, len: 1), koef: 1)
        matrix.rows[1][4].add(left: Way.e2, right: Way(type: .a23, len: 2 * n1 - 1), koef: -1)
        matrix.rows[1][12].add(left: Way.e2, right: Way(type: .a21, len: 1), koef: 1)
        matrix.rows[1][13].add(left: Way(type: .a32, len: 1), right: Way.e2, koef: 1)
        matrix.rows[2][5].add(left: Way.e3, right: Way(type: .a31, len: 2 * n2 - 1), koef: -1)
        matrix.rows[2][13].add(left: Way.e3, right: Way(type: .a32, len: 1), koef: 1)
        matrix.rows[2][14].add(left: Way(type: .a13, len: 1), right: Way.e3, koef: 1)
        matrix.rows[3][14].add(left: Way.e1, right: Way(type: .a23, len: 2 * n1 - 1), koef: 1)
        matrix.rows[4][12].add(left: Way.e2, right: Way(type: .a31, len: 2 * n2 - 1), koef: 1)
        matrix.rows[5][13].add(left: Way.e3, right: Way(type: .a12, len: 2 * n3 - 1), koef: 1)
    }

    private func shiftU22() {
        let n1 = PathAlg.n1
        let n2 = PathAlg.n2
        let n3 = PathAlg.n3
        if n1 == 1 {
            matrix.rows[5][0].add(left: Way(type: .a13, len: 2 * n2 - 1), right: n3 == 1 ? Way.e1 : Way(type: .a12, len: 2 * n3 - 2), koef: 1)
        }
        if n2 == 1 {
            matrix.rows[3][1].add(left: Way(type: .a21, len: 2 * n3 - 1), right: n1 == 1 ? Way.e2 : Way(type: .a23, len: 2 * n1 - 2), koef: 1)
        }
        if n3 == 1 {
            matrix.rows[4][2].add(left: Way(type: .a32, len: 2 * n1 - 1), right: n2 == 1 ? Way.e3 : Way(type: .a31, len: 2 * n2 - 2), koef: 1)
        }
        matrix.rows[0][6].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e1, koef: 1)
        matrix.rows[0][9].add(left: Way.e1, right: Way(type: .a12, len: 1), koef: -1)
        matrix.rows[0][11].add(left: Way(type: .a31, len: 1), right: Way.e1, koef: -1)
        matrix.rows[1][7].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e2, koef: 1)
        matrix.rows[1][9].add(left: Way(type: .a12, len: 1), right: Way.e2, koef: -1)
        matrix.rows[1][10].add(left: Way.e2, right: Way(type: .a23, len: 1), koef: -1)
        matrix.rows[2][8].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e3, koef: 1)
        matrix.rows[2][10].add(left: Way(type: .a23, len: 1), right: Way.e3, koef: -1)
        matrix.rows[2][11].add(left: Way.e3, right: Way(type: .a31, len: 1), koef: -1)
        matrix.rows[6][10].add(left: Way.e2, right: Way(type: .a13, len: 2 * n2 - 1), koef: 1)
        matrix.rows[7][11].add(left: Way.e3, right: Way(type: .a21, len: 2 * n3 - 1), koef: 1)
        matrix.rows[8][9].add(left: Way.e1, right: Way(type: .a32, len: 2 * n1 - 1), koef: 1)
    }
}

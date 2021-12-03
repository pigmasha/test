//
//  ShiftHH+q.swift
//
//  Created by M on 02.12.2021.
//

import Foundation

extension ShiftHH {
    func shiftQ() {
        shiftDeg % 2 == 0 ? shiftQEven() : shiftQOdd()
    }

    private func shiftQEven() {
        let n3 = PathAlg.n3
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6) * (i0 == 0 || i0 == 3 || i0 == 4 ? 1 : -1)
            switch i0 {
            case 2, 4:
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha1(deg: n3), right: Way.e3, koef: k)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha1(deg: n3), right: i0 == 1 || i0 == 3 ? Way.e2 : Way.e1, koef: k)
            }
        }
    }

    private func shiftQOdd() {
        let n3 = PathAlg.n3
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6) * (i0 == 1 || i0 == 3 || i0 == 4 ? 1 : -1)
            switch i0 {
            case 1, 5:
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha1(deg: n3), right: Way.e3, koef: k)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha1(deg: n3), right: i0 == 0 || i0 == 4 ? Way.e2 : Way.e1, koef: k)
            }
        }
    }
}

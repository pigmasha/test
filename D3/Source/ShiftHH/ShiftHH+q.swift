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

    private func putQ1(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: n3), right: Way.e1, koef: k)
    }

    private func putQ2(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: n3), right: Way.e2, koef: k)
    }

    private func putQ3(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha1(deg: n3), right: Way.e3, koef: k)
    }

    private func shiftQEven() {
        let k = Utils.minusDeg(shiftDeg / 2)
        put(items: [(sh: 0, x: 0, y: 0, k: k, f: putQ1, fi: false),
                    (sh: 5, x: 5, y: 5, k: -k, f: putQ1, fi: false),
                    (sh: 1, x: 1, y: 1, k: -k, f: putQ2, fi: false),
                    (sh: 3, x: 3, y: 3, k: k, f: putQ2, fi: false),
                    (sh: 2, x: 2, y: 2, k: -k, f: putQ3, fi: false),
                    (sh: 4, x: 4, y: 4, k: k, f: putQ3, fi: false)], kFlag: true)
    }

    private func shiftQOdd() {
        let k = Utils.minusDeg(shiftDeg / 2)
        put(items: [(sh: 0, x: 0, y: 0, k: -k, f: putQ2, fi: false),
                    (sh: 4, x: 4, y: 4, k: k, f: putQ2, fi: false),
                    (sh: 1, x: 1, y: 1, k: k, f: putQ3, fi: false),
                    (sh: 5, x: 5, y: 5, k: -k, f: putQ3, fi: false),
                    (sh: 2, x: 2, y: 2, k: -k, f: putQ1, fi: false),
                    (sh: 3, x: 3, y: 3, k: k, f: putQ1, fi: false)], kFlag: true)
    }
}

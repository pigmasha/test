//
//  ShiftHH+e0.swift
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
        case "e1_h":
            shiftDeg % 2 == 0 ? shiftE1Even() : shiftE1Odd()
            return true
        case "e2_h":
            shiftDeg % 2 == 0 ? shiftE2Even() : shiftE2Odd()
            return true
        default:
            return false
        }
    }

    private func putI1(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.e1, right: Way.e1, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.e2, right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.e3, right: Way.e3, koef: k)
    }

    private func putI2(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.e2, right: Way.e1, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.e3, right: Way.e2, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.e1, right: Way.e3, koef: k)
    }

    private func putJ1(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1][pos.0].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta1(deg: n2 - 1), koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta2(deg: n3 - 1), koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta3(deg: n1 - 1), koef: k)
    }

    private func putJ2(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n1 == 1 && n2 == 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta2(deg: n3 - 1), koef: k)
        }
        if n2 == 1 && n3 == 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta3(deg: n1 - 1), koef: k)
        }
        if n1 == 1 && n3 == 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta1(deg: n2 - 1), koef: k)
        }
    }

    private func putJ3(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i), right: Way.beta2(deg: n3 - 1 - i), koef: k)
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: i), right: Way.beta3(deg: n1 - 1 - i), koef: k)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: i), right: Way.beta1(deg: n2 - 1 - i), koef: k)
        }
    }

    private func putJ4(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n3 != 1 {
            for i in 0 ... n3 - 2 {
                matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way(type: .a12, len: 2 * (n3 - i - 1) - 1), koef: k)
            }
        }
        if n1 != 1 {
            for i in 0 ... n1 - 2 {
                matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a23, len: 2 * i + 1), right: Way(type: .a23, len: 2 * (n1 - i - 1) - 1), koef: k)
            }
        }
        if n2 != 1 {
            for i in 0 ... n2 - 2 {
                matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a31, len: 2 * i + 1), right: Way(type: .a31, len: 2 * (n2 - i - 1) - 1), koef: k)
            }
        }
    }

    private func putJ5(at pos: (Int, Int), koef k: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n3 == 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta3(deg: n1 - 1), koef: k)
        }
        if n1 == 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta1(deg: n2 - 1), koef: k)
        }
        if n2 == 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta2(deg: n3 - 1), koef: k)
        }
    }

    // MARK: - e
    private func shiftEEven() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putI1, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putI1, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putI2, fi: false),
                    (sh: 4, x: 4, y: 4, k: 1, f: putI2, fi: false),
                    (sh: 1, x: 1, y: 1, k: 1, f: putI2, fi: true),
                    (sh: 3, x: 3, y: 3, k: 1, f: putI2, fi: true)])
    }

    private func shiftEOdd() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putI2, fi: true),
                    (sh: 4, x: 4, y: 4, k: 1, f: putI2, fi: true),
                    (sh: 1, x: 1, y: 1, k: 1, f: putI2, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putI2, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putI1, fi: false),
                    (sh: 3, x: 3, y: 3, k: 1, f: putI1, fi: false)])
    }

    // MARK: - e1_h
    private func shiftE1Even() {
        putI1(at: (15, 0), koef: 1)
        if shiftDeg > 0 { putJ1(at: (12, 6), koef: 1) }
        put(items: [(sh: 1, x: 7, y: 1, k: -1, f: putI2, fi: true),
                    (sh: 4, x: 10, y: 4, k: -1, f: putI2, fi: false),
                    (sh: 5, x: 11, y: 5, k: -1, f: putI1, fi: false)])
        if shiftDeg > 2 { putJ2(at: (3, 9), koef: 1) }
        if PathAlg.N == 3 {
            put(items: [(sh: 6, x: 0, y: 6, k: 1, f: putI1, fi: false),
                        (sh: 8, x: 2, y: 8, k: 1, f: putI2, fi: false),
                        (sh: 9, x: 3, y: 9, k: 1, f: putI2, fi: true)])
        }
    }

    private func shiftE1Odd() {
        putJ3(at: (12, 0), koef: -1)
        putJ4(at: (12, 3), koef: -1)
        put(items: [(sh: 1, x: 7, y: 1, k: -1, f: putI2, fi: false),
                    (sh: 2, x: 8, y: 2, k: -1, f: putI1, fi: false),
                    (sh: 4, x: 10, y: 4, k: -1, f: putI2, fi: true)])
        if shiftDeg > 1 { putJ5(at: (6, 9), koef: 1) }
        if PathAlg.N == 3 && shiftDeg > 4 {
            putI2(at: (3, 15), koef: 1)
            put(items: [(sh: 6, x: 0, y: 6, k: 1, f: putI2, fi: true),
                        (sh: 9, x: 3, y: 9, k: 1, f: putI1, fi: false),
                        (sh: 11, x: 5, y: 11, k: 1, f: putI2, fi: false)])
        }
    }

    // MARK: - e2_h
    private func shiftE2Even() {
        put(items: [(sh: 0, x: 6, y: 0, k: 1, f: putI1, fi: false),
                    (sh: 2, x: 8, y: 2, k: 1, f: putI2, fi: false),
                    (sh: 3, x: 9, y: 3, k: 1, f: putI2, fi: true)])
        if shiftDeg > 0 {
            putJ1(at: (9, 3), koef: 1)
            matrix.putFi(at: (9, 3))
        }
        if shiftDeg > 2 {
            putJ2(at: (6, 12), koef: 1)
            matrix.putFi(at: (6, 12))
        }
        if PathAlg.N == 3 && shiftDeg > 5 {
            putI1(at: (0, 15), koef: 1)
            put(items: [(sh: 7, x: 1, y: 7, k: -1, f: putI2, fi: true),
                        (sh: 10, x: 4, y: 10, k: -1, f: putI2, fi: false),
                        (sh: 11, x: 5, y: 11, k: -1, f: putI1, fi: false)])
        }
    }

    private func shiftE2Odd() {
        putJ3(at: (15, 3), koef: 1)
        matrix.putFi(at: (15, 3))
        putJ4(at: (15, 0), koef: 1)
        matrix.putFi(at: (15, 0))
        put(items: [(sh: 0, x: 6, y: 0, k: 1, f: putI2, fi: true),
                    (sh: 3, x: 9, y: 3, k: 1, f: putI1, fi: false),
                    (sh: 5, x: 11, y: 5, k: 1, f: putI2, fi: false)])
        if shiftDeg > 1 {
            putJ5(at: (9, 6), koef: 1)
            matrix.putFi(at: (9, 6))
        }
        if PathAlg.N == 3 && shiftDeg > 4 {
            putI2(at: (0, 12), koef: -1)
            matrix.putFi(at: (0, 12))
            put(items: [(sh: 7, x: 1, y: 7, k: -1, f: putI2, fi: false),
                        (sh: 8, x: 2, y: 8, k: -1, f: putI1, fi: false),
                        (sh: 10, x: 4, y: 10, k: -1, f: putI2, fi: true)])
        }
    }
}

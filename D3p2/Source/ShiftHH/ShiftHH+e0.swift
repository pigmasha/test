//
//  ShiftHH+e0.swift
//
//  Created by M on 27.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftE0(_ label: String) -> Bool {
        switch label {
        case "y1":
            shiftDeg % 2 == 0 ? shiftEEven() : shiftEOdd()
            return true
        case "z1":
            shiftDeg % 2 == 0 ? shiftZ1Even() : shiftZ1Odd()
            return true
        case "z2":
            shiftDeg % 2 == 0 ? shiftZ2Even() : shiftZ2Odd()
            return true
        default:
            return false
        }
    }

    private func putI1(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.e1, right: Way.e1, koef: 1)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.e2, right: Way.e2, koef: 1)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.e3, right: Way.e3, koef: 1)
    }

    private func putI2(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.e2, right: Way.e1, koef: 1)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.e3, right: Way.e2, koef: 1)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.e1, right: Way.e3, koef: 1)
    }

    private func putJ1(at pos: (Int, Int)) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        matrix.rows[pos.1][pos.0].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta1(deg: n2 - 1), koef: 1)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta2(deg: n3 - 1), koef: 1)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
    }

    private func putJ2(at pos: (Int, Int)) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n1 == 1 && n2 == 1 && n3 > 1 {
            for i in 0 ... n3 - 1 {
                matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i), right: Way.beta2(deg: n3 - 1 - i), koef: 1)
            }
            matrix.rows[pos.1][pos.0 + 1].add(left: Way(type: .a21, len: 2 * n3 - 3), right: Way(type: .a23, len: 1), koef: 1)
            matrix.rows[pos.1][pos.0 + 2].add(left: Way(type: .a31, len: 1), right: Way(type: .a21, len: 2 * n3 - 3), koef: 1)
        }
        if n1 == 1 && n2 > 1 && n3 == 1 {
            for i in 0 ... n2 - 1 {
                matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: i), right: Way.beta1(deg: n2 - 1 - i), koef: 1)
            }
            matrix.rows[pos.1 + 2][pos.0].add(left: Way(type: .a13, len: 2 * n2 - 3), right: Way(type: .a12, len: 1), koef: 1)
            matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a23, len: 1), right: Way(type: .a13, len: 2 * n2 - 3), koef: 1)
        }
        if n1 > 1 && n2 == 1 && n3 == 1 {
            for i in 0 ... n1 - 1 {
                matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: i), right: Way.beta3(deg: n1 - 1 - i), koef: 1)
            }
            matrix.rows[pos.1 + 1][pos.0 + 2].add(left: Way(type: .a32, len: 2 * n1 - 3), right: Way(type: .a31, len: 1), koef: 1)
            matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a12, len: 1), right: Way(type: .a32, len: 2 * n1 - 3), koef: 1)
        }
    }

    private func putJ3(at pos: (Int, Int)) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i), right: Way.beta2(deg: n3 - 1 - i), koef: 1)
        }
        for i in 0 ... n1 - 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: i), right: Way.beta3(deg: n1 - 1 - i), koef: 1)
        }
        for i in 0 ... n2 - 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: i), right: Way.beta1(deg: n2 - 1 - i), koef: 1)
        }
    }

    private func putJ4(at pos: (Int, Int)) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n3 != 1 {
            for i in 0 ... n3 - 2 {
                matrix.rows[pos.1][pos.0].add(left: Way(type: .a12, len: 2 * i + 1), right: Way(type: .a12, len: 2 * (n3 - i - 1) - 1), koef: 1)
            }
        }
        if n1 != 1 {
            for i in 0 ... n1 - 2 {
                matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a23, len: 2 * i + 1), right: Way(type: .a23, len: 2 * (n1 - i - 1) - 1), koef: 1)
            }
        }
        if n2 != 1 {
            for i in 0 ... n2 - 2 {
                matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a31, len: 2 * i + 1), right: Way(type: .a31, len: 2 * (n2 - i - 1) - 1), koef: 1)
            }
        }
    }

    private func putJ5(at pos: (Int, Int)) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n3 == 1 && n2 > 1 && n1 > 1 {
            matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: n2 - 1), right: Way.beta3(deg: n1 - 1), koef: 1)
        }
        if n1 == 1 && n2 > 1 && n3 > 1 {
            matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: n3 - 1), right: Way.beta1(deg: n2 - 1), koef: 1)
        }
        if n2 == 1 && n3 > 1 && n1 > 1 {
            matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: n1 - 1), right: Way.beta2(deg: n3 - 1), koef: 1)
        }
        if n1 == 1 && n2 == 1 && n3 > 1 {
            for i in 0 ... n3 - 1 {
                matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: i), right: Way.alpha1(deg: n3 - i - 1), koef: 1)
                matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.beta2(deg: i), right: Way.beta2(deg: n3 - i - 1), koef: 1)
            }
        }
        if n1 == 1 && n2 > 1 && n3 == 1 {
            for i in 0 ... n2 - 1 {
                matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: i), right: Way.alpha3(deg: n2 - i - 1), koef: 1)
                matrix.rows[pos.1][pos.0].add(left: Way.beta1(deg: i), right: Way.beta1(deg: n2 - i - 1), koef: 1)
            }
        }
        if n1 > 1 && n2 == 1 && n3 == 1 {
            for i in 0 ... n1 - 1 {
                matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: i), right: Way.alpha2(deg: n1 - i - 1), koef: 1)
                matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.beta3(deg: i), right: Way.beta3(deg: n1 - i - 1), koef: 1)
            }
        }
    }

    private func putJ6(at pos: (Int, Int)) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n1 == 1 && n2 == 1 && n3 > 1 {
            matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a13, len: 1), right: Way(type: .a21, len: 2 * n3 - 3), koef: 1)
            matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a21, len: 2 * n3 - 3), right: Way(type: .a32, len: 1), koef: 1)
        }
        if n1 == 1 && n2 > 1 && n3 == 1 {
            matrix.rows[pos.1][pos.0 + 2].add(left: Way(type: .a32, len: 1), right: Way(type: .a13, len: 2 * n2 - 3), koef: 1)
            matrix.rows[pos.1 + 1][pos.0].add(left: Way(type: .a13, len: 2 * n2 - 3), right: Way(type: .a21, len: 1), koef: 1)
        }
        if n1 > 1 && n2 == 1 && n3 == 1 {
            matrix.rows[pos.1 + 2][pos.0 + 1].add(left: Way(type: .a21, len: 1), right: Way(type: .a32, len: 2 * n1 - 3), koef: 1)
            matrix.rows[pos.1][pos.0 + 2].add(left: Way(type: .a32, len: 2 * n1 - 3), right: Way(type: .a13, len: 1), koef: 1)
        }
    }

    private func putJ7(at pos: (Int, Int)) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if n1 == 1 && n2 == 1 && n3 > 1 {
            for i in 0 ... n3 - 2 {
                matrix.rows[pos.1][pos.0].add(left: Way(type: .a21, len: 2 * i + 1), right: Way(type: .a21, len: 2 * (n3 - i - 2) + 1), koef: 1)
            }
        }
        if n1 == 1 && n2 > 1 && n3 == 1 {
            for i in 0 ... n2 - 2 {
                matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way(type: .a13, len: 2 * i + 1), right: Way(type: .a13, len: 2 * (n2 - i - 2) + 1), koef: 1)
            }
        }
        if n1 > 1 && n2 == 1 && n3 == 1 {
            for i in 0 ... n1 - 2 {
                matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way(type: .a32, len: 2 * i + 1), right: Way(type: .a32, len: 2 * (n1 - i - 2) + 1), koef: 1)
            }
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

    // MARK: - z1
    private func shiftZ1Even() {
        putI1(at: (6, 0), koef: 1)
        if shiftDeg > 0 { putJ1(at: (3, 6)) }
        put(items: [(sh: 1, x: 4, y: 1, k: 1, f: putI2, fi: true),
                    (sh: 4, x: 7, y: 4, k: 1, f: putI2, fi: false),
                    (sh: 5, x: 8, y: 5, k: 1, f: putI1, fi: false)])
        if shiftDeg > 2 {
            putJ2(at: (0, 9))
            putJ7(at: (3, 9))
        }
        if PathAlg.N == 3 {
            put(items: [(sh: 3, x: 0, y: 3, k: 1, f: putI2, fi: true),
                        (sh: 6, x: 3, y: 6, k: 1, f: putI1, fi: false),
                        (sh: 8, x: 5, y: 8, k: 1, f: putI2, fi: false)])
        }
    }

    private func shiftZ1Odd() {
        putJ3(at: (3, 0))
        putJ4(at: (3, 3))
        put(items: [(sh: 1, x: 4, y: 1, k: 1, f: putI2, fi: false),
                    (sh: 2, x: 5, y: 2, k: 1, f: putI1, fi: false),
                    (sh: 4, x: 7, y: 4, k: 1, f: putI2, fi: true)])
        if shiftDeg > 1 { putJ5(at: (0, 9)) }
        if shiftDeg > 3 { putJ6(at: (0, 15)) }
        if PathAlg.N == 3 && shiftDeg > 1 {
            put(items: [(sh: 3, x: 0, y: 3, k: 1, f: putI1, fi: false),
                        (sh: 5, x: 2, y: 5, k: 1, f: putI2, fi: false),
                        (sh: 6, x: 3, y: 6, k: 1, f: putI2, fi: true)])
        }
    }

    // MARK: - z2
    private func shiftZ2Even() {
        put(items: [(sh: 0, x: 3, y: 0, k: 1, f: putI1, fi: false),
                    (sh: 2, x: 5, y: 2, k: 1, f: putI2, fi: false),
                    (sh: 3, x: 6, y: 3, k: 1, f: putI2, fi: true)])
        if shiftDeg > 0 {
            putJ1(at: (0, 3))
            matrix.putFi(at: (0, 3))
        }
        if shiftDeg > 2 {
            putJ2(at: (3, 12))
            matrix.putFi(at: (3, 12))
            putJ7(at: (0, 12))
            matrix.putFi(at: (0, 12))
        }
        if PathAlg.N == 3 && shiftDeg > 2 {
            put(items: [(sh: 4, x: 1, y: 4, k: 1, f: putI2, fi: false),
                        (sh: 5, x: 2, y: 5, k: 1, f: putI1, fi: false),
                        (sh: 7, x: 4, y: 7, k: 1, f: putI2, fi: true)])
        }
    }

    private func shiftZ2Odd() {
        putJ3(at: (6, 3))
        matrix.putFi(at: (6, 3))
        putJ4(at: (6, 0))
        matrix.putFi(at: (6, 0))
        put(items: [(sh: 0, x: 3, y: 0, k: 1, f: putI2, fi: true),
                    (sh: 3, x: 6, y: 3, k: 1, f: putI1, fi: false),
                    (sh: 5, x: 8, y: 5, k: 1, f: putI2, fi: false)])
        if shiftDeg > 1 {
            putJ5(at: (0, 6))
            matrix.putFi(at: (0, 6))
        }
        if shiftDeg > 3 {
            putJ6(at: (0, 12))
            matrix.putFi(at: (0, 12))
        }
        if PathAlg.N == 3 && shiftDeg > 1 {
            putI1(at: (0, 6), koef: 1)
            put(items: [(sh: 4, x: 1, y: 4, k: 1, f: putI2, fi: true),
                        (sh: 7, x: 4, y: 7, k: 1, f: putI2, fi: false),
                        (sh: 8, x: 5, y: 8, k: 1, f: putI1, fi: false)])
        }
    }
}

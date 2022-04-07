//
//  ShiftHH+c00.swift
//
//  Created by M on 22.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftC00(_ label: String) -> Bool {
        switch label {
        case "c1":
            shiftDeg % 2 == 0 ? shiftC1Even() : shiftC1Odd()
            return true
        case "c2":
            shiftDeg % 2 == 0 ? shiftC2Even() : shiftC2Odd()
            return true
        case "c3":
            shiftDeg % 2 == 0 ? shiftC3Even() : shiftC3Odd()
            return true
        case "p1":
            shiftDeg % 2 == 0 ? shiftP1Even() : shiftP1Odd()
            return true
        case "p2":
            shiftDeg % 2 == 0 ? shiftP2Even() : shiftP2Odd()
            return true
        case "p3":
            shiftDeg % 2 == 0 ? shiftP3Even() : shiftP3Odd()
            return true
        default:
            return false
        }
    }

    // MARK: - c1
    private func shiftC1Even() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 2, 4:
                matrix.rows[3 * i][3 * i].add(left: Way.beta2, right: Way.e1, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha1, right: Way.e3, koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha1, right: i % 6 == 0 || i % 6 == 5 ? Way.e1 : Way.e2, koef: 1)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.beta2, right: i % 6 == 0 || i % 6 == 5 ? Way.e2 : Way.e3, koef: 1)
            }
        }
    }

    private func shiftC1Odd() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 1, 5:
                matrix.rows[3 * i][3 * i].add(left: Way.beta2, right: Way.e1, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha1, right: Way.e3, koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha1, right: i % 6 == 0 || i % 6 == 4 ? Way.e2 : Way.e1, koef: 1)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.beta2, right: i % 6 == 0 || i % 6 == 4 ? Way.e3 : Way.e2, koef: 1)
            }
        }
    }

    // MARK: - c2
    private func shiftC2Even() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 2, 4:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha2, right: Way.e1, koef: 1)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.beta3, right: Way.e2, koef: 1)
            default:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha2, right: i % 6 == 0 || i % 6 == 5 ? Way.e2 : Way.e3, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta3, right: i % 6 == 0 || i % 6 == 5 ? Way.e3 : Way.e1, koef: 1)
            }
        }
    }

    private func shiftC2Odd() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 1, 5:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha2, right: Way.e1, koef: 1)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.beta3, right: Way.e2, koef: 1)
            default:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha2, right: i % 6 == 0 || i % 6 == 4 ? Way.e3 : Way.e2, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta3, right: i % 6 == 0 || i % 6 == 4 ? Way.e1 : Way.e3, koef: 1)
            }
        }
    }

    // MARK: - c3
    private func shiftC3Even() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 2, 4:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha3, right: Way.e2, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta1, right: Way.e3, koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.beta1, right: i % 6 == 0 || i % 6 == 5 ? Way.e1 : Way.e2, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha3, right: i % 6 == 0 || i % 6 == 5 ? Way.e3 : Way.e1, koef: 1)
            }
        }
    }

    private func shiftC3Odd() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 1, 5:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha3, right: Way.e2, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta1, right: Way.e3, koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.beta1, right: i % 6 == 0 || i % 6 == 4 ? Way.e2 : Way.e1, koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha3, right: i % 6 == 0 || i % 6 == 4 ? Way.e1 : Way.e3, koef: 1)
            }
        }
    }

    // MARK: - p1
    private func putP11(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: n3), right: Way.e1, koef: k)
    }

    private func putP12(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        matrix.rows[pos.1][pos.0].add(left: Way.alpha1(deg: n3), right: Way.e2, koef: k)
    }

    private func putP13(at pos: (Int, Int), koef k: Int) {
        let n3 = PathAlg.n3
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha1(deg: n3), right: Way.e3, koef: k)
    }
    
    private func shiftP1Even() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putP11, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putP11, fi: false),
                    (sh: 1, x: 1, y: 1, k: 1, f: putP12, fi: false),
                    (sh: 3, x: 3, y: 3, k: 1, f: putP12, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putP13, fi: false),
                    (sh: 4, x: 4, y: 4, k: 1, f: putP13, fi: false)])
    }

    private func shiftP1Odd() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putP12, fi: false),
                    (sh: 4, x: 4, y: 4, k: 1, f: putP12, fi: false),
                    (sh: 1, x: 1, y: 1, k: 1, f: putP13, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putP13, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putP11, fi: false),
                    (sh: 3, x: 3, y: 3, k: 1, f: putP11, fi: false)])
    }

    // MARK: - p2
    private func putP21(at pos: (Int, Int), koef k: Int) {
        let n1 = PathAlg.n1
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: n1), right: Way.e2, koef: k)
    }

    private func putP22(at pos: (Int, Int), koef k: Int) {
        let n1 = PathAlg.n1
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha2(deg: n1), right: Way.e3, koef: k)
    }

    private func putP23(at pos: (Int, Int), koef k: Int) {
        let n1 = PathAlg.n1
        matrix.rows[pos.1][pos.0].add(left: Way.alpha2(deg: n1), right: Way.e1, koef: k)
    }

    private func shiftP2Even() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putP21, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putP21, fi: false),
                    (sh: 1, x: 1, y: 1, k: 1, f: putP22, fi: false),
                    (sh: 3, x: 3, y: 3, k: 1, f: putP22, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putP23, fi: false),
                    (sh: 4, x: 4, y: 4, k: 1, f: putP23, fi: false)])
    }

    private func shiftP2Odd() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putP22, fi: false),
                    (sh: 4, x: 4, y: 4, k: 1, f: putP22, fi: false),
                    (sh: 1, x: 1, y: 1, k: 1, f: putP23, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putP23, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putP21, fi: false),
                    (sh: 3, x: 3, y: 3, k: 1, f: putP21, fi: false)])
    }

    // MARK: - p3
    private func putP31(at pos: (Int, Int), koef k: Int) {
        let n2 = PathAlg.n2
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: n2), right: Way.e3, koef: k)
    }

    private func putP32(at pos: (Int, Int), koef k: Int) {
        let n2 = PathAlg.n2
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha3(deg: n2), right: Way.e1, koef: k)
    }

    private func putP33(at pos: (Int, Int), koef k: Int) {
        let n2 = PathAlg.n2
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.alpha3(deg: n2), right: Way.e2, koef: k)
    }

    private func shiftP3Even() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putP31, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putP31, fi: false),
                    (sh: 1, x: 1, y: 1, k: 1, f: putP32, fi: false),
                    (sh: 3, x: 3, y: 3, k: 1, f: putP32, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putP33, fi: false),
                    (sh: 4, x: 4, y: 4, k: 1, f: putP33, fi: false)])
    }

    private func shiftP3Odd() {
        put(items: [(sh: 0, x: 0, y: 0, k: 1, f: putP32, fi: false),
                    (sh: 4, x: 4, y: 4, k: 1, f: putP32, fi: false),
                    (sh: 1, x: 1, y: 1, k: 1, f: putP33, fi: false),
                    (sh: 5, x: 5, y: 5, k: 1, f: putP33, fi: false),
                    (sh: 2, x: 2, y: 2, k: 1, f: putP31, fi: false),
                    (sh: 3, x: 3, y: 3, k: 1, f: putP31, fi: false)])
    }
}

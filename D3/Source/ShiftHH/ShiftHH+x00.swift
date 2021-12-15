//
//  ShiftHH+x00.swift
//
//  Created by M on 24.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftX00(_ label: String) -> Bool {
        switch label {
        case "x12":
            shiftDeg % 2 == 0 ? shiftX12Even() : shiftX12Odd()
            return true
        case "x23":
            shiftDeg % 2 == 0 ? shiftX23Even() : shiftX23Odd()
            return true
        case "x31":
            shiftDeg % 2 == 0 ? shiftX31Even() : shiftX31Odd()
            return true
        default:
            return false
        }
    }

    private func putD1(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.beta2, right: Way.e1, koef: k)
        matrix.rows[pos.1 + 2][pos.0 + 2].add(left: Way.alpha1, right: Way.e3, koef: -k)
    }

    private func putD2(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.alpha1, right: Way.e1, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.beta2, right: Way.e2, koef: -k)
    }

    private func putD3(at pos: (Int, Int), koef k: Int) {
        matrix.rows[pos.1][pos.0].add(left: Way.alpha1, right: Way.e2, koef: k)
        matrix.rows[pos.1 + 1][pos.0 + 1].add(left: Way.beta2, right: Way.e3, koef: -k)
    }

    // MARK: - x12
    private func shiftX12Even() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6)
            switch i0 {
            case 0: putD2(at: (3 * i, 3 * i), koef: k)
            case 1: putD3(at: (3 * i, 3 * i), koef: -k)
            case 2: putD1(at: (3 * i, 3 * i), koef: k)
            case 3: putD3(at: (3 * i, 3 * i), koef: k)
            case 4: putD1(at: (3 * i, 3 * i), koef: -k)
            default: putD2(at: (3 * i, 3 * i), koef: -k)
            }
        }
    }

    private func shiftX12Odd() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg((shiftDeg - 1) / 2) * Utils.minusDeg(i / 6)
            switch i0 {
            case 0: putD3(at: (3 * i, 3 * i), koef: -k)
            case 1: putD1(at: (3 * i, 3 * i), koef: -k)
            case 2: putD2(at: (3 * i, 3 * i), koef: -k)
            case 3: putD2(at: (3 * i, 3 * i), koef: k)
            case 5: putD1(at: (3 * i, 3 * i), koef: k)
            default: putD3(at: (3 * i, 3 * i), koef: k)
            }
        }
    }

    // MARK: - x23
    private func shiftX23Even() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6) * (i0 == 0 || i0 == 3 || i0 == 4 ? 1 : -1)
            switch i0 {
            case 2, 4:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha2, right: Way.e1, koef: k)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.beta3, right: Way.e2, koef: -k)
            default:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha2, right: i % 6 == 0 || i % 6 == 5 ? Way.e2 : Way.e3, koef: k)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta3, right: i % 6 == 0 || i % 6 == 5 ? Way.e3 : Way.e1, koef: -k)
            }
        }
    }

    private func shiftX23Odd() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg((shiftDeg - 1) / 2) * Utils.minusDeg(i / 6) * (i0 == 0 || i0 == 2 || i0 == 5 ? -1 : 1)
            switch i0 {
            case 1, 5:
                matrix.rows[3 * i][3 * i].add(left: Way.alpha2, right: Way.e1, koef: k)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.beta3, right: Way.e2, koef: -k)
            default:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha2, right: i % 6 == 0 || i % 6 == 4 ? Way.e3 : Way.e2, koef: k)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta3, right: i % 6 == 0 || i % 6 == 4 ? Way.e1 : Way.e3, koef: -k)
            }
        }
    }

    // MARK: - x31
    private func shiftX31Even() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg(shiftDeg / 2) * Utils.minusDeg(i / 6) * (i0 == 0 || i0 == 3 || i0 == 4 ? 1 : -1)
            switch i0 {
            case 2, 4:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha3, right: Way.e2, koef: k)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta1, right: Way.e3, koef: -k)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.beta1, right: i % 6 == 0 || i % 6 == 5 ? Way.e1 : Way.e2, koef: -k)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha3, right: i % 6 == 0 || i % 6 == 5 ? Way.e3 : Way.e1, koef: k)
            }
        }
    }

    private func shiftX31Odd() {
        for i in 0 ..< shiftDeg + 1 {
            let i0 = i % 6
            let k = Utils.minusDeg((shiftDeg - 1) / 2) * Utils.minusDeg(i / 6) * (i0 == 0 || i0 == 2 || i0 == 5 ? -1 : 1)
            switch i0 {
            case 1, 5:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way.alpha3, right: Way.e2, koef: k)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.beta1, right: Way.e3, koef: -k)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way.beta1, right: i % 6 == 0 || i % 6 == 4 ? Way.e2 : Way.e1, koef: -k)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way.alpha3, right: i % 6 == 0 || i % 6 == 4 ? Way.e1 : Way.e3, koef: k)
            }
        }
    }
}

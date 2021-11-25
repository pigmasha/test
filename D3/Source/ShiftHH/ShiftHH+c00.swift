//
//  ShiftHH+c00.swift
//
//  Created by M on 22.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftC00(_ label: String) -> Bool {
        switch label {
        case "c12":
            shiftDeg % 2 == 0 ? shiftC12Even() : shiftC12Odd()
            return true
        case "c23":
            shiftDeg % 2 == 0 ? shiftC23Even() : shiftC23Odd()
            return true
        case "c31":
            shiftDeg % 2 == 0 ? shiftC31Even() : shiftC31Odd()
            return true
        default:
            return false
        }
    }

    // MARK: - c12
    private func shiftC12Even() {
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

    private func shiftC12Odd() {
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

    // MARK: - c23
    private func shiftC23Even() {
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

    private func shiftC23Odd() {
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

    // MARK: - c31
    private func shiftC31Even() {
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

    private func shiftC31Odd() {
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
}

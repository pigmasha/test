//
//  ShiftHH+c31.swift
//  D3
//
//  Created by M on 22.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftC31() {
        shiftDeg % 2 == 0 ? shiftC31Even() : shiftC31Odd()
    }

    private func shiftC31Even() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 2, 4:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way(type: .a31, len: 2), right: Way(vertexType: .e2), koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way(type: .a13, len: 2), right: Way(vertexType: .e3), koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way(type: .a13, len: 2),
                                              right: Way(vertexType: i % 6 == 0 || i % 6 == 5 ? .e1 : .e2), koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way(type: .a31, len: 2),
                                                      right: Way(vertexType: i % 6 == 0 || i % 6 == 5 ? .e3 : .e1), koef: 1)
            }
        }
    }

    private func shiftC31Odd() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 1, 5:
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way(type: .a31, len: 2), right: Way(vertexType: .e2), koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way(type: .a13, len: 2), right: Way(vertexType: .e3), koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way(type: .a13, len: 2),
                                              right: Way(vertexType: i % 6 == 0 || i % 6 == 4 ? .e2 : .e1), koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way(type: .a31, len: 2),
                                                      right: Way(vertexType: i % 6 == 0 || i % 6 == 4 ? .e1 : .e3), koef: 1)
            }
        }
    }
}


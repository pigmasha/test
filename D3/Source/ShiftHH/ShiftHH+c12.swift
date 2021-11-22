//
//  ShiftHH+c12.swift
//
//  Created by M on 22.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftC12() {
        shiftDeg % 2 == 0 ? shiftC12Even() : shiftC12Odd()
    }

    private func shiftC12Even() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 2, 4:
                matrix.rows[3 * i][3 * i].add(left: Way(type: .a21, len: 2), right: Way(vertexType: .e1), koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way(type: .a12, len: 2), right: Way(vertexType: .e3), koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way(type: .a12, len: 2),
                                              right: Way(vertexType: i % 6 == 0 || i % 6 == 5 ? .e1 : .e2), koef: 1)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way(type: .a21, len: 2),
                                                      right: Way(vertexType: i % 6 == 0 || i % 6 == 5 ? .e2 : .e3), koef: 1)
            }
        }
    }

    private func shiftC12Odd() {
        for i in 0 ..< shiftDeg + 1 {
            switch i % 6 {
            case 1, 5:
                matrix.rows[3 * i][3 * i].add(left: Way(type: .a21, len: 2), right: Way(vertexType: .e1), koef: 1)
                matrix.rows[3 * i + 2][3 * i + 2].add(left: Way(type: .a12, len: 2), right: Way(vertexType: .e3), koef: 1)
            default:
                matrix.rows[3 * i][3 * i].add(left: Way(type: .a12, len: 2),
                                              right: Way(vertexType: i % 6 == 0 || i % 6 == 4 ? .e2 : .e1), koef: 1)
                matrix.rows[3 * i + 1][3 * i + 1].add(left: Way(type: .a21, len: 2),
                                                      right: Way(vertexType: i % 6 == 0 || i % 6 == 4 ? .e3 : .e2), koef: 1)
            }
        }
    }
}

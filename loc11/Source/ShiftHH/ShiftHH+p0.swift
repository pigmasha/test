//
//  ShiftHH+c00.swift
//
//  Created by M on 22.11.2021.
//

import Foundation

extension ShiftHH {
    func shiftP0(_ label: String) -> Bool {
        if shiftDeg > 0 { return false }
        switch label {
        case "p1":
            for i in 0 ... shiftDeg {
                matrix.rows[i][i].add(left: Way.xy, right: Way.e)
                matrix.rows[i][i].add(left: Way.yx, right: Way.e)
            }
            return true
        case "p2":
            for i in 0 ... shiftDeg {
                matrix.rows[i][i].add(left: Way.zx, right: Way.e)
            }
            return true
        case "p3":
            for i in 0 ... shiftDeg {
                matrix.rows[i][i].add(left: Way.zy, right: Way.e)
            }
            return true
        case "p4":
            for i in 0 ... shiftDeg {
                matrix.rows[i][i].add(left: Way(type: .x, len: 2 * PathAlg.kk), right: Way.e)
            }
            return true
        default:
            return false
        }
    }
}

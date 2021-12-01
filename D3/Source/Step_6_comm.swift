//
//  Step_6_comm.swift
//  D3
//
//  Created by M on 28.11.2021.
//

import Foundation

struct Step_6_comm {
    static func runCase() -> Bool {
        let elements = GenCreate.allElements
        for i in 0 ..< elements.count - 1 {
            let e1 = elements[i]
            if e1.label == "1" { continue }
            for j in i + 1 ..< elements.count {
                let e2 = elements[j]
                if !checkCommutative(e1, and: e2) { return true }
            }
        }
        return false
    }
    
    private static func checkCommutative(_ e1: Gen, and e2: Gen) -> Bool {
        let deg = e1.deg + e2.deg
        let s11 = ShiftHH(gen: e2, shiftDeg: 0).matrix
        let s12 = ShiftHH(gen: e1, shiftDeg: e2.deg).matrix
        if s11.isZero || s12.isZero { return true }
        let mult = Matrix(mult: s11, and: s12)
        let s1 = ShiftHH(gen: e1, shiftDeg: 0).matrix
        let s2 = ShiftHH(gen: e2, shiftDeg: e1.deg).matrix
        if s1.isZero || s2.isZero { return true }
        let mult2 = Matrix(mult: s1, and: s2)
        if mult.numberOfDifferents(with: mult2) == 0 { return true }
        mult2.add(mult, koef: e1.deg % 2 == 1 && e2.deg % 2 == 1 ? 1 : -1)
        let im = ImMatrix(mult: mult2)
        if im.rows.count == 0 { return true }
        let g0 = Gen(label: "C", deg: deg, elem: im.rows[0])
        if GenCreate(deg: deg).checkNotIm(g0, inIm: true) == nil { return true }
        OutputFile.writeLog(.error, e2.label + " * " + e1.label + " not commutative")
        return false
    }
}

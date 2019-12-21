//
//  Step_15_mult_34.swift
//  E7
//
//  Created by M on 11/09/2019.
//

import Foundation

struct Step_15_mult_34 {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        return process(type1: 14, type2: 3)
    }

    private static func process(type1: Int, type2: Int) -> Bool {
        let kk = PathAlg.s == 1 ? 25 : 5
        for deg1 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
            guard Dim.deg(deg1, hasType: type1) else {
                continue
            }
            for deg2 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
                guard Dim.deg(deg2, hasType: type2) else {
                    continue
                }
                let multRes = Matrix(mult: HHElem(deg: deg2, type: type2),
                                     and: ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))
                let myMultRes = myMult(deg: deg1 + deg2)
                if !multRes.isEq(myMultRes, debug: false) {
                    OutputFile.writeLog(.error, "Mults not equal!")
                    PrintUtils.printMatrix("Right Matrix", multRes)
                    PrintUtils.printMatrix("My Matrix", myMultRes)
                    return true
                } else {
                    OutputFile.writeLog(.normal, "OK")
                }
            }
        }
        return false
    }

    private static func myMult(deg: Int) -> Matrix {
        let s = PathAlg.s
        let mult = HHElem()
        mult.makeZeroMatrix(9*s, h:7*s)
        HHElem.addElemToHH(mult, i:0, j:0, leftFrom:0, leftTo:3, right:0, koef:1)
        HHElem.addElemToHH(mult, i:0, j:s, leftFrom:0, leftTo:5, right:0, koef:1)
        return mult
    }
}

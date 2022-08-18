//
//  Step_4_dim.swift
//  Created by M on 24.05.2022.
//

import Foundation

struct Step_4_dim {
    static func runCase() -> Bool {
        for d in 0 ... PathAlg.alg.someNumber {
            let dimHH = Dim.dimKer(d) - (d == 0 ? 0 : Dim.dimIm(d - 1))
            if dimHH != Dim.dimHH(d) {
                OutputFile.writeLog(.error, "\(d): dimHH \(Dim.dimHH(d)), should be \(dimHH)")
                return true
            }
        }
        return false
    }

    private static func checkDimKer() -> Bool {
        for d in 0 ... PathAlg.alg.someNumber {
            let dimKer = Dim.dimHom(d) - Dim.dimIm(d)
            if dimKer != Dim.dimKer(d) {
                OutputFile.writeLog(.error, "\(d): dimKer \(Dim.dimKer(d)), should be \(dimKer)")
                return true
            }
        }
        return false
    }
}

//
//  Step_6_dimhh.swift
//  Created by M on 15/03/2020.
//

import Foundation

struct Step_6_dimhh {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        for deg in 0...30 * PathAlg.twistPeriod + 2 {
            let r = deg % PathAlg.twistPeriod
            let ell = Int(deg / PathAlg.twistPeriod)

            let dimHom1 = Dim.dimHom(deg)
            let dimIm1 = Dim.dimIm(deg)
            let dimIm2 = deg == 0 ? 0 : Dim.dimIm(deg - 1)
            let dimHH1 = Dim.dimHH(deg)

            if dimHH1 != dimHom1 - dimIm1 - dimIm2 {
                OutputFile.writeLog(.error, "HH \(dimHH1) and \(dimHom1 - dimIm1 - dimIm2)"
                    + " (deg=\(deg) (\(deg % 11)), r=\(r), ell=\(ell), char=\(PathAlg.charK))")
                return true
            }

            if dimHH1 != dimHH2(deg) {
                OutputFile.writeLog(.error, "Bad dim2 HH \(dimHH1) and \(dimHH2(deg))"
                    + " (deg=\(deg) (\(deg % 29)), r=\(r), ell=\(ell), char=\(PathAlg.charK))")
                return true
            }
        }
        return false
    }

    private static func dimHH2(_ deg: Int) -> Int {
        var d = 0
        for t in 1 ... (PathAlg.s == 1 ? Dim.typeMax2 : Dim.typeMax) {
            if Dim.deg(deg, hasType: t) { d += 1 }
        }
        return d
    }
}

//
//  Step_2_im.swift
//
//  Created by M on 07.11.2021.
//

import Foundation

struct Step_2_im {
    static func runCase() -> Bool {
        var lastDimIm = 0
        for d in 0 ... 50 {
            let dimIm = KoefIntMatrix(im: ImMatrix(diff: Diff(deg: d)).rows).rank
            let dimKer = Dim.dimHom(d) - dimIm
            let dimHH = dimKer - lastDimIm
            if dimHH != Dim.dimHH(d) {
                OutputFile.writeLog(.error, "\(d): dimHH \(dimHH), should be \(Dim.dimHH(d))")
                return true
            }
            lastDimIm = dimIm
        }
        return false
    }

    private static func checkDimIm() -> Bool {
        for d in 0 ... 3 {
            //PrintUtils.printMatrix("Diff \(d)", Diff(deg: d))
            let im = ImMatrix(diff: Diff(deg: d))
            PrintUtils.printImMatrix("Im \(d)", im)
            let k = KoefIntMatrix(im: im.rows)
            PrintUtils.printKoefIntMatrix("Koefs", k)
            let rk = k.rank
            if rk != Dim.dimIm(d) {
                OutputFile.writeLog(.error, "\(d): rank \(rk), should be \(Dim.dimIm(d))")
                return true
            }
        }
        return false
    }

    private static func checkDimHom() -> Bool {
        for d in 0 ... 50 {
            let q = BimodQ(deg: d)
            var dim = 0
            for p in q.pij {
                dim += Way.allWays(from: p.1, to: p.0).count
            }
            if dim != Dim.dimHom(d) {
                OutputFile.writeLog(.error, "Deg \(d): my dimHom=\(dim), should be \(Dim.dimHom(d))")
                return true
            }
        }
        return false
    }
}

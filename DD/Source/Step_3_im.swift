//
//  Step_3_im.swift
//  Created by M on 24.10.2021.
//

import Foundation

struct Step_3_im {
    static func runCase() -> Bool {
        /*for d in 0 ... 3 {
            if checkDimHH(d: d) { return true }
        }*/
        return checkAllHH()
    }

    private static func checkAllHH() -> Bool {
        var dimIm: [Int] = []
        for d in 0 ... 50 {
            let rr = KoefIntMatrix(im: PKer.im(Diff(deg: d))).rank
            dimIm.append(rr)
            let dimKer = Dim.dimHom(deg: d) - rr
            let dimHH = d == 0 ? dimKer : dimKer - dimIm[d - 1]
            if dimHH != Dim.dimHH(deg: d) {
                OutputFile.writeLog(.error, "\(d): myDim = \(Dim.dimHH(deg: d)), dim = \(dimHH)")
                return true
            }
        }
        return false
    }

    private static func checkDimHH(d: Int) -> Bool {
        let dimHH = Dim.dimHH(deg: d)
        let dd = d == 0 ? Dim.dimKer(deg: d) : Dim.dimKer(deg: d) - Dim.dimIm(deg: d - 1)
        if dimHH != dd {
            OutputFile.writeLog(.error, "dimHH\(d)=\(dd), myDim=\(dimHH)")
            return true
        }
        return false
    }

    private static func checkDimKer(d: Int) -> Bool {
        let dimKer = Dim.dimKer(deg: d)
        if dimKer != Dim.dimHom(deg: d) - Dim.dimIm(deg: d) {
            OutputFile.writeLog(.error, "dimKer\(d)=\(Dim.dimHom(deg: d) - Dim.dimIm(deg: d)), myDim=\(dimKer)")
            return true
        }
        return false
    }

    private static func checkDimIm(d: Int) -> Bool {
        let diff = Diff(deg: d)
        let rr = KoefIntMatrix(im: PKer.im(diff)).rank
        let myDim = Dim.dimIm(deg: d)
        if myDim == -1 {
            OutputFile.writeLog(.normal, "dimIm\(d)=\(rr)")
        } else if rr != myDim {
            OutputFile.writeLog(.error, "dimIm\(d)=\(rr), myDim=\(myDim)")
            return true
        }
        return false
    }

    private static func checkCh2() -> Bool {
        if NumInt.isZero(n: PathAlg.c) && NumInt.isZero(n: PathAlg.d) { return false }
        let maxD = 50
        var dimIm: [Int] = []
        var dimHom: [Int] = []
        var dimKer: [Int] = []
        var dimHH: [Int] = []
        for d in 0 ... 3 {
            let diff = Diff(deg: d)
            //PrintUtils.printMatrix("Diff \(d)", diff)
            let im = PKer.im(diff)
            //for i in im { OutputFile.writeLog(.normal, i.str) }
            let kk = KoefIntMatrix(im: im)
            //PrintUtils.printKoefIntMatrix("Im", kk)
            //PrintUtils.printKoefIntMatrix("Im", kk)
            let rr = kk.rank
            dimIm.append(rr)
            //OutputFile.writeLog(.normal, "\(d): dimIm = \(rr)")
            if rr != DimCh2.dimIm(deg: d) {
                OutputFile.writeLog(.error, "\(d): rank = \(rr), dim = \(DimCh2.dimIm(deg: d))")
                return true
            }
        }
        for d in 4 ... maxD {
            let diff = Diff(deg: d)
            let rr = KoefIntMatrix(im: PKer.im(diff)).rank
            dimIm.append(rr)
        }

        for d in 0 ... maxD {
            dimHom.append(Dim.dimHom(deg: d))
            dimKer.append(dimHom[d] - dimIm[d])
            dimHH.append(d == 0 ? dimKer[d] : dimKer[d] - dimIm[d - 1])
        }

        for d in 0 ... maxD {
            if dimHH[d] != DimCh2.dimHH(deg: d) {
                OutputFile.writeLog(.error, "\(d): myDim = \(dimHH[d]), dim = \(DimCh2.dimHH(deg: d))")
                return true
            }
        }

        /*OutputFile.writeLog(.simple, "<table>")
        OutputFile.writeLog(.simple, "<tr><td>Ker: </td><td>" + dimKer.map { "\($0)" }.joined(separator: "</td><td>"))
        OutputFile.writeLog(.simple, "<tr><td>Im: </td><td>" + dimIm.map { "\($0)" }.joined(separator: "</td><td>"))
        OutputFile.writeLog(.simple, "</table>")*/

        return false
    }
}

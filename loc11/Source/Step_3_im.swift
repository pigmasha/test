//
//  Step_3_im.swift
//  Created by M on 07.11.2021.
//

import Foundation

struct Step_3_im {
    static func runCase() -> Bool {
        for d in 0 ... PathAlg.alg.someNumber {
            //PrintUtils.printMatrix("Diff \(d)", Diff(deg: d))
            let im = ImMatrix(diff: Diff(deg: d))
            //PrintUtils.printImMatrix("Im \(d)", im)
            let k = KoefIntMatrix(im: im.rows)
            //PrintUtils.printKoefIntMatrix("Koefs", k)
            let rk = k.rank
            //OutputFile.writeLog(.normal, "\(d): rank \(rk)")
            if rk != Dim.dimIm(d) {
                OutputFile.writeLog(.error, "\(d): rank \(rk), should be \(Dim.dimIm(d))")
                return true
            }
            guard let myIms = Im.im(deg: d) else { smartPrintIm(d, im); continue }
            let onError: (String) -> Void = { str in
                OutputFile.writeLog(.error, str)
                PrintUtils.printImMatrix("Im \(d)", im)
                myIms.forEach { PrintUtils.printImMatrix("MyIm", $0) }
            }
            var totalRk = 0
            var totalW = 0
            for my in myIms {
                let myRk = KoefIntMatrix(im: my.rows).rank
                if myRk != my.rows.count {
                    onError("Bad rank \(myRk), should be \(my.rows.count)")
                }
                totalRk += my.rows.count
                totalW = my.rows[0].count
            }
            if totalW != im.rows[0].count { onError("Bad my im width \(totalW)"); return true }
            if totalRk != rk { onError("Bad my im count \(totalRk), should be \(rk)"); return true }
            var w0 = 0
            var hasErrors = false
            for my in myIms {
                let w = my.rows[0].count
                var sumRows = my.rows
                for row in im.rows {
                    if w0 > 0 {
                        var isOk = true
                        for i in 0 ..< w0 {
                            if !row[i].isZero { isOk = false; break }
                        }
                        if !isOk { continue }
                    }
                    let r = [] + row[0 ... w - 1]
                    if !r.isZero { sumRows.append(r) }
                }
                let sumRk = KoefIntMatrix(im: sumRows).rank
                if sumRk != my.rows.count {
                    PrintUtils.printImRows("Sum \(w0), bad sum rank \(sumRk), should be \(my.rows.count)", sumRows)
                    //onError("Bad sum rank \(sumRk), should be \(my.rows.count)")
                    //return true
                    hasErrors = true
                }
                w0 += (w0 == 0) ? w : 4
            }
            if hasErrors { return true }
            OutputFile.writeLog(.normal, "myIm \(d) checked :)")
        }
        return false
    }

    private static func smartPrintIm(_ d: Int, _ im: ImMatrix) {
        var w0 = 0
        let width = im.rows[0].count
        while w0 < width {
            let w = w0 == 0 ? (d + 2) % 4 : 4
            var rr: [[Element]] = []
            for row in im.rows {
                if w0 > 0 {
                    var isOk = true
                    for i in 0 ..< w0 {
                        if !row[i].isZero { isOk = false; break }
                    }
                    if !isOk { continue }
                }
                let r = [] + row[w0 ... w0 + w - 1]
                if !r.isZero { rr.append(r) }
            }
            PrintUtils.printImRows("Im \(d): \(w0)", rr)
            w0 += w
        }
    }
}

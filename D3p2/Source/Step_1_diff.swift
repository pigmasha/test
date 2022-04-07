//
//  Step_1_diff.swift
//
//  Created by M on 31.10.2021.
//

import Foundation

struct Step_1_diff {
    static func runCase() -> Bool {
        var prevDiff = Diff(deg: 0)
        for d in 0 ... 10 {
            //OutputFile.writeLog(.normal, "\(d): \(BimodQ(deg: d + 1).str) -> \(BimodQ(deg: d).str)")
            let diff = Diff(deg: d)
            if let err = CheckDiff.check(diff: diff, deg: d, prevDiff: prevDiff) {
                PrintUtils.printMatrix("Diff", diff)
                OutputFile.writeLog(.error, "Check error: " + err)
                return true
            }
            OutputFile.writeLog(.normal, "\(d): checked :)")
            prevDiff = diff
        }
        return false
    }
}

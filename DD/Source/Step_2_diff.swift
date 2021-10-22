//
//  Step_2_diff.swift
//  Created by M on 13.10.2021.
//

import Foundation

struct Step_2_diff {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "k=\(PathAlg.k), c=\(PathAlg.c), d=\(PathAlg.d), char=\(PathAlg.charK)")
        var prevDiff = Diff(deg: 0)
        for d in 0 ..< 20 {
            let diff = Diff(deg: d)
            if let err = CreateDiff.check(diff: diff, deg: d, prevDiff: prevDiff) {
                OutputFile.writeLog(.error, err)
                PrintUtils.printMatrix("Diff \(d)", diff)
                return true
            }
            OutputFile.writeLog(.normal, "\(d): checked :)")
            prevDiff = diff
        }
        return false
    }
}

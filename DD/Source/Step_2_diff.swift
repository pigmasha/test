//
//  Step_2_diff.swift
//  Created by M on 13.10.2021.
//

import Foundation

struct Step_2_diff {
    static func runCase() -> Bool {
        var prevDiff = Diff(deg: 0)
        for d in 0 ..< 50 {
            let diff = Diff(deg: d)
            if CreateDiff.check(diff: diff, deg: d, prevDiff: prevDiff) == nil {
                //OutputFile.writeLog(.normal, "\(d): checked :)")
                prevDiff = diff
                continue
            }
            let newDiff = Diff(emptyForDeg: d)
            if let err = CreateDiff.create(diff: newDiff, deg: d, prevDiff: prevDiff) {
                OutputFile.writeLog(.error, "Create error: " + err)
                return true
            }
            PrintUtils.printMatrix("Diff", diff)
            PrintUtils.printMatrix("New Diff", newDiff)
            if let err = CreateDiff.check(diff: newDiff, deg: d, prevDiff: prevDiff) {
                OutputFile.writeLog(.error, err)
            } else {
                OutputFile.writeLog(.bold, "New diff ok!")
            }
            return true
        }
        return false
    }
}

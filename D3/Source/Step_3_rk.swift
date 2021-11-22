//
//  Step_3_rk.swift
//
//  Created by M on 13.11.2021.
//

import Foundation

struct Step_3_rk {
    static func runCase() -> Bool {
        if PathAlg.rkC != myRkC() {
            OutputFile.writeLog(.error, "My rkC=\(myRkC()), should be=\(PathAlg.rkC)")
            return true
        }
        if PathAlg.rkC1 != myRkC1() {
            OutputFile.writeLog(.error, "My rkC1=\(myRkC1()), should be=\(PathAlg.rkC1)")
            return true
        }
        return false
    }

    private static func myRkC() -> Int {
        return min(myRkC1(), 2)
    }

    private static func myRkC1() -> Int {
        let n1 = NumInt.isZero(n: PathAlg.n1) ? 0 : 1
        let n2 = NumInt.isZero(n: PathAlg.n2) ? 0 : 1
        let n3 = NumInt.isZero(n: PathAlg.n3) ? 0 : 1
        return n1 + n2 + n3
    }
}

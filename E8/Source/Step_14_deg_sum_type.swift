//
//  Created by M on 12/04/2020.
//

import Foundation

struct Step_14_deg_sum_type {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "S=\(PathAlg.s), Char=\(PathAlg.charK)")

        if !Dim.deg(1, hasType: 2) { return true }
        let types2: [(Int, Int)] = [(4, 3), (8, 7), (14, 13), (16, 15), (22, 21), (26, 25), (28, 27)]
        let degMax = 50 * PathAlg.s * PathAlg.twistPeriod
        for deg in 0 ..< degMax {
            for (type1, type2) in types2 {
                guard Dim.deg(deg, hasType: type1) else { continue }
                if !Dim.deg(deg - 1, hasType: type2) {
                    OutputFile.writeLog(.error, "\(type2) = \(type1) * 2")
                    return true
                }
                OutputFile.writeLog(.normal, "\(type2) = \(type1) * 2 ok")
            }
        }
        return false
    }
}

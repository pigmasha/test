//
//  Created by M on 02.04.17.
//
//

import Foundation

struct Step_10_createhh
{
    static func runCase() -> Bool
    {
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d (types %d)",  PathAlg.n, PathAlg.s, PathAlg.charK, 22)
        for type in 1...22 {
            if (process(type: type)) {
                return true
            }
        }
        return false
    }

    private static func process(type: Int) -> Bool
    {
        for deg in 1...30 * PathAlg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                let ell = deg / PathAlg.twistPeriod
                let hh = HHElem(deg: deg, type: type)
                OutputFile.writeLog(.bold, "type \(type): HH (ell=\(ell))")
                if (!CheckHH.check(hh, degree: deg)) {
                    return true
                }
            }
        }
        return false
    }
}

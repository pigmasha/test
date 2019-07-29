//
//  Created by M on 03/07/2019.
//

import Foundation

struct Step_12_degs_mult_check {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "S=\(PathAlg.s), Char=\(PathAlg.charK)")

        for type in 1 ... Dim.typeMax2 {
            for t2 in type ... Dim.typeMax2 {
                if process(type1: type, type2: t2) { return true }
            }
        }
        return false
    }

    private static func process(type1: Int, type2: Int) -> Bool {
        for deg1 in 0...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
            guard Dim.deg(deg1, hasType: type1) else { continue }
            if type1 == 2 && deg1 == 0 { continue }
            for deg2 in 0...5 * PathAlg.s * PathAlg.twistPeriod + 2 {
                guard Dim.deg(deg2, hasType: type2) else { continue }
                if type2 == 2 && deg2 == 0 { continue }
                let deg = deg1 + deg2
                let type = myMultType(type1: type1, type2: type2)
                if type == -1 { continue }
                if type == 0 {
                    for t in 1 ... Dim.typeMax {
                        if Dim.deg(deg, hasType: t) {
                            OutputFile.writeLog(.error, "\(type1) * \(type2) = \(t), but zero in my calc")
                            return true
                        }
                    }
                } else {
                    if !Dim.deg(deg, hasType: type) {
                        OutputFile.writeLog(.error, "\(type1) * \(type2) has no type \(type)")
                        return true
                    }
                }
            }
        }
        return false
    }

    private static func myMultType(type1: Int, type2: Int) -> Int {
        let s = PathAlg.s
        let charK = PathAlg.charK
        if type1 == 1 {
            return type2
        }
        if type1 == 2 {
            switch type2 {
            case 2: return s <= 2 ? 1 : 0
            case 3, 4, 5, 6, 7, 8: return s == 1 && charK == 2 ? type2 : 0
            case 9: return 10
            case 10: return s <= 2 ? 9 : 0
            case 11, 12, 13, 14, 15, 16: return s == 1 && charK == 2 ? type2 : 0
            case 17: return 18
            case 18: return s <= 2 ? 17 : 0
            default: fatalError("Bad type2=\(type2)")
            }
        }
        if type1 == 3 {
            switch type2 {
            case 3, 5, 7, 11, 13, 15: return 0
            case 4: return 5
            case 6: return 7
            case 8: return 10
            case 9: return 11
            case 10: return s == 1 && charK == 2 ? 11 : 0
            case 12: return 13
            case 14: return 15
            case 16: return 18
            case 17: return 2
            case 18: return s <= 2 ? 1 : 0
            default: fatalError("Bad type2=\(type2)")
            }
        }
        if type1 == 4 {
            switch type2 {
            case 4: return charK == 3 ? 7 : 0
            case 5: return s == 1 && charK == 2 ? 8 : 0
            case 6: return 10
            case 7: return s == 1 && charK == 2 ? 11 : 0
            case 8, 10, 13, 17, 18: return 0
            case 9: return charK == 3 ? 13 : 0
            case 11: return s == 1 && charK == 2 ? 14 : 0
            case 12: return 15
            case 14: return 16
            case 15: return 18
            case 16: return s == 1 && charK == 2 ? 3 : 0
            default: fatalError("Bad type2=\(type2)")
            }
        }
        if type1 == 5 {
            switch type2 {
            case 5: return s <= 2 ? 9 : 0
            case 6, 8, 12, 13, 16: return 0
            case 7: return s <= 2 ? 12 : 0
            case 9: return s == 1 && charK == 2 ? 14 : 0
            case 10: return s <= 2 ? 14 : 0
            case 11: return s == 1 && charK == 2 ? 15 : 0
            case 14: return 18
            case 15: return s <= 2 ? 1 : 0
            case 17: return s == 1 && charK == 2 ? 4 : 0
            case 18: return s <= 2 ? 4 : 0
            default: fatalError("Bad type2=\(type2)")
            }
        }
        return -1
    }
}

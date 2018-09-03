//
//  Created by M on 24.04.16.
//

import Foundation

struct Dim {
    static let typeMax = 24

    static func deg(_ deg: Int, hasType type: Int) -> Bool {
        let n = PathAlg.n
        let s = PathAlg.s
        let charK = PathAlg.charK
        let ell = deg / PathAlg.twistPeriod
        let r = deg % PathAlg.twistPeriod
        let m = r / 2
        let eq20 = ((ell * (n + s) + m) % (2 * s) == 0)
        let eq21 = ((ell * (n + s) + m) % (2 * s) == 1)
        let eq2s0 = ((ell * (n + s) + m) % (2 * s) == s)
        let eq2s1 = ((ell * (n + s) + m - s - 1) % (2 * s) == 0)

        if deg == 0 && s == 1 && charK != 3 && type == 23 { return true }
        if deg == 0 && s == 1 && type == 24 { return true }

        switch r {
        case 0:
            if eq20 && (ell % 2 == 0 || charK == 2) && type == 1 { return true }
            if eq2s1 && ell % 2 == 0 && charK == 3 && type == 2 { return true }
        case 1:
            if eq20 && (ell % 2 == 0 || charK == 2) && type == 3 { return true }
            if eq2s0 && (ell % 2 == 1 || charK == 2) && type == 4 { return true }
        case 2:
            if eq2s1 && (ell % 2 == 1 || charK == 2) && type == 5 { return true }
        case 3:
            if eq20 && type == 6 { return true }
            if eq2s0 && charK == 2 && type == 7 { return true }
        case 4:
            if eq2s1 && charK == 2 && type == 8 { return true }
            if eq2s0 && ell % 2 == 1 && charK == 3 && type == 9 { return true }
            if eq21 && type == 10 { return true }
        case 5:
            if eq20 && ell % 2 == 0 && charK == 3 && type == 11 { return true }
            if eq2s0 && ell % 2 == 1 && charK == 3 && type == 12 { return true }
        case 6:
            if eq20 && charK == 2 && type == 13 { return true }
            if eq21 && ell % 2 == 0 && charK == 3 && type == 14 { return true }
            if eq2s0 && type == 15 { return true }
        case 7:
            if eq20 && charK == 2 && type == 16 { return true }
            if eq2s0 && type == 17 { return true }
        case 8:
            if eq20 && (ell % 2 == 0 || charK == 2) && type == 18 { return true }
        case 9:
            if eq20 && (ell % 2 == 0 || charK == 2) && type == 19 { return true }
            if eq2s0 && (ell % 2 == 1 || charK == 2) && type == 20 { return true }
        case 10:
            if eq2s1 && (ell % 2 == 1 || charK == 2) && type == 21 { return true }
            if eq20 && ell % 2 == 1 && charK == 3 && type == 22 { return true }
        default:
            return false
        }

        return false
    }

    static func dimHom(_ deg: Int) -> Int {
        let n = PathAlg.n
        let s = PathAlg.s
        let ell = deg / PathAlg.twistPeriod
        let d = deg % PathAlg.twistPeriod
        if s == 1 {
            switch d {
            case 0, 3, 5, 7, 10: return 8
            case 1: return ell % 2 == 0 ? 7 : 5
            case 2: return ell % 2 == 0 ? 2 : 6
            case 4: return ell % 2 == 0 ? 9 : 11
            case 6: return ell % 2 == 0 ? 11 : 9
            case 8: return ell % 2 == 0 ? 6 : 2
            case 9: return ell % 2 == 0 ? 5 : 7
            default: fatalError("Bad r=\(d)")
            }
        }
        let m = d / 2
        let eq0 = ((ell * n + m) % s == 0)
        let eq20 = ((ell * (n + s) + m) % (2 * s) == 0)
        let eq21 = ((ell * (n + s) + m) % (2 * s) == 1)
        let eq2s0 = ((ell * (n + s) + m) % (2 * s) == s)
        let eq2s1 = ((ell * (n + s) + m) % (2 * s) == s + 1)
        switch d {
        case 0:
            if eq20 || eq21 { return 6 * s }
            if eq2s0 || eq2s1 { return 2 * s }
        case 1:
            if eq20 { return 7 * s }
            if eq2s0 { return 5 * s }
        case 2, 8:
            if eq20 || eq2s1 { return 3 * s }
            if eq2s0 || eq21 { return s }
        case 3, 5, 7:
            if eq0 { return 8 * s }
        case 4:
            if eq20 { return 2 * s }
            if eq2s0 { return 6 * s }
            if eq21 { return 5 * s }
            if eq2s1 { return 7 * s }
        case 6:
            if eq20 { return 7 * s }
            if eq2s0 { return 5 * s }
            if eq21 { return 6 * s }
            if eq2s1 { return 2 * s }
        case 9:
            if eq20 { return 5 * s }
            if eq2s0 { return 7 * s }
        case 10:
            if eq20 || eq21 { return 2 * s }
            if eq2s0 || eq2s1 { return 6 * s }
        default: fatalError("Bad r=\(d)")
        }

        return 0
    }

    static func dimIm(_ deg: Int) -> Int {
        let n = PathAlg.n
        let s = PathAlg.s
        let charK = PathAlg.charK
        let ell = deg / PathAlg.twistPeriod
        let d = deg % PathAlg.twistPeriod
        let m = d / 2
        let eq20 = ((ell * (n + s) + m) % (2 * s) == 0)
        let eq2s0 = ((ell * (n + s) + m) % (2 * s) == s)
        if s == 1 {
            switch d {
            case 0: return ell % 2 == 0 ? 5 : 2
            case 1: return ell % 2 == 0 ? 1 : 2
            case 2: return ell % 2 == 0 ? 1 : 3
            case 3: return ell % 2 == 0 ? (charK == 2 ? 6 : 7) : 4
            case 4: return ell % 2 == 0 ? 2 : (charK == 3 ? 5 : 6)
            case 5: return ell % 2 == 0 ? (charK == 3 ? 5 : 6) : 2
            case 6: return ell % 2 == 0 ? 4 : (charK == 2 ? 6 : 7)
            case 7: return ell % 2 == 0 ? 3 : 1
            case 8: return ell % 2 == 0 ? 2 : 1
            case 9: return ell % 2 == 0 ? 2 : 5
            case 10: return ell % 2 == 0 ? 6 : (charK == 3 ? 1 : 2)
            default: fatalError("Bad r=\(d)")
            }
        }
        switch d {
        case 0:
            if eq20 { return (ell % 2 == 0 || charK == 2) ? 6 * s - 1 : 6 * s }
            if eq2s0 { return 2 * s }
        case 1:
            if eq20 { return s }
            if eq2s0 { return (ell % 2 == 1 || charK == 2) ? 3 * s - 1 : 3 * s }
        case 2:
            if eq20 { return 3 * s }
            if eq2s0 { return s }
        case 3:
            if eq20 { return 5 * s - 1 }
            if eq2s0 { return (charK == 2) ? 7 * s - 1 : 7 * s }
        case 4:
            if eq20 { return 2 * s }
            if eq2s0 { return (ell % 2 == 1 && charK == 3) ? 6 * s - 1 : 6 * s }
        case 5:
            if eq20 { return (ell % 2 == 0 && charK == 3) ? 6 * s - 1 : 6 * s }
            if eq2s0 { return 2 * s }
        case 6:
            if eq20 { return (charK == 2) ? 7 * s - 1 : 7 * s }
            if eq2s0 { return 5 * s - 1 }
        case 7:
            if eq20 { return s }
            if eq2s0 { return 3 * s }
        case 8:
            if eq20 { return (ell % 2 == 0 || charK == 2) ? 3 * s - 1 : 3 * s }
            if eq2s0 { return s }
        case 9:
            if eq20 { return 2 * s }
            if eq2s0 { return (ell % 2 == 1 || charK == 2) ? 6 * s - 1 : 6 * s }
        case 10:
            if eq20 { return (ell % 2 == 1 && charK == 3) ? 2 * s - 1 : 2 * s }
            if eq2s0 { return 6 * s }
        default: fatalError("Bad r=\(d)")
        }

        return 0
    }

    static func dimHH(_ deg: Int) -> Int {
        let n = PathAlg.n
        let s = PathAlg.s
        let charK = PathAlg.charK
        let ell = deg / PathAlg.twistPeriod
        let r = deg % PathAlg.twistPeriod
        let m = r / 2
        if s == 1 {
            if deg == 0 { return 3 }
            switch r {
            case 0: return ell % 2 == 0 ? (charK == 3 ? 2 : 1) : 0
            case 1: return 1
            case 2: return ell % 2 == 0 ? 0 : 1
            case 3: return ell % 2 == 1 || charK == 2 ? 1 : 0
            case 4: return ell % 2 == 0 ? (charK == 2 ? 1 : 0) : (charK == 3 ? 2 : 1)
            case 5: return charK == 3 ? 1 : 0
            case 6: return ell % 2 == 0 ? (charK == 3 ? 2 : 1) : (charK == 2 ? 1 : 0)
            case 7: return ell % 2 == 0 || charK == 2 ? 1 : 0
            case 8: return ell % 2 == 0 ? 1 : 0
            case 9: return 1
            case 10: return ell % 2 == 0 ? 0 : (charK == 3 ? 2 : 1)
            default: fatalError("Bad r=\(r)")
            }
        }
        let eq20 = ((ell * (n + s) + m) % (2 * s) == 0)
        let eq21 = ((ell * (n + s) + m) % (2 * s) == 1)
        let eq2s0 = ((ell * (n + s) + m) % (2 * s) == s)
        let eq2s1 = ((ell * (n + s) + m) % (2 * s) == s + 1)
        switch r {
        case 0:
            if eq20 && (ell % 2 == 0 || charK == 2) { return 1 }
            if eq2s1 && ell % 2 == 0 && charK == 3 { return 1 }
        case 1:
            if eq20 && (ell % 2 == 0 || charK == 2) { return 1 }
            if eq2s0 && (ell % 2 == 1 || charK == 2) { return 1 }
        case 2:
            if eq2s1 && (ell % 2 == 1 || charK == 2) { return 1 }
        case 3:
            if eq20 { return 1 }
            if eq2s0 && charK == 2 { return 1 }
        case 4:
            if eq2s0 && ell % 2 == 1 && charK == 3 { return 1 }
            if eq21 { return 1 }
            if eq2s1 && charK == 2 { return 1 }
        case 5:
            if eq20 && ell % 2 == 0 && charK == 3 { return 1 }
            if eq2s0 && ell % 2 == 1 && charK == 3 { return 1 }
        case 6:
            if eq20 && charK == 2 { return 1 }
            if eq2s0 { return 1 }
            if eq21 && ell % 2 == 0 && charK == 3 { return 1 }
        case 7:
            if eq20 && charK == 2 { return 1 }
            if eq2s0 { return 1 }
        case 8:
            if eq20 && (ell % 2 == 0 || charK == 2) { return 1 }
        case 9:
            if eq20 && (ell % 2 == 0 || charK == 2) { return 1 }
            if eq2s0 && (ell % 2 == 1 || charK == 2) { return 1 }
        case 10:
            if eq20 && ell % 2 == 1 && charK == 3 { return 1 }
            if eq2s1 && (ell % 2 == 1 || charK == 2) { return 1 }
        default: fatalError("Bad r=\(r)")
        }
        return 0
    }
}

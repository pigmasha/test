//
//  Created by M on 24.04.16.
//

import Foundation

struct Dim {
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
        let eq2s1 = ((ell * (n + s) + m) % (2 * s) == s + 1)
        switch r {
        case 0:
            if eq20 && (ell % 2 == 0 || charK == 2) { return (type == 1) }
            if eq2s1 && ell % 2 == 0 && charK == 3 { return (type == 2) }
        case 1:
            if eq20 && (ell % 2 == 0 || charK == 2) { return (type == 3) }
            if eq2s0 && (ell % 2 == 1 || charK == 2) { return (type == 4) }
        case 2:
            if eq2s1 && (ell % 2 == 1 || charK == 2) { return (type == 5) }
        case 3:
            if eq20 { return (type == 6) }
            if eq2s0 && charK == 2 { return (type == 7) }
        case 4:
            if eq2s0 && ell % 2 == 1 && charK == 3 { return (type == 8) }
            if eq21 { return (type == 9) }
            if eq2s1 && charK == 2 { return (type == 10) }
        case 5:
            if eq20 && ell % 2 == 0 && charK == 3 { return (type == 11) }
            if eq2s0 && ell % 2 == 1 && charK == 3 { return (type == 12) }
        case 6:
            if eq20 && charK == 2 { return (type == 13) }
            if eq2s0 { return (type == 14) }
            if eq21 && ell % 2 == 0 && charK == 3 { return (type == 15) }
        case 7:
            if eq20 && charK == 2 { return (type == 16) }
            if eq2s0 { return (type == 17) }
        case 8:
            if eq20 && (ell % 2 == 0 || charK == 2) { return (type == 18) }
        case 9:
            if eq20 && (ell % 2 == 0 || charK == 2) { return (type == 19) }
            if eq2s0 && (ell % 2 == 1 || charK == 2) { return (type == 20) }
        case 10:
            if eq20 && ell % 2 == 1 && charK == 3 { return (type == 21) }
            if eq2s1 && (ell % 2 == 1 || charK == 2) { return (type == 22) }
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
        let m = d / 2
        if s == 1 {
            let eq0 = ((ell * (n + 1) + m) % 2 == 0)
            switch d {
            case 0:
                return (eq0) ? 12 : 8
            case 1:
                return (eq0) ? 7 : 5
            case 2, 8:
                return (eq0) ? 6 : 2
            case 3, 5, 7:
                return 8
            case 4:
                return (eq0) ? 9 : 15
            case 6:
                return (eq0) ? 13 : 11
            case 9:
                return (eq0) ? 5 : 7
            case 10:
                return (eq0) ? 8 : 12
            default:
                return 0
            }
        }
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
        default:
            return 0
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
        default:
            break
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
            switch r {
            case 0:
                return (ell % 2 == 0) ? (charK == 3 ? 6 : 5) : 0
            case 1:
                return 1
            case 2:
                return (ell % 2 == 0) ? 0 : 1
            case 3:
                return (ell % 2 == 1 || charK == 2) ? 1 : 0
            case 4:
                return (ell % 2 == 0) ? (charK == 2 ? 1 : 0) : (charK == 3 ? 6 : 5)
            case 5:
                return (charK == 3) ? 1 : 0
            case 6:
                return (ell % 2 == 0) ? (charK == 3 ? 2 : 1) : (charK == 2 ? 5 : 4)
            case 7:
                return (ell % 2 == 0 || charK == 2) ? 1 : 0
            case 8:
                return (ell % 2 == 0) ? 1 : 0
            case 9:
                return 1
            case 10:
                return (ell % 2 == 0) ? 4 : (charK == 3 ? 2 : 1)
            default:
                return 0
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
        default:
            return 0
        }
        return 0
    }
}

//
//  Created by M on 28/05/2019.
//

import Foundation

struct Dim {
    static let typeMax = 24
    static let typeMax2 = 18

    static func deg(_ deg: Int, hasType type: Int) -> Bool {
        let s = PathAlg.s
        let ell = deg / PathAlg.twistPeriod
        let r = deg % PathAlg.twistPeriod
        let m = r / 2
        let charK = PathAlg.charK

        if deg == 0 && s == 1 && type >= 19 { return true }

        let eq0 = (m + 9 * ell) % s == 0
        let eq1 = (m + 9 * ell) % s == 1 || s == 1
        switch r {
        case 0:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 1 { return true }
            if eq1 && (ell % 2 == 1 || charK == 2 || (s == 1 && deg == 0)) && type == 2 { return true }
        case 1:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 3 { return true }
        case 3:
            if eq0 && (ell % 2 == 1 || charK == 2) && type == 4 { return true }
        case 4:
            if eq1 && (ell % 2 == 1 || charK == 2) && type == 5 { return true }
        case 5:
            if eq0 && ell % 2 == 0 && charK == 3 && type == 6 { return true }
        case 6:
            if eq1 && ell % 2 == 0 && charK == 3 && type == 7 { return true }
        case 7:
            if eq0 && (ell % 2 == 1 || charK == 2) && type == 8 { return true }
        case 8:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 9 { return true }
            if eq1 && (ell % 2 == 1 || charK == 2) && type == 10 { return true }
        case 9:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 11 { return true }
        case 10:
            if eq0 && ell % 2 == 1 && charK == 3 && type == 12 { return true }
        case 11:
            if eq0 && ell % 2 == 1 && charK == 3 && type == 13 { return true }
        case 12:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 14 { return true }
        case 13:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 15 { return true }
        case 15:
            if eq0 && (ell % 2 == 1 || charK == 2) && type == 16 { return true }
        case 16:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 17 { return true }
            if eq1 && (ell % 2 == 1 || charK == 2) && type == 18 { return true }
        default: break
        }
        return false
    }

    static func dimHom(_ deg: Int) -> Int {
        let s = PathAlg.s
        let ell = deg / PathAlg.twistPeriod
        let d = deg % PathAlg.twistPeriod
        let m = d / 2
        if s == 1 {
            switch d {
            case 0, 8, 16: return 14
            case 1, 4, 12, 15: return 8
            case 2, 14: return 5
            case 3, 13: return 9
            case 5, 11: return 10
            case 6, 7, 9, 10: return 12
            default: fatalError("Unknown d=\(d)")
            }
        }
        let eq0 = (m + 9 * ell) % s == 0
        let eq1 = (m + 9 * ell) % s == 1
        switch d {
        case 0, 8, 16: return eq0 || eq1 ? 7*s : 0
        case 1, 15: return eq0 ? 8*s : 0
        case 2: return (eq0 ? 4*s : 0) + (eq1 ? s : 0)
        case 3, 13: return eq0 ? 9*s : 0
        case 4: return (eq0 ? 3*s : 0) + (eq1 ? 5*s : 0)
        case 5, 11: return eq0 ? 10*s : 0
        case 6: return (eq0 ? 5*s : 0) + (eq1 ? 7*s : 0)
        case 7, 9: return eq0 ? 12*s : 0
        case 10: return (eq0 ? 7*s : 0) + (eq1 ? 5*s : 0)
        case 12: return (eq0 ? 5*s : 0) + (eq1 ? 3*s : 0)
        case 14: return (eq0 ? s : 0) + (eq1 ? 4*s : 0)
        default: fatalError("Unknown d=\(d)")
        }
    }

    static func dimIm(_ deg: Int) -> Int {
        let s = PathAlg.s
        let ell = deg / PathAlg.twistPeriod
        let d = deg % PathAlg.twistPeriod
        let m = d / 2
        let eq0 = (m + 9 * ell) % s == 0
        switch d {
        case 0, 7, 8, 15, 16: return eq0 ? ((ell + m) % 2 == 0 || PathAlg.charK == 2 ? 7*s-1 : 7*s) : 0
        case 1, 14: return eq0 ? s : 0
        case 2, 13: return eq0 ? 4*s : 0
        case 3, 12: return eq0 ? ((ell + m) % 2 == 0 || PathAlg.charK == 2 ? 5*s-1 : 5*s) : 0
        case 4, 11: return eq0 ? 3*s : 0
        case 5, 10: return eq0 ? ((ell + m) % 2 == 0 && PathAlg.charK == 3 ? 7*s-1 : 7*s) : 0
        case 6, 9: return eq0 ? 5*s : 0
        default: fatalError("Unknown d=\(d)")
        }
    }

    static func dimHH(_ deg: Int) -> Int {
        let s = PathAlg.s
        let ell = deg / PathAlg.twistPeriod
        let d = deg % PathAlg.twistPeriod
        let m = d / 2
        let charK = PathAlg.charK
        if s == 1 {
            if deg == 0 { return 8 }
            switch d {
            case 0, 8, 16:
                return charK == 2 ? 2 : 1
            case 1, 3, 7, 9, 12, 13, 15:
                if (ell + m) % 2 == 0 || charK == 2 { return 1 }
            case 4:
                if (ell + m) % 2 == 1 || charK == 2 { return 1 }
            case 6:
                if (ell + m) % 2 == 1 && charK == 3 { return 1 }
            case 5, 10, 11:
                if (ell + m) % 2 == 0 && charK == 3 { return 1 }
            default: break
            }
        }
        let eq0 = (m + 9 * ell) % s == 0
        let eq1 = (m + 9 * ell) % s == 1
        if [0, 1, 3, 7, 8, 9, 12, 13, 15, 16].contains(d) && eq0 && ((ell + m) % 2 == 0 || charK == 2) { return 1 }
        if [0, 4, 8, 16].contains(d) && eq1 && ((ell + m) % 2 == 1 || charK == 2) { return 1 }
        if [6].contains(d) && eq1 && (ell + m) % 2 == 1 && charK == 3 { return 1 }
        if [5, 10, 11].contains(d) && eq0 && (ell + m) % 2 == 0 && charK == 3 { return 1 }
        return 0
    }
}

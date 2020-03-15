//
//  Created by M on 28/05/2019.
//

import Foundation

struct Dim {
    static let typeMax = 28
    static let typeMax2 = 36

    static func deg(_ deg: Int, hasType type: Int) -> Bool {
        let s = PathAlg.s
        let ell = deg / PathAlg.twistPeriod
        let r = deg % PathAlg.twistPeriod
        let m = r / 2
        let charK = PathAlg.charK

        if deg == 0 && s == 1 && type > 28 { return true }

        let eq0 = (m + 15 * ell) % s == 0
        let eq1 = (m + 15 * ell) % s == 1 || s == 1
        switch r {
        case 0:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 1 { return true }
        case 1:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 2 { return true }
        case 3:
            if eq0 && (ell % 2 == 1 || charK == 2) && type == 3 { return true }
        case 4:
            if eq1 && (ell % 2 == 1 || charK == 2) && type == 4 { return true }
        case 5:
            if eq0 && ell % 2 == 0 && charK == 3 && type == 5 { return true }
        case 6:
            if eq1 && ell % 2 == 0 && charK == 3 && type == 6 { return true }
        case 7:
            if eq0 && (ell % 2 == 1 || charK == 2) && type == 7 { return true }
        case 8:
            if eq1 && (ell % 2 == 1 || charK == 2) && type == 8 { return true }
        case 9:
            if eq0 && ell % 2 == 0 && charK == 5 && type == 9 { return true }
        case 10:
            if eq0 && ell % 2 == 1 && charK == 3 && type == 10 { return true }
            if eq1 && ell % 2 == 0 && charK == 5 && type == 11 { return true }
        case 11:
            if eq0 && ell % 2 == 1 && charK == 3 && type == 12 { return true }
        case 12:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 13 { return true }
        case 13:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 14 { return true }
        case 15:
            if eq0 && (ell % 2 == 1 || charK == 2) && type == 15 { return true }
        case 16:
            if eq1 && (ell % 2 == 1 || charK == 2) && type == 16 { return true }
        case 17:
            if eq0 && ell % 2 == 0 && charK == 3 && type == 17 { return true }
        case 18:
            if eq0 && ell % 2 == 1 && charK == 5 && type == 18 { return true }
            if eq1 && ell % 2 == 0 && charK == 3 && type == 19 { return true }
        case 19:
            if eq0 && ell % 2 == 1 && charK == 5 && type == 20 { return true }
        case 20:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 21 { return true }
        case 21:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 22 { return true }
        case 22:
            if eq0 && ell % 2 == 1 && charK == 3 && type == 23 { return true }
        case 23:
            if eq0 && ell % 2 == 1 && charK == 3 && type == 24 { return true }
        case 24:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 25 { return true }
        case 25:
            if eq0 && (ell % 2 == 0 || charK == 2) && type == 26 { return true }
        case 27:
            if eq0 && (ell % 2 == 1 || charK == 2) && type == 27 { return true }
        case 28:
            if eq1 && (ell % 2 == 1 || charK == 2) && type == 28 { return true }
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
            case 0, 9, 14, 19, 28: return 16
            case 1, 4, 24, 27: return 9
            case 2, 26: return 6
            case 3, 25: return 10
            case 5, 23: return 11
            case 6, 22: return 13
            case 7, 21: return 14
            case 8, 20: return 12
            case 10, 18: return 23
            case 11, 13, 15, 17: return 18
            case 12, 16: return 17
            default: fatalError("Unknown d=\(d)")
            }
        }
        let eq0 = (m + 15 * ell) % s == 0
        let eq1 = (m + 15 * ell) % s == 1
        switch d {
        case 0, 14, 28: return eq0 || eq1 ? 8*s : 0
        case 1, 27: return eq0 ? 9*s : 0
        case 2: return (eq0 ? 5*s : 0) + (eq1 ? s : 0)
        case 3, 25: return eq0 ? 10*s : 0
        case 4: return (eq0 ? 4*s : 0) + (eq1 ? 5*s : 0)
        case 5, 23: return eq0 ? 11*s : 0
        case 6: return (eq0 ? 6*s : 0) + (eq1 ? 7*s : 0)
        case 7, 21: return eq0 ? 14*s : 0
        case 8: return (eq0 ? 4*s : 0) + (eq1 ? 8*s : 0)
        case 9, 19: return eq0 ? 16*s : 0
        case 10: return (eq0 ? 11*s : 0) + (eq1 ? 12*s : 0)
        case 11, 13, 15, 17: return eq0 ? 18*s : 0
        case 12: return (eq0 ? 10*s : 0) + (eq1 ? 7*s : 0)
        case 16: return (eq0 ? 7*s : 0) + (eq1 ? 10*s : 0)
        case 18: return (eq0 ? 12*s : 0) + (eq1 ? 11*s : 0)
        case 20: return (eq0 ? 8*s : 0) + (eq1 ? 4*s : 0)
        case 22: return (eq0 ? 7*s : 0) + (eq1 ? 6*s : 0)
        case 24: return (eq0 ? 5*s : 0) + (eq1 ? 4*s : 0)
        case 26: return (eq0 ? s : 0) + (eq1 ? 5*s : 0)
        default: fatalError("Unknown d=\(d)")
        }
    }

    static func dimIm(_ deg: Int) -> Int {
        let s = PathAlg.s
        let ell = deg / PathAlg.twistPeriod
        let d = deg % PathAlg.twistPeriod
        let m = d / 2
        let eq0 = (m + 15 * ell) % s == 0
        switch d {
        case 0, 7, 20, 27: return eq0 ? ((ell + m) % 2 == 0 || PathAlg.charK == 2 ? 8*s-1 : 8*s) : 0
        case 1, 26: return eq0 ? s : 0
        case 2, 25: return eq0 ? 5*s : 0
        case 3, 24: return eq0 ? ((ell + m) % 2 == 0 || PathAlg.charK == 2 ? 5*s-1 : 5*s) : 0
        case 4, 8, 19, 23: return eq0 ? 4*s : 0
        case 5, 22: return eq0 ? ((ell + m) % 2 == 0 && PathAlg.charK == 3 ? 7*s-1 : 7*s) : 0
        case 6, 21: return eq0 ? 6*s : 0
        case 9, 18: return eq0 ? ((ell + m) % 2 == 0 && PathAlg.charK == 5 ? 12*s-1 : 12*s) : 0
        case 10, 17: return eq0 ? ((ell + m) % 2 == 0 && PathAlg.charK == 3 ? 11*s-1 : 11*s) : 0
        case 11, 16: return eq0 ? 7*s : 0
        case 12, 15: return eq0 ? ((ell + m) % 2 == 0 || PathAlg.charK == 2 ? 10*s-1 : 10*s) : 0
        case 13, 14, 28: return eq0 ? 8*s : 0
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
            if deg == 0 { return 9 }
            if [0, 1, 3, 7, 12, 13, 15, 20, 21, 24, 25, 27].contains(d) && ((ell + m) % 2 == 0 || charK == 2) { return 1 }
            if [4, 8, 16, 28].contains(d) && ((ell + m) % 2 == 1 || charK == 2) { return 1 }
            if [5, 10, 11, 17, 22, 23].contains(d) && (ell + m) % 2 == 0 && charK == 3 { return 1 }
            if [6, 18].contains(d) && (ell + m) % 2 == 1 && charK == 3 { return 1 }
            if [9, 18, 19].contains(d) && (ell + m) % 2 == 0 && charK == 5 { return 1 }
            if [10].contains(d) && (ell + m) % 2 == 1 && charK == 5 { return 1 }
            return 0
        }
        let eq0 = (m + 15 * ell) % s == 0
        let eq1 = (m + 15 * ell) % s == 1
        if [0, 1, 3, 7, 12, 13, 15, 20, 21, 24, 25, 27].contains(d) && eq0 && ((ell + m) % 2 == 0 || charK == 2) { return 1 }
        if [4, 8, 16, 28].contains(d) && eq1 && ((ell + m) % 2 == 1 || charK == 2) { return 1 }
        if [5, 10, 11, 17, 22, 23].contains(d) && eq0 && (ell + m) % 2 == 0 && charK == 3 { return 1 }
        if [6, 18].contains(d) && eq1 && (ell + m) % 2 == 1 && charK == 3 { return 1 }
        if [9, 18, 19].contains(d) && eq0 && (ell + m) % 2 == 0 && charK == 5 { return 1 }
        if [10].contains(d) && eq1 && (ell + m) % 2 == 1 && charK == 5 { return 1 }
        return 0
    }
}

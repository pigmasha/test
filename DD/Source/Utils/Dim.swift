//
//  Dim.swift
//  DD
//
//  Created by M on 26.10.2021.
//

import Foundation

struct Dim {
    static func dimHom(deg d: Int) -> Int {
        return (d % 4 == 0 ? d / 2 + 1 : 2 * (d / 4 + 1)) * 4 * PathAlg.k
    }

    static func dimIm(deg d: Int) -> Int {
        let k = PathAlg.k
        let dIsZero = NumInt.isZero(n: PathAlg.d)
        let cIsZero = NumInt.isZero(n: PathAlg.c)
        switch d {
        case 0: return 3 * k - 3
        case 1:
            if PathAlg.charK == 2 {
                if dIsZero {
                    return k % 2 == 0 ? 4 * k - 3 : (cIsZero ? 4 * k - 3 : 4 * k - 2)
                } else {
                    return k % 2 == 0 ? 4 * k - 2 : 4 * k - 1
                }
            }
            if PathAlg.charK == 3 {
                return k % 3 == 0 ? 4 * k : 4 * k + 1
            }
            return 4 * k + 1
        case 2:
            if PathAlg.charK == 2 {
                return dIsZero ? 3 * k - 4 : 3 * k - 3
            } else {
                return 3 * k - 3
            }
        case 3:
            if PathAlg.charK == 0 { return 4 * k }
            if PathAlg.charK == 2 {
                return dIsZero ? 4 * k - 4 : 4 * k - 1
            }
            return k % PathAlg.charK == 0 ? 4 * k - 1 : 4 * k
        default: return -1
        }
    }

    static func dimKer(deg d: Int) -> Int {
        let k = PathAlg.k
        let dIsZero = NumInt.isZero(n: PathAlg.d)
        let cIsZero = NumInt.isZero(n: PathAlg.c)
        switch d {
        case 0: return k + 3
        case 1:
            if PathAlg.charK == 2 {
                if dIsZero {
                    return k % 2 == 0 ? 4 * k + 3 : (cIsZero ? 4 * k + 3 : 4 * k + 2)
                } else {
                    return k % 2 == 0 ? 4 * k + 2 : 4 * k + 1
                }
            }
            if PathAlg.charK == 3 {
                return k % 3 == 0 ? 4 * k : 4 * k - 1
            }
            return 4 * k - 1
        case 2:
            if PathAlg.charK == 2 {
                return dIsZero ? 5 * k + 4 : 5 * k + 3
            } else {
                return 5 * k + 3
            }
        case 3:
            if PathAlg.charK == 0 { return 4 * k }
            if PathAlg.charK == 2 {
                return dIsZero ? 4 * k + 4 : 4 * k + 1
            }
            return k % PathAlg.charK == 0 ? 4 * k + 1 : 4 * k
        default: return -1
        }
    }

    static func dimHH(deg d: Int) -> Int {
        let k = PathAlg.k
        let dIsZero = NumInt.isZero(n: PathAlg.d)
        let cIsZero = NumInt.isZero(n: PathAlg.c)
        switch d {
        case 0: return k + 3
        case 1:
            if PathAlg.charK == 2 {
                if dIsZero {
                    return k % 2 == 0 ? k + 6 : (cIsZero ? k + 6 : k + 5)
                } else {
                    return k % 2 == 0 ? k + 5 : k + 4
                }
            }
            if PathAlg.charK == 3 {
                return k % 3 == 0 ? k + 3 : k + 2
            }
            return k + 2
        case 2:
            if PathAlg.charK == 2 {
                if dIsZero {
                    return k % 2 == 0 ? k + 7 : (cIsZero ? k + 7 : k + 6)
                } else {
                    return k % 2 == 0 ? k + 5 : k + 4
                }
            }
            if PathAlg.charK == 3 {
                return k % 3 == 0 ? k + 3 : k + 2
            }
            return k + 2
        case 3:
            if PathAlg.charK == 0 { return k + 3 }
            if PathAlg.charK == 2 {
                return dIsZero ? k + 8 : k + 4
            }
            return k % PathAlg.charK == 0 ? k + 4 : k + 3
        case 4:
            if PathAlg.charK == 0 { return k + 4 }
            if PathAlg.charK == 2 {
                return dIsZero ? k + 11 : k + 5
            }
            return k % PathAlg.charK == 0 ? k + 5 : k + 4
        default:
            return dimHH(deg: d - 4) + (dIsZero && PathAlg.charK == 2 ? 8 : 2)
        }
    }
}

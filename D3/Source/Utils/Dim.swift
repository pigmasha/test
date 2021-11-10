//
//  Dim.swift
//
//  Created by M on 08.11.2021.
//

import Foundation

struct Dim {
    static func dimHom(_ deg: Int) -> Int {
        let k = deg / 3
        return (2 * k + (deg % 3 == 2 ? 2 : 1)) * 2 * PathAlg.N
    }

    static func dimIm(_ deg: Int) -> Int {
        switch deg {
        case 0: return PathAlg.N - 1
        case 1: return PathAlg.rkC
        case 2: return 3 * PathAlg.N - 2
        case 3: return 2 * PathAlg.N + PathAlg.rkC1
        default: return -1
        }
    }

    static func dimHH(_ deg: Int) -> Int {
        switch deg {
        case 0: return PathAlg.N + 1
        case 1: return PathAlg.N + 1 - PathAlg.rkC
        case 2: return PathAlg.N + 2 - PathAlg.rkC
        case 3: return PathAlg.N + 2 - PathAlg.rkC1
        case 4: return PathAlg.N + 1 - PathAlg.rkC1
        default:
            let d6 = deg % 6
            let d0 = d6 == 2 ? 4 : (d6 == 1 || d6 == 3 ? 2 : 0)
            return dimHH(deg - 4) + d0
        }
    }
}

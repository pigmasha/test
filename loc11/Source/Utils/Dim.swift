//
//  Dim.swift
//  Created by M on 23.05.2022.
//

import Foundation

struct Dim {
    static func dimHom(_ deg: Int) -> Int {
        return 4 * PathAlg.kk * Utils.qSize(deg)
    }

    static func dimIm(_ deg: Int) -> Int {
        let k = PathAlg.kk
        switch deg {
        case 0: return 3 * (k - 1)
        case 1: return k % 2 == 0 ? 4*k - 2 : 4*k - 1
        case 2: return 7*k - 4
        case 3: return 8*k - 2
        default: return dimIm(deg - 4) + 8*k - 2
        }
    }

    static func dimKer(_ deg: Int) -> Int {
        let k = PathAlg.kk
        switch deg {
        case 0: return k + 3
        case 1: return k % 2 == 0 ? 4*k + 2 : 4*k + 1
        case 2: return 5*k + 4
        case 3: return 8*k + 2
        default: return dimKer(deg - 4) + 8*k + 2
        }
    }

    static func dimHH(_ deg: Int) -> Int {
        let k = PathAlg.kk
        switch deg {
        case 0: return k + 3
        case 1: return k % 2 == 0 ? k + 5 : k + 4
        case 2: return dimHH(1) + 1
        case 3: return k + 6
        default: return dimHH(deg - 4) + 4
        }
    }
}

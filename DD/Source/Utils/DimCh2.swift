//
//  DimCh2.swift
//  Created by M on 25.10.2021.
//

import Foundation

struct DimCh2 {
    static func dimIm(deg: Int) -> Int {
        let k = PathAlg.k
        let dIsZero = NumInt.isZero(n: PathAlg.d)
        switch deg {
        case 0: return 3 * (k - 1)
        case 1:
            if dIsZero {
                return k % 2 == 0 ? 4 * k - 3 : 4 * k - 2
            } else {
                return k % 2 == 0 ? 4 * k - 2 : 4 * k - 1
            }
        case 2: return dIsZero ? 3 * k - 4 : 3 * k - 3
        case 3: return dIsZero ? 4 * k - 4 : 4 * k - 1
        default: return 0
        }
    }

    static func dimHH(deg: Int) -> Int {
        let k = PathAlg.k
        let dIsZero = NumInt.isZero(n: PathAlg.d)
        switch deg {
        case 0: return k + 3
        case 1:
            if dIsZero {
                return k % 2 == 0 ? k + 6 : k + 5
            } else {
                return k % 2 == 0 ? k + 5 : k + 4
            }
        case 2:
            if dIsZero {
                return k % 2 == 0 ? k + 7 : k + 6
            } else {
                return k % 2 == 0 ? k + 5 : k + 4
            }
        case 3: return dIsZero ? k + 8 : k + 4
        default: return dimHH(deg: deg - 4) + (dIsZero ? 8 : 2)
        }
    }
}

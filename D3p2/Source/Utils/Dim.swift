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

    static func dimHH(_ deg: Int) -> Int {
        let k = deg / 3
        switch deg {
        case 0: return PathAlg.N + 1
        default: return PathAlg.N - PathAlg.rkC + 4 * k + (deg % 3 == 2 ? 3 : 1)
        }
    }
}

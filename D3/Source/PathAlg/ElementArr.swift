//
//  ElementArr.swift
//  Created by M on 07.10.2021.
//

import Foundation

extension Array where Array.Element == D3.Element {
    var isZero: Bool {
        return !contains { !$0.isZero }
    }
    
    var str: String {
        return map { $0.str }.joined(separator: ", ")
    }

    func eqKoef(_ other: [Element]) -> Int {
        guard !isZero && !other.isZero && count == other.count else { return 0 }
        var kk = 0
        for i in 0 ..< count {
            if self[i].isZero != other[i].isZero { return 0 }
            if self[i].isZero { continue }
            let k = self[i].eqKoef(other[i])
            if k == 0 { return 0 }
            if kk > 0 && k != kk { return 0 }
            kk = k
        }
        return kk
    }
}

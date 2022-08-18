//
//  NumInt.swift
//  Created by M on 02.10.2021.
//

import Foundation

final class NumInt {
    private var nn: Int

    init(n: Int) {
        nn = 0
        self.n = n
    }

    var isZero: Bool {
        return nn == 0
    }

    var n: Int {
        get { return nn }
        set {
            nn = newValue
            if PathAlg.charK == 0 { return }
            if nn == 0 { return }
            if nn % PathAlg.charK == 0 { nn = 0; return }
            if PathAlg.charK == 2 { nn = 1; return }
            if nn == -1 || (nn > 0 && nn < PathAlg.charK - 1) { return }
            nn = nn % PathAlg.charK
            if nn == PathAlg.charK - 1 { nn = -1; return }
            if nn < -1 { nn += PathAlg.charK }
        }
    }

    // self = other * k
    func eqKoef(_ other: NumInt) -> Int {
        if n == other.n { return 1 }
        if n % other.n == 0 { return n / other.n }
        if PathAlg.charK < 3 { return 0 }

        for k0 in 2 ..< PathAlg.charK {
            let k = k0 == PathAlg.charK - 1 ? -1 : k0
            if (n - other.n * k) % PathAlg.charK == 0 { return k }
        }
        return 0
    }

    static func isZero(n: Int) -> Bool {
        return n == 0 || (PathAlg.charK != 0 && n % PathAlg.charK == 0)
    }
}

final class NumInt2 {
    var n: Int

    init(n: Int) {
        self.n = n
    }
}

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

    static func isZero(n: Int) -> Bool {
        return n == 0 || (PathAlg.charK != 0 && n % PathAlg.charK == 0)
    }
}

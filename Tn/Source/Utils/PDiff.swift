//
//  PDiff.swift
//  Created by M on 15.05.2022.
//

import Foundation
import AppKit

final class PDiff: PMatrix {
    let deg: Int
    let i: Int

    init(deg: Int, i: Int) {
        self.deg = deg
        self.i = i
        super.init(w: PDiff.qSize(deg + 1, i), h: PDiff.qSize(deg, i))
        createDiff()
    }

    private func createDiff() {
        switch PathAlg.n {
        case 4: createDiff4()
        case 5: createDiff5()
        default: break
        }
    }

    private static func qSize(_ d: Int, _ i: Int) -> Int {
        switch PathAlg.n {
        case 4: return qSize4(d, i)
        case 5: return qSize5(d, i)
        default: return 0
        }
    }
}


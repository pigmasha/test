//
//  Created by M on 26.02.2023.
//

import Foundation

final class Diff: Matrix {
    let deg: Int

    init(emptyForDeg deg: Int) {
        self.deg = deg
        super.init()
        makeZeroMatrix(BimodQ.size(deg: deg + 1), h: BimodQ.size(deg: deg))
    }

    init(deg: Int) {
        self.deg = deg
        super.init()
        makeZeroMatrix(BimodQ.size(deg: deg + 1), h: BimodQ.size(deg: deg))
        createDiff()
    }

    private func createDiff() {
        switch PathAlg.n {
        case 4: createDiff4()
        default: break
        }
    }
}

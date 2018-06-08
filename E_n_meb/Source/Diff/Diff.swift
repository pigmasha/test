//
//  Created by M on 24.04.16.
//

import Foundation

final class Diff: Matrix {
    let deg: Int

    override init() {
        self.deg = 0
        super.init()
    }

    init(deg: Int) {
        self.deg = deg
        super.init()

        createDiff()
    }
}

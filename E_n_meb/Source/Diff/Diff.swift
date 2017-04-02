//
//  Created by M on 24.04.16.
//
//

import Foundation

class Diff : Matrix {
    let deg: Int

    init(deg: Int) {
        self.deg = deg
        super.init()

        createDiffWithNumber(self, deg)
    }
}

//
//  Created by M on 22.01.17.
//

import Foundation

final class ShiftVariant {
    let hh: HHElem
    let key: NumInt?
    let nonZeroCnt: Int

    init(HH hh: HHElem, key: NumInt?) {
        self.hh = hh
        self.key = key
        var nonZero = 0
        for row in hh.rows {
            for c in row {
                if c.isZero == false {
                    nonZero += 1
                }
            }
        }
        nonZeroCnt = nonZero
    }
}

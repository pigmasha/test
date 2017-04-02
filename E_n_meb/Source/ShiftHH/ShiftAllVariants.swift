//
//  Created by M on 22.01.17.
//
//

import Foundation

class ShiftAllVariants :NSObject {
    let variants: [[ShiftVariant]]

    init(variants: [[ShiftVariant]]) {
        self.variants = variants
        super.init()
    }
}

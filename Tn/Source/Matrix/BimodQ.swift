//
//  Created by M on 25.02.2023.
//

import Foundation

final class BimodQ {
    let pij: [(Int, Int)]

    static func size(deg: Int) -> Int {
        switch PathAlg.n {
        case 4: return size4(deg)
        default: return 0
        }
    }

    init(deg: Int) {
        switch PathAlg.n {
        case 4: pij = BimodQ.pp4(deg)
        default: pij = []
        }
    }
}

final class PBimodQ {
    let p: [Int]

    init(deg: Int, i: Int) {
        switch PathAlg.n {
        case 4: p = PBimodQ.pp4(deg, i)
        default: p = []
        }
    }
}

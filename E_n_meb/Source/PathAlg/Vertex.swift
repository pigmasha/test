//
//  Created by M on 09.04.16.
//
//

import Foundation

final class Vertex: NSObject {
    private var i: Int

    convenience override init() {
        self.init(i: 0)
    }

    init(i: Int) {
        self.i = i
        super.init()
        self.reload()
    }

    var number: Int {
        get {
            return i
        }
        set {
            i = newValue
            reload()
        }
    }

    func isEq(_ other: Vertex) -> Bool {
        return other.number == i
    }

    var str: String {
        return "e\(i)"
    }

    var htmlStr: String {
        return "e\(i)"
    }

    private func reload() {
        let s = PathAlg.s
        i = myMod(i, mod: 8 * s)

        let x = i % 4
        if (x == 0 || x == 3) && i >= 4 * s {
            i -= 4 * s
        }
    }
}

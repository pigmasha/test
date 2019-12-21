//
//  Created by M on 09.04.16.
//

import Foundation

final class Vertex {
    private var i: Int

    init(i: Int) {
        self.i = i
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
        i = myMod(i, mod: 8 * PathAlg.s)
    }
}

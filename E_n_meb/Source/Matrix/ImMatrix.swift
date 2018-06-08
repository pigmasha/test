//
//  Created by M on 22.02.18.
//

import Foundation

final class ImMatrix {
    let deg: Int
    private var items: [ [WayPair] ]

    init(diff: Diff) {
        deg = diff.deg
        items = []
        for row in diff.rows {
            items += [ row.map { pairFromComb($0) } ]
        }
    }

    var rows: [ [WayPair] ] {
        return items
    }

    var height: Int {
        return items.count
    }

    func addRow(_ row: [WayPair]) {
        if row.count != items[0].count {
            items = []
        } else {
            items += [ row ]
        }
    }

    private func pairFromComb(_ c: Comb) -> WayPair {
        guard !c.isZero, let t = c.content.last else { return WayPair() }
        guard let w = ImMatrix.wayForTenzor(t.tenzor) else { return WayPair() }
        var k = 0.0
        for t in c.content {
            if ImMatrix.wayForTenzor(t.tenzor) != nil {
                k += t.koef
            }
        }
        return WayPair(way: w, koef: k)
    }

    static func wayForTenzor(_ tenzor: Tenzor) -> Way? {
        let w = Way(from: tenzor.rightComponent.endsWith.number, to: tenzor.leftComponent.startsWith.number)
        guard !w.isZero else { return nil }
        w.compLeft(tenzor.leftComponent)
        w.compRight(tenzor.rightComponent)
        return w.isZero ? nil : w
    }
}

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

    func addRow(_ row: [WayPair]) {
        if row.count != items[0].count {
            items = []
        } else {
            items += [ row ]
        }
    }

    private func pairFromComb(_ c: Comb) -> WayPair {
        guard !c.isZero, let t = c.content.last else { return WayPair(way: nil, koef: 0) }

        let w = Way(from: t.tenzor.rightComponent.endsWith.number, to: t.tenzor.leftComponent.startsWith.number)
        if !w.isZero {
            w.compLeft(t.tenzor.leftComponent)
            w.compRight(t.tenzor.rightComponent)
        }
        guard !w.isZero else { return WayPair(way: nil, koef: 0) }

        var k = 0.0
        for t in c.content {
            let w2 = Way(from: t.tenzor.rightComponent.endsWith.number, to: t.tenzor.leftComponent.startsWith.number)
            if !w2.isZero {
                w2.compLeft(t.tenzor.leftComponent)
                w2.compRight(t.tenzor.rightComponent)
            }
            if !w2.isZero {
                k += t.koef
            }
        }
        return WayPair(way: w, koef: k)
    }
}

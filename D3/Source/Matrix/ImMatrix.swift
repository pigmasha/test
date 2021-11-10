//
//  ImMatrix.swift
//  D3
//
//  Created by M on 07.11.2021.
//

import Foundation

final class ImMatrix {
    let rows: [[(Int, Way)]]

    init(diff: Diff) {
        var items: [[(Int, Way)]] = []
        for row in diff.rows {
            guard let c = row.first(where: { !$0.isZero }) else { fatalError() }
            let t = c.contents[0].1
            // t.leftComponent.startVertex = qTo.pij[i].0
            // t.rightComponent.endVertex = qTo.pij[i].1
            let ways = Way.allWays(from: t.rightComponent.endVertex, to: t.leftComponent.startVertex)
            for way in ways {
                let line = row.map { ImMatrix.pair(from: $0, way: way) }
                if line.contains(where: { $0.0 != 0 }) { items.append(line) }
            }
        }
        rows = items
    }

    private static func pair(from c: Comb, way: Way) -> (Int, Way) {
        if c.isZero { return (0, Way(vertexType: .e1)) }

        let wayFromTenzor: (Tenzor, Way) -> Way = { t, ww in
            let w = Way(way: t.leftComponent)
            w.compRight(ww)
            w.compRight(t.rightComponent)
            return w
        }

        let w = wayFromTenzor(c.contents[0].1, way)
        var kk = 0
        for (k, t) in c.contents {
            let w1 = wayFromTenzor(t, way)
            if w.isZero {
                if !w1.isZero { fatalError("Not zero for tenzor " + t.str + ", comb " + c.str) }
            } else {
                if w1.isZero { fatalError("Zero for tenzor " + t.str + ", comb " + c.str) }
                if !w.isEq(w1) { fatalError("Bad way for tenzor " + t.str + ", comb " + c.str) }
                kk += k.n
            }
        }
        return w.isZero || kk == 0 ? (0, Way(vertexType: .e1)) : (kk, w)
    }
}

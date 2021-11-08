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
        rows = diff.rows.map { row in
            row.map { ImMatrix.pair(from: $0) }
        }
    }

    private static func pair(from c: Comb) -> (Int, Way) {
        if c.isZero { return (0, Way(vertexType: .e1)) }

        let wayFromTenzor: (Tenzor) -> Way = { t in
            let w = Way(way: t.leftComponent)
            w.compRight(Way(from: t.rightComponent.endVertex, to: t.leftComponent.startVertex))
            w.compRight(t.rightComponent)
            return w
        }
        let w = wayFromTenzor(c.contents[0].1)
        var kk = 0
        for (k, t) in c.contents {
            let w1 = wayFromTenzor(t)
            if w.isZero {
                if !w1.isZero { fatalError("Not zero for tenzor " + t.str + ", comb " + c.str) }
            } else {
                if w1.isZero { fatalError("Zero for tenzor " + t.str + ", comb " + c.str) }
                if !w.isEq(w1) { fatalError("Bad way for tenzor " + t.str + ", comb " + c.str) }
                kk += k.n
            }
        }
        if w.isZero || kk == 0 { return (0, Way(vertexType: .e1)) }
        return (kk, w)
    }
}

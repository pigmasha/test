//
//  ImMatrix.swift
//  D3
//
//  Created by M on 07.11.2021.
//

import Foundation

enum ImMatrixResult {
    case ok(Int, Way)
    case error(String)
}

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
                if let line = ImMatrix.line(from: row, way: way) { items.append(line) }
            }
        }
        rows = items
    }

    init(mult: Matrix) {
        var items: [[(Int, Way)]] = []
        for row in mult.rows {
            guard let c = row.first(where: { !$0.isZero }) else { continue }
            let t = c.contents[0].1
            // t.leftComponent.startVertex = qTo.pij[i].0
            // t.rightComponent.endVertex = qTo.pij[i].1
            let ways = Way.allWays(from: t.rightComponent.endVertex, to: t.leftComponent.startVertex)
            for way in ways {
                if let line = ImMatrix.line(from: row, way: way) {
                    items.append(line);
                    break
                }
            }
        }
        if items.count > 1 {
            var line: [(Int, Way)] = []
            for j in 0 ..< items[0].count {
                var w: Way?
                var k = 0
                for item in items {
                    let pair = item[j]
                    if pair.0 == 0 { continue }
                    if let w = w {
                        if !pair.1.isEq(w) { fatalError("Bad ways in \(j)-th column") }
                    } else {
                        w = pair.1
                    }
                    k += pair.0
                }
                k = NumInt(n: k).n
                line.append(k == 0 ? (0, Way.zero) : (k, w!))
            }
            items = line.contains(where: { $0.0 != 0 }) ? [line] : []
        }
        rows = items
    }

    private static func line(from row: [Comb], way: Way) -> [(Int, Way)]? {
        var line: [(Int, Way)] = []
        for c in row {
            let res = ImMatrix.pair(from: c, way: way)
            switch res {
            case .ok(let k, let w):
                line.append((k, w))
            case .error(let error):
                OutputFile.writeLog(.error, error)
                fatalError(error)
            }
        }
        return line.contains(where: { $0.0 != 0 }) ? line : nil
    }

    static func pair(from c: Comb, way: Way?) -> ImMatrixResult {
        if c.isZero { return .ok(0, Way.zero) }

        var w: Way?
        var kk = 0
        for (k, t) in c.contents {
            let w1 = Way(way: t.leftComponent)
            if let way = way {
                if w1.startVertex != way.endVertex { return .error("Bad startVertex, comb " + c.str) }
                w1.compRight(way)
            }
            if !w1.isZero {
                if w1.startVertex != t.rightComponent.endVertex {
                    return .error("Bad startVertex: rightComponent=" + t.rightComponent.str + ", w1=" + w1.str + ", comb " + c.str)
                }
                w1.compRight(t.rightComponent)
            }
            if let w = w {
                if w.isZero {
                    if !w1.isZero { return .error("Not zero for tenzor " + t.str + ", comb " + c.str) }
                } else {
                    if w1.isZero { return .error("Zero for tenzor " + t.str + ", comb " + c.str) }
                    if !w.isEq(w1) { return .error("Bad way for tenzor " + t.str + ", comb " + c.str) }
                    kk += k.n
                }
            } else {
                w = w1
                kk += k.n
            }
        }
        kk = NumInt(n: kk).n
        return w!.isZero || kk == 0 ? .ok(0, Way.zero) : .ok(kk, w!)
    }
}

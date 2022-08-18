//
//  ImMatrix.swift
//  Created by M on 07.11.2021.
//

import Foundation

enum ImMatrixResult {
    case ok(Element)
    case error(String)
}

final class ImMatrix {
    let rows: [[Element]]

    convenience init(diff: Diff) {
        let ways = Way.allWays
        var items: [[Element]] = []
        for row in diff.rows {
            for way in ways {
                if let line = ImMatrix.line(from: row, way: way), !items.contains(where: { $0.eqKoef(line) != 0 }) {
                    items.append(line)
                }
            }
        }
        self.init(rows: items)
    }

    convenience init(mult: Matrix) {
        var items: [[Element]] = []
        for row in mult.rows {
            guard row.contains(where: { !$0.isZero }) else { continue }
            if let line = ImMatrix.line(from: row, way: Way.e), !items.contains(where: { $0.eqKoef(line) != 0 }) {
                items.append(line)
            }
        }
        if items.count > 1 {
            OutputFile.writeLog(.error, "Bad ImMatrix(mult:) rows count \(items.count)")
        }
        self.init(rows: items)
    }
    
    init(rows: [[Element]], zeroPrefixLen: Int = 0) {
        self.rows = zeroPrefixLen == 0 ? rows : rows.map { (1 ... zeroPrefixLen).map{ _ in Element() } + $0 }
        guard let w = rows.first?.count else { return }
        for r in rows {
            if r.count != w { fatalError("ImMatrix.init(rows:) bad count \(r.count)") }
        }
    }

    private static func line(from row: [Comb], way: Way) -> [Element]? {
        var line: [Element] = []
        for c in row {
            let res = ImMatrix.element(from: c, way: way)
            switch res {
            case .ok(let e):
                line.append(e)
            case .error(let error):
                OutputFile.writeLog(.error, error)
                fatalError(error)
            }
        }
        return line.contains(where: { !$0.isZero }) ? line : nil
    }

    static func element(from c: Comb, way: Way?) -> ImMatrixResult {
        if c.isZero { return .ok(Element()) }

        let e = Element()
        for (k, t) in c.contents {
            let w1 = Way(way: t.leftComponent)
            way.flatMap { w1.compRight($0) }
            if !w1.isZero {
                w1.compRight(t.rightComponent)
            }
            if !w1.isZero { e.add(way: w1, koef: k.n) }
        }
        return .ok(e)
    }
}

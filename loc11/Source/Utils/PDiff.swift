//
//  PDiff.swift
//  Created by M on 15.05.2022.
//

import Foundation
import AppKit

final class PDiff: PMatrix {
    let deg: Int

    init(deg: Int) {
        self.deg = deg

        super.init(w: Utils.qSize(deg + 1), h: Utils.qSize(deg))
        createDiff()
    }

    private func createDiff() {
        let h = rows.count

        /* GAI */
        /*if deg % 2 == 0 {
            for i in 0 ..< h {
                rows[i][i].add(element: i % 2 == 0 ? xElement : yWaveElement)
                rows[i][i + 1].add(element: i % 2 == 0 ? yElement : xWaveElement)
            }
        } else {
            for i in 0 ..< h {
                rows[i][i].add(element: i % 2 == 0 ? xWaveElement : yElement)
                rows[i][i + 1].add(element: i % 2 == 0 ? xElement : yWaveElement)
            }
        }*/

        if deg % 2 == 0 {
            for i in 0 ..< h {
                if i == 0 {
                    rows[i][i].add(element: xElement)
                } else {
                    rows[i][i - 1].add(element: i % 2 == 0 ? zxElement : zyElement)
                }
                rows[i][i + 1].add(element: i % 2 == 0 ? yElement : xElement)
            }
        } else {
            for i in 0 ..< h {
                if i == 0 {
                    rows[i][i].add(element: zyElement)
                } else {
                    rows[i][i - 1].add(element: i % 2 == 0 ? zyElement : zxElement)
                }
                rows[i][i + 1].add(element: i % 2 == 0 ? xWaveElement : yWaveElement)
            }
        }
    }

    private var xElement: Element {
        return Element(way: Way.x, koef: 1)
    }

    private var yElement: Element {
        return Element(way: Way.y, koef: 1)
    }

    private var zxElement: Element {
        return Element(way: Way(type: .x, len: 2 * PathAlg.kk - 1), koef: 1)
    }

    private var zyElement: Element {
        return Element(way: Way(type: .y, len: 2 * PathAlg.kk - 1), koef: 1)
    }

    private var xWaveElement: Element {
        let e = xElement
        e.add(element: zyElement)
        return e
    }

    private var yWaveElement: Element {
        let e = yElement
        e.add(element: zxElement)
        return e
    }
}


//
//  PDiff.swift
//  Created by M on 17.10.2021.
//

import Foundation

final class PDiff: PMatrix {
    let deg: Int

    init(deg: Int) {
        self.deg = deg

        let qSize: (Int) -> Int = { d in
            return d % 4 == 0 ? d / 2 + 1 : 2 * (d / 4 + 1)
        }
        super.init(w: qSize(deg + 1), h: qSize(deg))
        createDiff()
    }

    private func createDiff() {
        let h = rows.count
        
        switch deg % 4 {
        case 0:
            for i in 0 ..< h {
                rows[i][i].add(element: i % 2 == 0 ? yElement : minusYWaveElement)
            }
            for i in 0 ..< h {
                rows[i][i+1].add(element: i == h - 1 ? xElement : hiElement)
            }
            break
        case 1:
            for i in 0 ..< h {
                rows[i][i].add(element: i == h - 1 ? minusXElement : (i % 2 == 0 ? yWaveElement : minusYElement))
            }
            for i in 0 ..< h-1 {
                rows[i][i+1].add(element: i == h - 2 ? psyElement : hiElement)
            }
            break
        case 2:
            for i in 0 ..< h {
                rows[i][i].add(element: i == h - 1 ? minusYXElement : (i % 2 == 0 ? yElement : minusYWaveElement))
            }
            for i in 0 ..< h-1 {
                rows[i][i+1].add(element: hiElement)
            }
            break
        case 3:
            for i in 0 ..< h {
                rows[i][i].add(element: i % 2 == 0 ? yWaveElement : minusYElement)
            }
            for i in 0 ..< h {
                rows[i][i+1].add(element: hiElement)
            }
            break
        default: fatalError()
        }
    }

    private var xElement: Element {
        return Element(way: Way.x, koef: 1)
    }

    private var minusXElement: Element {
        return Element(way: Way.x, koef: -1)
    }

    private var yElement: Element {
        return Element(way: Way.y, koef: 1)
    }

    private var minusYElement: Element {
        return Element(way: Way.y, koef: -1)
    }

    private var yWaveElement: Element {
        let e = yElement
        e.add(way: Way(type: .x, len: 2 * PathAlg.k - 1), koef: -PathAlg.d)
        return e
    }

    private var minusYWaveElement: Element {
        let e = yWaveElement
        e.compKoef(-1)
        return e
    }

    private var psyElement: Element {
        let e = Element(way: Way(type: .y, len: 2 * PathAlg.k - 2), koef: 1)
        e.add(way: Way(type: .x, len: 2 * PathAlg.k - 1), koef: PathAlg.c)
        return e
    }

    private var minusYXElement: Element {
        return Element(way: Way(type: .y, len: 2), koef: -1)
    }

    private var hiElement: Element {
        return Element(way: Way(type: .x, len: 2 * PathAlg.k - 1), koef: 1)
    }
}

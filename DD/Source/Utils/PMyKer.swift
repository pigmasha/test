//
//  PMyKer.swift
//  Created by M on 08.10.2021.
//

import Foundation

struct PMyKer {
    static func ker(_ deg: Int) -> PElements {
        let k = PathAlg.k
        var items: [[Element]] = []
        items.append([Element(way: Way(type: .x, len: 2), koef: 1), Element()])
        if PathAlg.d == 0 {
            items.append([Element(), Element(way: Way(type: .y, len: 1), koef: 1)])
        } else {
            items.append([Element(), Element(way: Way(type: .y, len: 2), koef: 1)])
            items.append([Element(way: Way(type: .y, len: 2 * k - 1), koef: -PathAlg.d),
                          Element(way: Way(type: .y, len: 1), koef: 1)])
        }
        if PathAlg.c == 0 {
            items.append([Element(way: Way(type: .x, len: 1), koef: -1),
                          Element(way: Way(type: .x, len: 2 * k - 2), koef: 1)])
        }
        items.append([Element(way: Way(type: .y, len: 2 * k - 1), koef: -1),
                      Element(way: Way(type: .x, len: 2 * k - 1), koef: 1)])
        return PElements(type: .ker, items: items)
    }
}

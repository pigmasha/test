//
//  Created by M on 15.02.2023.
//

import Foundation

extension PDiff {
    static func qSize4(_ d: Int, _ i: Int) -> Int {
        switch i {
        case 1, 2, 4, 5: return d % 2 == 0 ? d + 1 : (d + 1) / 2
        case 3: return d % 2 == 0 ? d + 1 : 2 * (d + 1)
        default: return d
        }
    }

    func createDiff4() {
        if i == 3 {
            switch deg % 4 {
            case 0: createDiff430()
            case 1: createDiff431()
            case 2: createDiff432()
            case 3: createDiff433()
            default: fatalError()
            }
        } else {
            switch deg % 4 {
            case 0: createDiff40()
            case 1: createDiff41()
            case 2: createDiff42()
            case 3: createDiff43()
            default: fatalError()
            }
        }
    }

    private func createDiff40() {
        rows[0][0].add(way: i > 3 ? Way(type: .beta, num: i == 5 && deg == 0 ? 4 : 3) : Way(type: .alpha, num: i), koef: 1)
        if deg == 0 { return }
        for i in 0 ..< deg / 4 {
            put4D1(at: (1 + 4 * i, 2 * i), isLast: i == deg / 4 - 1, isFirst: i == 0)
        }
    }

    private func createDiff41() {
        rows[0][0].add(way: Way(type: .beta, num: i > 3 ? 1 : 3 - i), koef: 1)
        rows[0][1].add(way: i > 3 ? Way.b2 : Way.a3, koef: 1)
        rows[0][2].add(way: i == 5 && deg == 1 ? Way.a3 : Way.a4, koef: 1)
        if deg == 1 { return }
        for i in 0 ..< (deg - 1) / 4 {
            put4D2(at: (2 * i + 1, 4 * i + 2), isLast: i == (deg - 1) / 4 - 1)
        }
    }

    private func createDiff42() {
        rows[0][0].add(way: Way(type: .alpha, num: i > 3 ? 1 : 3 - i), koef: 1)
        rows[1][0].add(way: i > 3 ? Way.a2 : Way.b3, koef: -1)
        rows[1][1].add(way: i > 3 ? Way.a2 : Way.b3, koef: 1)
        rows[2][1].add(way: i == 5 && deg == 2 ? Way.b3 : Way.b4, koef: -1)
        if deg == 2 { return }
        for i in 0 ..< (deg - 2) / 4 {
            put4D3(at: (4 * i + 3, 2 * i + 1), isLast: i == (deg - 2) / 4 - 1)
        }
    }

    private func createDiff43() {
        rows[0][0].add(way: i > 3 ? Way.a3 : Way(type: .beta, num: i), koef: 1)
        rows[0][1].add(way: Way.a4, koef: 1)
        rows[0][2].add(way: i > 3 ? Way.b2 : Way.a3, koef: 1)
        rows[1][2].add(way: i > 3 ? Way.b2 : Way.a3, koef: 1)
        rows[1][3].add(way: Way.b1, koef: 1)
        rows[1][4].add(way: i > 3 ? Way(type: .alpha, num: i == 5 && deg == 3 ? 4 : 3) : Way.b2, koef: 1)
        if deg == 3 { return }
        for i in 0 ..< (deg - 3) / 4 {
            put4D4(at: (2 * i + 2, 4 * i + 4), isLast: i == (deg - 3) / 4 - 1)
        }
    }

    private func put4D1(at pos: (Int, Int), isLast: Bool, isFirst: Bool) {
        rows[pos.0][pos.1].add(way: Way.b4, koef: isFirst ? -1 : 1)
        rows[pos.0][pos.1 + 1].add(way: Way.b4, koef: isFirst ? 1 : -1)
        rows[pos.0 + 1][pos.1 + 1].add(way: i > 3 ? Way.a2 : Way.b3, koef: isFirst ? -1 : 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way.a1, koef: 1)
        rows[pos.0 + 2][pos.1 + 2].add(way: Way.a1, koef: 1)
        rows[pos.0 + 3][pos.1 + 2].add(way: i > 3 ? Way(type: .beta, num: i == 5 && isLast ? 4 : 3) : Way.a2, koef: -1)
    }

    private func put4D3(at pos: (Int, Int), isLast: Bool) {
        rows[pos.0][pos.1].add(way: i > 3 ? Way.b3 : Way.a2, koef: 1)
        rows[pos.0][pos.1 + 1].add(way: i > 3 ? Way.b3 : Way.a2, koef: -1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way.a1, koef: 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: i > 3 ? Way.a2 : Way.b3, koef: 1)
        rows[pos.0 + 2][pos.1 + 2].add(way: i > 3 ? Way.a2 : Way.b3, koef: 1)
        rows[pos.0 + 3][pos.1 + 2].add(way: i == 5 && isLast ? Way.b3 : Way.b4, koef: -1)
    }

    private func put4D2(at pos: (Int, Int), isLast: Bool) {
        rows[pos.0][pos.1].add(way: Way.a4, koef: 1)
        rows[pos.0][pos.1 + 1].add(way: i > 3 ? Way.a3 : Way.b2, koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way.b1, koef: 1)
        rows[pos.0 + 1][pos.1 + 2].add(way: Way.b1, koef: -1)
        rows[pos.0 + 1][pos.1 + 3].add(way: i > 3 ? Way.b2 : Way.a3, koef: 1)
        rows[pos.0 + 1][pos.1 + 4].add(way: i == 5 && isLast ? Way.a3 : Way.a4, koef: 1)
    }

    private func put4D4(at pos: (Int, Int), isLast: Bool) {
        rows[pos.0][pos.1].add(way: i > 3 ? Way.a3 : Way.b2, koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way.a4, koef: 1)
        rows[pos.0][pos.1 + 2].add(way: i > 3 ? Way.b2 : Way.a3, koef: 1)
        rows[pos.0 + 1][pos.1 + 2].add(way: i > 3 ? Way.b2 : Way.a3, koef: -1)
        rows[pos.0 + 1][pos.1 + 3].add(way: Way.b1, koef: 1)
        rows[pos.0 + 1][pos.1 + 4].add(way: i > 3 ? Way(type: .alpha, num: i == 5 && isLast ? 4 : 3) : Way.b2, koef: 1)
    }

    // i = 3
    private func createDiff430() {
        put43D1(at: (deg / 2, deg))
        if deg == 0 { return }
        for i in 0 ..< deg / 4 {
            put43D2(at: (2 * i, 4 * i), isWave: i == 0)
        }
        for i in 0 ..< deg / 4 {
            put43D3(at: (2 * i + deg / 2 + 1, 4 * i + deg + 3))
        }
    }

    private func createDiff431() {
        put43D4(at: (deg - 1, (deg - 1) / 2))
        for i in 0 ..< (deg - 1) / 4 {
            put43D5(at: (4 * i, 2 * i), isWave: i == 0)
        }
        for i in 0 ..< (deg - 1) / 4 {
            put43D6(at: (4 * i + deg + 3, 2 * i + (deg - 1) / 2 + 2))
        }
    }

    private func createDiff432() {
        put43D7(at: ((deg - 2) / 2, deg - 2), isWave: true, isFirst: deg == 2)
        put43D8(at: (deg / 2, deg + 1), isWave: true, isFirst: true)
        for i in 0 ..< (deg - 2) / 4 {
            put43D7(at: (2 * i, 4 * i), isWave: false, isFirst: i == 0)
        }
        for i in 0 ..< (deg - 2) / 4 {
            put43D8(at: (2 * i + deg / 2 + 2, 4 * i + deg + 5), isWave: false, isFirst: false)
        }
    }

    private func createDiff433() {
        for i in 0 ... (deg - 3) / 4 {
            put43D9(at: (4 * i, 2 * i), isWave: i == 0)
        }
        for i in 0 ... (deg - 3) / 4 {
            put43D10(at: (4 * i + deg + 1, 2 * i + (deg + 1) / 2), isWave: i == 0)
        }
    }

    private func put43D1(at pos: (Int, Int)) {
        rows[pos.0][pos.1].add(way: Way.b1, koef: deg == 0 ? 1 : -1)
        rows[pos.0][pos.1 + 1].add(way: Way.b2, koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way.a3, koef: 1)
        rows[pos.0][pos.1 + 3].add(way: Way.a4, koef: 1)
    }

    private func put43D2(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1].add(way: Way.b1, koef: isWave ? 1 : -1)
        rows[pos.0][pos.1 + 1].add(way: Way.b2, koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way.a4, koef: 1)
        rows[pos.0 + 1][pos.1 + 2].add(way: Way.a4, koef: 1)
        rows[pos.0 + 1][pos.1 + 3].add(way: Way.a3, koef: 1)
        rows[pos.0 + 1][pos.1 + 4].add(way: Way.b1, koef: 1)
    }

    private func put43D3(at pos: (Int, Int)) {
        rows[pos.0][pos.1].add(way: Way.a4, koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way.b2, koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way.b1, koef: 1)
        rows[pos.0 + 1][pos.1 + 2].add(way: Way.b1, koef: -1)
        rows[pos.0 + 1][pos.1 + 3].add(way: Way.a3, koef: 1)
        rows[pos.0 + 1][pos.1 + 4].add(way: Way.a4, koef: 1)
    }

    private func put43D4(at pos: (Int, Int)) {
        rows[pos.0][pos.1].add(way: Way.a1, koef: 1)
        rows[pos.0 + 1][pos.1].add(way: Way.a2, koef: deg == 1 ? -1 : 1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way.a2, koef: 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way.b3, koef: -1)
        rows[pos.0 + 2][pos.1 + 2].add(way: Way.b3, koef: 1)
        rows[pos.0 + 3][pos.1 + 2].add(way: Way.b4, koef: -1)
    }

    private func put43D5(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1].add(way: Way.a1, koef: 1)
        rows[pos.0 + 1][pos.1].add(way: Way.a2, koef: isWave ? -1 : 1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way.a2, koef: 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way.b4, koef: -1)
        rows[pos.0 + 3][pos.1 + 1].add(way: Way.b3, koef: 1)
        rows[pos.0 + 3][pos.1 + 2].add(way: Way.b3, koef: -1)
    }

    private func put43D6(at pos: (Int, Int)) {
        rows[pos.0][pos.1].add(way: Way.a2, koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way.a2, koef: -1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way.a1, koef: 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way.b3, koef: 1)
        rows[pos.0 + 2][pos.1 + 2].add(way: Way.b3, koef: 1)
        rows[pos.0 + 3][pos.1 + 2].add(way: Way.b4, koef: -1)
    }

    private func put43D7(at pos: (Int, Int), isWave: Bool, isFirst: Bool) {
        rows[pos.0][pos.1].add(way: Way.a3, koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way.a4, koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way.b2, koef: 1)
        rows[pos.0 + 1][pos.1 + 2].add(way: Way.b2, koef: isFirst ? 1 : -1)
        rows[pos.0 + 1][pos.1 + 3].add(way: Way.b1, koef: 1)
        if !isWave { rows[pos.0 + 1][pos.1 + 4].add(way: Way.a3, koef: 1) }
    }

    private func put43D8(at pos: (Int, Int), isWave: Bool, isFirst: Bool) {
        if !isWave { rows[pos.0][pos.1].add(way: Way.b2, koef: 1) }
        rows[pos.0][pos.1 + 1].add(way: Way.a4, koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way.a3, koef: 1)
        rows[pos.0 + 1][pos.1 + 2].add(way: Way.a3, koef: isFirst ? 1 : -1)
        rows[pos.0 + 1][pos.1 + 3].add(way: Way.b1, koef: 1)
        rows[pos.0 + 1][pos.1 + 4].add(way: Way.b2, koef: 1)
    }

    private func put43D9(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1].add(way: Way.b3, koef: isWave ? 1 : -1)
        rows[pos.0 + 1][pos.1].add(way: Way.b4, koef: isWave ? -1 : 1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way.b4, koef: isWave ? 1 : -1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way.a2, koef: isWave ? -1 : 1)
        rows[pos.0 + 3][pos.1 + 1].add(way: Way.a1, koef: 1)
        rows[pos.0 + 3][pos.1 + 2].add(way: Way.a1, koef: 1)
    }

    private func put43D10(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1].add(way: Way.b4, koef: isWave ? -1 : 1)
        rows[pos.0][pos.1 + 1].add(way: Way.b4, koef: isWave ? 1 : -1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way.b3, koef: isWave ? -1 : 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way.a1, koef: 1)
        rows[pos.0 + 2][pos.1 + 2].add(way: Way.a1, koef: 1)
        rows[pos.0 + 3][pos.1 + 2].add(way: Way.a2, koef: -1)
    }
}

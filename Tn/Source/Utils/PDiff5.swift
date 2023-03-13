//
//  Created by M on 15.02.2023.
//

import Foundation

extension PDiff {
    static func qSize5(_ d: Int, _ i: Int) -> Int {
        return d == 0 ? 1 : d - (d - 1) / 3
    }

    func createDiff5() {
        switch deg % 4 {
        case 0: createDiff50()
        case 1: createDiff51()
        case 2: createDiff52()
        case 3: createDiff53()
        default: fatalError()
        }
    }

    private func createDiff50() {
        if deg == 0 {
            rows[0][0].add(way: Way(type: .alpha, num: 1), koef: 1)
            return
        }
        put5D0(at: (0, 0))
        if deg > 4 {
            for i in 0 ..< (deg + 4) / 12 {
                put5D1(at: (3 + 8 * i, 3 + 8 * i), isWave: i == (deg + 4) / 12 - 1 && deg % 12 == 8)
            }
        }
        if deg > 8 {
            for i in 0 ..< deg / 12 {
                put5D2(at: (6 + 8 * i, 5 + 8 * i), isWave: i == deg / 12 - 1 && deg % 12 == 0)
            }
        }
        if deg > 12 {
            for i in 0 ..< (deg - 4) / 12 {
                put5D3(at: (9 + 8 * i, 8 + 8 * i))
            }
        }
    }

    private func createDiff51() {
        put5D4(at: (0, 0), isWave: deg == 1)
        if deg > 1 {
            for i in 0 ..< (deg + 7) / 12 {
                put5D5(at: (1 + 8 * i, 8 * i), isWave: i == (deg + 7) / 12 - 1 && deg % 12 == 5, isWave2: i > 0)
            }
        }
        if deg > 5 {
            for i in 0 ..< (deg + 3) / 12 {
                put5D6(at: (4 + 8 * i, 3 + 8 * i), isWave: i == (deg + 3) / 12 - 1 && deg % 12 == 9)
            }
        }
        if deg > 9 {
            for i in 0 ..< (deg - 1) / 12 {
                put5D7(at: (7 + 8 * i, 6 + 8 * i))
            }
        }
    }

    private func createDiff52() {
        put5D8(at: (0, 0), isWave: deg == 2)
        if deg > 2 {
            for i in 0 ..< (deg + 6) / 12 {
                put5D2(at: (2 + 8 * i, 1 + 8 * i), isWave: i == (deg + 6) / 12 - 1 && deg % 12 == 6)
            }
        }
        if deg > 6 {
            for i in 0 ..< (deg + 2) / 12 {
                put5D3(at: (5 + 8 * i, 4 + 8 * i))
            }
        }
        if deg > 10 {
            for i in 0 ..< (deg - 2) / 12 {
                put5D1(at: (7 + 8 * i, 7 + 8 * i), isWave: i == (deg - 2) / 12 - 1 && deg % 12 == 2)
            }
        }
    }

    private func createDiff53() {
        put5D9(at: (0, 0), isWave: deg == 3)
        if deg > 3 {
            for i in 0 ..< (deg + 5) / 12 {
                put5D7(at: (3 + 8 * i, 2 + 8 * i))
            }
        }
        if deg > 7 {
            for i in 0 ..< (deg + 1) / 12 {
                put5D5(at: (5 + 8 * i, 4 + 8 * i), isWave: i == (deg + 1) / 12 - 1 && deg % 12 == 11, isWave2: true)
            }
        }
        if deg > 11 {
            for i in 0 ..< (deg - 3) / 12 {
                put5D6(at: (8 + 8 * i, 7 + 8 * i), isWave: i == (deg - 3) / 12 - 1 && deg % 12 == 3)
            }
        }
    }

    private func put5D0(at pos: (Int, Int)) {
        rows[pos.0][pos.1].add(way: Way(type: .beta, num: 3), koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way(type: .alpha, num: 4), koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way(type: .alpha, num: 5), koef: 1)
        rows[pos.0 + 1][pos.1].add(way: Way(type: .alpha, num: 1), koef: 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way(type: .alpha, num: 4), koef: 1)
        rows[pos.0 + 2][pos.1 + 3].add(way: Way(type: .beta, num: 3), koef: 1)
    }

    private func put5D1(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1 + 1].add(way: Way(type: .alpha, num: 1), koef: 1)
        rows[pos.0 + 1][pos.1].add(way: Way(type: .alpha, num: 2), koef: 1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way(type: .alpha, num: 2), koef: 1)
        rows[pos.0 + 2][pos.1 + 1].add(way: Way(type: .beta, num: 3), koef: 1)
        rows[pos.0 + 2][pos.1 + 2].add(way: Way(type: .alpha, num: isWave ? 4 : 5), koef: 1)
        rows[pos.0 + 2][pos.1 + 3].add(way: Way(type: .alpha, num: isWave ? 5 : 4), koef: 1)
    }

    private func put5D2(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1].add(way: Way(type: .alpha, num: 5), koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way(type: .beta, num: 3), koef: 1)
        rows[pos.0 + (isWave ? 1 : 2)][pos.1 + 2].add(way: Way(type: .alpha, num: 1), koef: 1)
        rows[pos.0 + (isWave ? 1 : 2)][pos.1 + 3].add(way: Way(type: .alpha, num: 1), koef: 1)
        rows[pos.0 + (isWave ? 2 : 1)][pos.1 + 3].add(way: Way(type: .alpha, num: 2), koef: 1)
    }

    private func put5D3(at pos: (Int, Int)) {
        rows[pos.0][pos.1].add(way: Way(type: .beta, num: 3), koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way(type: .alpha, num: 4), koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way(type: .alpha, num: 5), koef: 1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way(type: .alpha, num: 4), koef: 1)
        rows[pos.0 + 1][pos.1 + 3].add(way: Way(type: .beta, num: 3), koef: 1)
    }

    private func put5D4(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1 + (isWave ? 0 : 1)].add(way: Way(type: .beta, num: 2), koef: 1)
        rows[pos.0][pos.1 + (isWave ? 1 : 0)].add(way: Way(type: .alpha, num: 3), koef: 1)
    }

    private func put5D5(at pos: (Int, Int), isWave: Bool, isWave2: Bool) {
        rows[pos.0][pos.1 + 2].add(way: Way(type: .beta, num: 4), koef: 1)
        rows[pos.0 + 1][pos.1 + (isWave2 ? 1 : 0)].add(way: Way(type: .beta, num: 5), koef: 1)
        rows[pos.0 + 1][pos.1 + 2].add(way: Way(type: .beta, num: 5), koef: 1)
        rows[pos.0 + 2][pos.1 + 2].add(way: Way(type: .alpha, num: 3), koef: 1)
        rows[pos.0 + 2][pos.1 + (isWave ? 3 : 4)].add(way: Way(type: .beta, num: 1), koef: 1)
        rows[pos.0 + 2][pos.1 + (isWave ? 4 : 3)].add(way: Way(type: .beta, num: 2), koef: 1)
    }

    private func put5D6(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1].add(way: Way(type: .beta, num: 2), koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way(type: .alpha, num: 3), koef: 1)
        rows[pos.0 + (isWave ? 1 : 2)][pos.1 + 2].add(way: Way(type: .beta, num: 4), koef: 1)
        rows[pos.0 + (isWave ? 1 : 2)][pos.1 + 3].add(way: Way(type: .beta, num: 4), koef: 1)
        rows[pos.0 + (isWave ? 2 : 1)][pos.1 + 3].add(way: Way(type: .beta, num: 5), koef: 1)
    }

    private func put5D7(at pos: (Int, Int)) {
        rows[pos.0][pos.1].add(way: Way(type: .alpha, num: 3), koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way(type: .beta, num: 1), koef: 1)
        rows[pos.0][pos.1 + 2].add(way: Way(type: .beta, num: 2), koef: 1)
        rows[pos.0 + 1][pos.1 + 1].add(way: Way(type: .beta, num: 1), koef: 1)
        rows[pos.0 + 1][pos.1 + 3].add(way: Way(type: .alpha, num: 3), koef: 1)
    }

    private func put5D8(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0 + (isWave ? 0 : 1)][pos.1].add(way: Way(type: .alpha, num: 2), koef: 1)
        rows[pos.0 + (isWave ? 1 : 0)][pos.1].add(way: Way(type: .beta, num: 3), koef: 1)
        rows[pos.0 + (isWave ? 1 : 0)][pos.1 + (isWave ? 1 : 2)].add(way: Way(type: .alpha, num: 4), koef: 1)
        rows[pos.0 + (isWave ? 1 : 0)][pos.1 + (isWave ? 2 : 1)].add(way: Way(type: .alpha, num: 5), koef: 1)
    }

    private func put5D9(at pos: (Int, Int), isWave: Bool) {
        rows[pos.0][pos.1].add(way: Way(type: .alpha, num: 3), koef: 1)
        rows[pos.0][pos.1 + 1].add(way: Way(type: .beta, num: 1), koef: 1)
        rows[pos.0 + (isWave ? 1 : 2)][pos.1].add(way: Way(type: .beta, num: 4), koef: 1)
        rows[pos.0 + (isWave ? 1 : 2)][pos.1 + 2].add(way: Way(type: .beta, num: 4), koef: 1)
        rows[pos.0 + (isWave ? 2 : 1)][pos.1 + 2].add(way: Way(type: .beta, num: 5), koef: 1)
    }
}

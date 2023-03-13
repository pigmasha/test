//
//  Created by M on 25.02.2023.
//

import Foundation

extension BimodQ {
    static func size4(_ deg: Int) -> Int {
        return deg % 2 == 0 ? 5 * (deg + 1) : 4 * (deg + 1)
    }

    static func pp4(_ deg: Int) -> [(Int, Int)] {
        var r: [(Int, Int)] = []
        if deg % 2 == 1 {
            for i in 1 ... 2 {
                for _ in 0 ... (deg - 1) / 2 { r.append((3, i)) }
            }
            if deg % 4 == 1 {
                if deg > 1 {
                    for _ in 0 ..< (deg - 1) / 4 { r += [(1, 3), (2, 3), (5, 3), (4, 3)] }
                }
                r += [(1, 3), (2, 3), (4, 3), (5, 3)]
                if deg > 1 {
                    for _ in 0 ..< (deg - 1) / 4 { r += [(2, 3), (1, 3), (4, 3), (5, 3)] }
                }
            } else {
                for _ in 0 ... (deg - 3) / 4 { r += [(4, 3), (5, 3), (2, 3), (1, 3)] }
                for _ in 0 ... (deg - 3) / 4 { r += [(5, 3), (4, 3), (1, 3), (2, 3)] }
            }
            for i in 4 ... 5 {
                for _ in 0 ... (deg - 1) / 2 { r.append((3, i)) }
            }
        } else if deg % 4 == 0 {
            for i in 1 ... 2 {
                r.append((i, i))
                if deg == 0 { continue }
                for _ in 0 ..< deg / 4 { r += [(5, i), (4, i), (1, i), (2, i)] }
            }
            for _ in 0 ... deg { r.append((3, 3)) }
            r.append((4, 4))
            if deg > 0 {
                for _ in 0 ..< deg / 4 { r += [(5, 4), (2, 4), (1, 4), (4, 4)] }
            }
            if deg > 0 {
                for _ in 0 ..< deg / 4 { r += [(4, 5), (5, 5), (2, 5), (1, 5)] }
            }
            r.append((5, 5))
        } else {
            for i in 1 ... 2 {
                r += [(3 - i, i), (4, i), (5, i)]
                if deg == 2 { continue }
                for _ in 0 ..< (deg - 2) / 4 {
                    r += [(2, i), (1, i), (4, i), (5, i)]
                }
            }
            for _ in 0 ... deg { r.append((3, 3)) }
            r += [(1, 4), (2, 4), (5, 4)]
            if deg > 2 {
                for _ in 0 ..< (deg - 2) / 4 { r += [(4, 4), (1, 4), (2, 4), (5, 4)] }
            }
            if deg > 2 {
                for _ in 0 ..< (deg - 2) / 4 { r += [(1, 5), (2, 5), (5, 5), (4, 5)] }
            }
            r += [(1, 5), (2, 5), (4, 5)]
        }
        return r
    }
}

extension PBimodQ {
    static func pp4(_ deg: Int, _ i: Int) -> [Int] {
        if i != 3 && deg % 2 == 1 {
            return (0 ... (deg - 1) / 2).map { _ in 3 }
        }
        switch i {
        case 1, 2: return pp412(deg, i)
        case 3: return pp43(deg)
        case 4: return pp44(deg, i)
        case 5: return pp45(deg, i)
        default: return []
        }
    }

    private static func pp412(_ deg: Int, _ i: Int) -> [Int] {
        if deg % 4 == 0 {
            var r = [i]
            if deg == 0 { return r }
            for _ in 0 ..< deg / 4 {
                r += [5, 4, 1, 2]
            }
            return r
        } else {
            var r = [3 - i, 4, 5]
            if deg == 2 { return r }
            for _ in 0 ..< (deg - 2) / 4 {
                r += [2, 1, 4, 5]
            }
            return r
        }
    }

    private static func pp44(_ deg: Int, _ i: Int) -> [Int] {
        if deg % 4 == 0 {
            var r = [i]
            if deg == 0 { return r }
            for _ in 0 ..< deg / 4 {
                r += [5, 2, 1, 4]
            }
            return r
        } else {
            var r = [1, 2, 5]
            if deg == 2 { return r }
            for _ in 0 ..< (deg - 2) / 4 {
                r += [4, 1, 2, 5]
            }
            return r
        }
    }

    private static func pp45(_ deg: Int, _ i: Int) -> [Int] {
        if deg % 4 == 0 {
            var r = [i]
            if deg == 0 { return r }
            for _ in 0 ..< deg / 4 {
                r = [4, 5, 2, 1] + r
            }
            return r
        } else {
            var r = [1, 2, 4]
            if deg == 2 { return r }
            for _ in 0 ..< (deg - 2) / 4 {
                r = [1, 2, 5, 4] + r
            }
            return r
        }
    }

    private static func pp43(_ deg: Int) -> [Int] {
        if deg % 2 == 0 {
            return (0 ... deg).map { _ in 3 }
        }
        if deg % 4 == 1 {
            var r = [1, 2, 4, 5]
            if deg == 1 { return r }
            for _ in 0 ..< (deg - 1) / 4 {
                r = [1, 2, 5, 4] + r + [2, 1, 4, 5]
            }
            return r
        } else {
            var r: [Int] = []
            for _ in 0 ... (deg - 3) / 4 {
                r = [4, 5, 2, 1] + r + [5, 4, 1, 2]
            }
            return r
        }
    }
}

//
//  Created by M on 22/02/2019.
//

class PElements {
    let type: PElementsType
    let items: [[WayKoef]]

    init(type: PElementsType, items: [[WayKoef]]) {
        self.type = type
        self.items = items
    }

    func contains(_ item: [WayKoef]) -> Bool {
        if items.contains(where: { $0.isEq(item)}) { return true }

        if let idx1 = item.firstIndex(where: { $0.koefs.count == 1 && abs($0.koefs[0]) == 2 }),
            let idx2 = item.lastIndex(where: { $0.koefs.count == 1 && abs($0.koefs[0]) == 2 }), idx1 != idx2 {
            var item1 = item
            item1[idx1] = WayKoef.zero
            item1[idx2] = WayKoef.zero
            var item2 = item.map { _ in WayKoef.zero }
            item2[idx1] = item[idx1].half!
            item2[idx2] = item[idx2].half!
            if contains(item1) && contains(item2) { return true }
            return false
        }
        if let idx = item.firstIndex(where: { $0.koefs.count == 1 && abs($0.koefs[0]) == 2 }) {
            var item1 = item
            item1[idx] = item[idx].half!
            var item2 = item.map { _ in WayKoef.zero }
            item2[idx] = item[idx].half!
            if contains(item1) && contains(item2) { return true }
            var item3 = item
            item3[idx] = WayKoef.zero
            if contains(item3) && contains(item2) { return true }
            return false
        }
        if let idx1 = item.firstIndex(where: { $0.koefs.count == 2 }),
            let idx2 = item.lastIndex(where: { $0.koefs.count == 2 }), idx1 != idx2 {
            if true {
                var item1 = item
                item1[idx1] = item[idx1].part1!
                item1[idx2] = item[idx2].part1!
                var item2 = item.map { _ in WayKoef.zero }
                item2[idx1] = item[idx1].part2!
                item2[idx2] = item[idx2].part2!
                if contains(item1) && contains(item2) { return true }
            }
            if true {
                var item1 = item
                item1[idx1] = item[idx1].part1!
                item1[idx2] = item[idx2].part2!
                var item2 = item.map { _ in WayKoef.zero }
                item2[idx1] = item[idx1].part2!
                item2[idx2] = item[idx2].part1!
                if contains(item1) && contains(item2) { return true }
            }
            if true {
                var item1 = item
                item1[idx1] = item[idx1].part2!
                item1[idx2] = item[idx2].part2!
                var item2 = item.map { _ in WayKoef.zero }
                item2[idx1] = item[idx1].part1!
                item2[idx2] = item[idx2].part1!
                if contains(item1) && contains(item2) { return true }
            }
            return false
        }
        if let idx = item.firstIndex(where: { $0.koefs.count == 2 }) {
            if true {
                var item1 = item
                item1[idx] = item[idx].part1!
                var item2 = item.map { _ in WayKoef.zero }
                item2[idx] = item[idx].part2!
                if contains(item1) && contains(item2) { return true }
            }
            if item.count > 1 {
                var item1 = item
                item1[idx] = item[idx].part2!
                var item2 = item.map { _ in WayKoef.zero }
                item2[idx] = item[idx].part1!
                if contains(item1) && contains(item2) { return true }
            }
            return false
        }
        let splitByPos = { (i: Int) -> Bool in
            var item1 = item
            item1[i] = WayKoef.zero
            var item2 = item.map { _ in WayKoef.zero }
            item2[i] = item[i]
            //if item.count == 3 { OutputFile.writeLog(.simple, "$$\(item.str) = \(item1.str) (+) \(item2.str)$$\n") }
            return self.contains(item1) && self.contains(item2)
        }
        if let idx1 = item.firstIndex(where: { !$0.isZero }), let idx2 = item.lastIndex(where: { !$0.isZero }), idx1 != idx2 {
            if splitByPos(idx1) { return true }
            if splitByPos(idx2) { return true }
            if idx1 + 1 != idx2 && !item[idx1 + 1].isZero {
                if splitByPos(idx1 + 1) { return true }
            }
            return false
        }
        return false
    }

    func printTex() {
        OutputFile.writeLog(.simple, "$$\\text{\(type == .ker ? "Ker" : "Im"): }")
        for i in 0 ..< items.count {
            OutputFile.writeLog(.simple, (i == 0 ? "" : ", ") + items[i].str)
            if i % 7 == 6 {
                OutputFile.writeLog(.simple, "$$\n$$")
            }
        }
        OutputFile.writeLog(.simple, "$$\n")
    }
}

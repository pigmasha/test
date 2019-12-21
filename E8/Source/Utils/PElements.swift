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
        for mode in 0 ... 2 {
            var shortItem = item
            while true {
                guard !shortItem.isZero else { break }
                var hasChange = false
                for i in 0 ..< items.count {
                    guard let dd = shortItem.dividePartBy(items[i]) else { continue }
                    guard var mayBeItem = shortItem.addSummand(other: items[i].map { $0.compLeft(dd.0) }, koef: -dd.1) else { continue }
                    if mode == 1, let ii = items.firstIndex(where: { $0.isSummand(of: mayBeItem) != nil }) {
                        mayBeItem = mayBeItem.addSummand(other: items[ii], koef: items[ii].isSummand(of: mayBeItem)! * -1)!
                    }
                    /*if mode == 2, let ii = items.lastIndex(where: { mayBeItem.dividePartBy($0) != nil }) {
                        let dd = mayBeItem.dividePartBy(items[ii])!
                        if let mayBeItem2 = mayBeItem.addSummand(other: items[ii].map { $0.compLeft(dd.0) }, koef: -dd.1),
                            mayBeItem2.weight < mayBeItem.weight {
                            mayBeItem = mayBeItem2
                        }
                    }*/
                    if mayBeItem.weight < shortItem.weight {
                        shortItem = mayBeItem
                        hasChange = true
                    }
                }

                if !hasChange, let ii = items.firstIndex(where: { $0.isSummand(of: shortItem) != nil }) {
                    shortItem = shortItem.addSummand(other: items[ii], koef: items[ii].isSummand(of: shortItem)! * -1)!
                    hasChange = true
                }
                if !hasChange {
                    break
                }
            }
            if shortItem.isZero { return true }
        }
        return false
    }

    func printTex() {
        OutputFile.writeLog(.simple, "$$\\text{\(type == .ker ? "Ker" : "Im"): }")
        for i in 0 ..< items.count {
            OutputFile.writeLog(.simple, (i == 0 ? "" : ", ") + items[i].str)
            if i % 4 == 3 {
                OutputFile.writeLog(.simple, "$$\n$$")
            }
        }
        OutputFile.writeLog(.simple, "$$\n")
    }
}

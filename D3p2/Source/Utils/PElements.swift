//
//  Created by M on 22/02/2019.
//

enum PElementsType {
    case ker, im
}

final class PElements {
    let type: PElementsType
    let items: [[Element]]

    init(type: PElementsType, items: [[Element]]) {
        self.type = type
        self.items = items
    }

    var htmlStr: String {
        var s = type == .ker ? "Ker: " : "Im: "
        for i in 0 ..< items.count {
            s += (i == 0 ? "" : ", ") + "(" + items[i].map{ $0.str }.joined(separator: " ") + ")"
        }
        return s
    }
}

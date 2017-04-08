//
//  Created by M on 22.01.17.
//
//

import Foundation

class ShiftAllVariants : NSObject {
    let seqNumber: [Int]
    let variants: [[ShiftVariant]]

    init?(seqNumber: [Int], variants: [[ShiftVariant]]) {
        self.seqNumber = seqNumber
        self.variants = variants
        super.init()
    }

    convenience init?(withContentsOf path: String) {
        guard let seqNumber = ShiftAllVariants.seqNumber(withContentsOf: path) else { return nil }
        guard let variants = ShiftAllVariants.variants(withContentsOf: path) else { return nil }
        self.init(seqNumber: seqNumber, variants: variants)
    }

    func isEq(to object: ShiftAllVariants) -> Bool {
        let otherVariants = object.variants
        guard seqNumber == object.seqNumber else {
            OutputFile.writeLog(0, "different seqNumbers \(seqNumber) != \(object.seqNumber)")
            return false
        }
        guard variants.count == otherVariants.count else {
            OutputFile.writeLog(0, "different counts \(variants.count) != \(otherVariants.count)")
            return false
        }
        for i in 0 ..< variants.count {
            guard variants[i].count == otherVariants[i].count else {
                OutputFile.writeLog(0, "different variants counts \(variants[i].count) != \(otherVariants[i].count)")
                return false
            }
            for j in 0 ..< variants[i].count {
                guard (variants[i][j].key == nil && otherVariants[i][j].key == nil) ||
                    (variants[i][j].key != nil && otherVariants[i][j].key != nil &&
                        variants[i][j].key?.intValue == otherVariants[i][j].key?.intValue) else {
                    OutputFile.writeLog(0, "different keys \(variants[i][j].key) != \(otherVariants[i][j].key)")
                    return false
                }
                let hh = variants[i][j].hh
                let otherHH = otherVariants[i][j].hh
                guard hh.deg == otherHH.deg else {
                    OutputFile.writeLog(0, "hh.degs \(hh.deg) != \(otherHH.deg)")
                    return false
                }
                guard hh.type == otherHH.type else {
                    OutputFile.writeLog(0, "hh.types \(hh.type) != \(otherHH.type)")
                    return false
                }
                guard hh.isEq(otherHH, debug: true) else {
                    OutputFile.writeLog(0, "matrixes not eq")
                    return false
                }
            }
        }
        return true
    }

    func writeToFile(_ path: String) -> Bool {
        var str = "SeqNumber: "
        for n in seqNumber {
            str += "\(n),"
        }
        str += "\n"
        for i in 0 ..< variants.count {
            str += "Column: \(i), count=\(variants[i].count)\n"
            for variant in variants[i] {
                let keyStr = variant.key == nil ? "" : String(variant.key!.intValue)
                str += "Key: " + keyStr + ", hh.deg: \(variant.hh.deg), hh.type: \(variant.hh.type)\n"
                for row in variant.hh.rows {
                    for comb in row {
                        str += comb.str + " | "
                    }
                    str += "\n"
                }
                str += "\n\n"
            }
        }
        do {
            try str.write(toFile: path, atomically: true, encoding: .utf8)
        } catch {
            return false
        }
        return true
    }

    private static func seqNumber(withContentsOf path: String) -> [Int]? {
        guard let str = try? String(contentsOfFile: path, encoding: .utf8) else {
            OutputFile.writeLog(0, "failed to read file")
            return nil
        }
        guard let numbers = str.components(separatedBy: "\n").first else {
            OutputFile.writeLog(0, "no numbers")
            return nil
        }
        var result: [Int] = []
        for number in numbers.components(separatedBy: ": ").last!.components(separatedBy: ",") {
            guard number != "" else { continue }
            guard let n = Int(number) else {
                OutputFile.writeLog(0, "bad number \(number)")
                return nil
            }
            result += [ n ]
        }
        return result
    }

    private static func variants(withContentsOf path: String) -> [[ShiftVariant]]? {
        guard let str = try? String(contentsOfFile: path, encoding: .utf8) else {
            OutputFile.writeLog(0, "failed to read file")
            return nil
        }
        let parts = str.components(separatedBy: "Column: ")
        var variants: [[ShiftVariant]] = []
        for part in parts {
            guard part != "" else { continue }
            guard part.range(of: "SeqNumber: ") == nil else { continue }
            guard let count = parseCount(part) else { return nil }
            let hhs = part.components(separatedBy: "\n\n")
            var items: [ShiftVariant] = []
            for hh in hhs {
                guard hh != "" && hh != "\n" else { continue }
                guard let item = parseShiftVariant(hh) else { return nil }
                items += [item]
            }
            guard count == items.count else {
                OutputFile.writeLog(0, "fail to compare counts \(count) != \(hhs.count)")
                return nil
            }
            variants += [items]
        }
        return variants
    }

    private static func parseCount(_ str: String) -> Int? {
        guard let range = str.range(of: "count=\\d+\n", options: .regularExpression, range: nil, locale: nil) else {
            OutputFile.writeLog(0, "no count= in str \(str)")
            return nil
        }
        var countStr = str.substring(with: range)
        countStr = countStr.substring(from: countStr.index(countStr.startIndex, offsetBy: 6))
        countStr = countStr.substring(to: countStr.index(countStr.endIndex, offsetBy: -1))
        guard let count = Int(countStr) else {
            OutputFile.writeLog(0, "failed to parse count in \(str)")
            return nil
        }
        return count
    }

    private static func parseShiftVariant(_ str: String) -> ShiftVariant? {
        guard let range = str.range(of: "Key: \\d*, hh.deg: \\d+, hh.type: \\d+\n", options: .regularExpression, range: nil, locale: nil) else {
            OutputFile.writeLog(0, "no key= in str \(str)")
            return nil
        }
        let countsStr = str.substring(with: range)
        let counts = countsStr.components(separatedBy: CharacterSet(charactersIn: " ,\n"))
        guard counts.count == 9 && counts[0] == "Key:" && counts[2] == ""
            && counts[3] == "hh.deg:" && counts[5] == ""
            && counts[6] == "hh.type:" && counts[8] == "" else {
            OutputFile.writeLog(0, "bad countsStr=\(countsStr)")
            return nil
        }
        let key = counts[1] == "" ? nil : NumInt(intValue: Int(counts[1])!)
        guard let deg = Int(counts[4]) else {
            OutputFile.writeLog(0, "parse hh.deg failed, countsStr=\(countsStr)")
            return nil
        }
        guard let type = Int(counts[7]) else {
            OutputFile.writeLog(0, "parse hh.type failed, countsStr=\(countsStr)")
            return nil
        }
        guard let hh = parseHH(str, hh: HHElem(degree: deg, type: type)) else { return nil }
        return ShiftVariant(HH: hh, key: key)
    }

    private static func parseHH(_ str: String, hh: HHElem) -> HHElem? {
        let parts = str.components(separatedBy: "\n")
        var height = 0
        var width = 0
        for part in parts {
            guard part != "" && part.range(of: "count=") == nil && part.range(of: "Key:") == nil else { continue }
            height += 1
            let pp = part.components(separatedBy: " | ")
            guard pp.count > 1 else {
                OutputFile.writeLog(0, "bad pp.count, part=\(part)")
                return nil
            }
            if width == 0 {
                width = pp.count - 1
            } else {
                guard width == pp.count - 1 else {
                    OutputFile.writeLog(0, "bad width \(width) != \(pp.count - 1)")
                    return nil
                }
            }
        }
        hh.makeZeroMatrix(width, h: height)
        var i = 0
        for part in parts {
            guard part != "" && part.range(of: "count=") == nil && part.range(of: "Key:") == nil else { continue }
            let pp = part.components(separatedBy: " | ")
            var j = 0
            for combStr in pp {
                guard combStr != "" else { continue }
                guard let c = parseComb(combStr) else { return nil }
                if !c.isZero {
                    hh.rows[i][j].addComb(c)
                }
                j += 1
            }
            i += 1
        }
        return hh
    }

    private static func parseComb(_ str: String) -> Comb? {
        guard str != "0" else { return Comb() }
        let pair = str.trimmingCharacters(in: CharacterSet(charactersIn: "-")).components(separatedBy: "*")
        guard pair.count == 2 else {
            OutputFile.writeLog(0, "parse comb failed: count != 2, comb=\(str)")
            return nil
        }
        guard let left = parseWay(pair[0]), let right = parseWay(pair[1]) else { return nil }
        return Comb(tenzor: Tenzor(left: left, right: right), koef: str.characters.first == "-" ? -1.0 : 1.0)
    }

    private static func parseWay(_ str: String) -> Way? {
        if str.characters.first == "e" {
            return Way(from: Int(str.trimmingCharacters(in: CharacterSet(charactersIn: "e")))!, len: 0)
        }
        let koefs = str.components(separatedBy: CharacterSet(charactersIn: "ag"))
        guard koefs.count > 1 && koefs.first == "" else {
            OutputFile.writeLog(0, "parseWay failed: bad koefs, way=\(str)")
            return nil
        }
        guard let koef1 = Int(koefs[1]) else {
            OutputFile.writeLog(0, "parseWay failed: bad 1st koef, way=\(str)")
            return nil
        }
        guard let koef2 = Int(koefs.last!) else {
            OutputFile.writeLog(0, "parseWay failed: bad last koef, way=\(str)")
            return nil
        }
        let letters = str.components(separatedBy: CharacterSet.decimalDigits)
        var lastG = false
        for letter in letters {
            switch letter {
            case "a": lastG = false
            case "g": lastG = true
                case "": break
            default:
                OutputFile.writeLog(0, "parseWay failed: bad letter \(letter), way=\(str)")
                return nil
            }
        }
        let from = str.characters.first == "g" ? 4 * koef1 + 3 : 4 * Int(koef1 / 3) + (koef1 % 3)
        let to = lastG ? 4 * koef2 + 4 : 4 * Int(koef2 / 3) + (koef2 % 3) + 1
        let way = Way(from: from, to: to, noZeroLen: true)
        guard way.str == str else {
            OutputFile.writeLog(0, "parseWay failed, source=\(str), result=\(way.str)")
            return nil
        }
        return way
    }
}

//
//  E7_tex
//  Created by M on 22/04/2019.
//

enum TexDiffConverterError: Swift.Error {
    case badPartsCount(String)
    case noPrefix(String)
    case noMatrixSize(String)
    case noJLimits(String)
    case badLastLine(String)
    case badLine(String)
}

struct TexDiffConveter {
    static func convert(source: String) throws -> String {
        var str = ""
        let parts = source.components(separatedBy: "private func createDiffWithNumber")
        guard parts.count == 18 else {
            throw TexDiffConverterError.badPartsCount("not 18 parts: \(parts.count)")
        }
        for d in 0 ..< 17 {
            let s = parts[d+1].components(separatedBy: "private func addTenToPos")[0]
            guard s.hasPrefix("\(d)()") else {
                throw TexDiffConverterError.noPrefix("part \(d): no prefix \(d)() in part \(s)")
            }
            guard let sizes = s.scanFirst(regexp: "makeZeroMatrix\\(([0-9]+s), h:.?([0-9]+s)\\)") else {
                throw TexDiffConverterError.noMatrixSize("part \(d): no matrix size \(s)")
            }
            str += "\n\\centerline{\\bf Description of the $d_{\(d)}$}\n"
            str += "\\centerline{$d_{\(d)}:Q_{\(d+1)}\\rightarrow Q_{\(d)}\\text{ -- is an } (\(sizes[1])\\times \(sizes[0]))\\text{ matrix}.$}\n"
            let fors = s.components(separatedBy: "for j in ")
            for i in 1 ..< fors.count {
                var forStr = fors[i]
                guard let jj = forStr.scanFirst(regexp: "([0-9]*s?) \\.\\.< ([0-9]*s)") else {
                    throw TexDiffConverterError.noJLimits("for \(i): no size \(forStr)")
                }
                str += "If $\(jj[0])\\le j<\(jj[1])$, then $$(d_{\(d)})_{ij}=\\begin{cases}\n"
                forStr = forStr.trimmingCharacters(in: .whitespacesAndNewlines)
                forStr = forStr.replacingOccurrences(of: " ", with: "")
                forStr = forStr.replacingOccurrences(of: "\t", with: "")
                forStr = forStr.replacingOccurrences(of: "%s", with: "_s")
                var lines = forStr.components(separatedBy: "\n")
                lines.remove(at: 0)
                guard lines.popLast() == "}" else {
                    throw TexDiffConverterError.badLastLine("for \(i): \(forStr)")
                }
                if i == fors.count - 1 {
                    guard lines.popLast() == "}" else {
                        throw TexDiffConverterError.badLastLine("for \(i): \(forStr)")
                    }
                }
                var j = 0
                while j < lines.count {
                    let line = lines[j]
                    j += 1
                    guard line != "letj_2=j/s" else { continue }
                    if line.hasPrefix("addTenToPos") {
                        str += try parseAddTen(line)
                        continue
                    }
                    if line.hasPrefix("forj_1in") {
                        guard let j1 = line.scanFirst(regexp: "forj_1in([0-9])..<([0-9])") else {
                            throw TexDiffConverterError.badLine("for \(i), \(j): no j1 range, line=\(line); d=\(d)")
                        }
                        guard lines[j].hasPrefix("addTenToPos") else {
                            throw TexDiffConverterError.badLine("for \(i), \(j): bad next line, line=\(line), lines=\(lines)); d=\(d)")
                        }
                        guard lines[j+1] == "}" else {
                            throw TexDiffConverterError.badLine("for \(i), \(j): bad next next line, line=\(line); d=\(d)")
                        }
                        str += try parseAddTen(lines[j], ",\\text{ }\(j1[0])\\le j_1< \(j1[1])")
                        j += 2
                        continue
                    }
                    throw TexDiffConverterError.badLine("for \(i), \(j): bad prefix, line=\(line)")
                }
                str += "0,\\quad\\text{otherwise.}\\end{cases}$$\n"
            }
        }
        return str
    }

    private static func parseAddTen(_ line: String, _ suffix: String = "") throws -> String {
        guard line.hasSuffix(")") else {
            throw TexDiffConverterError.badLine("bad bounds: no ) at the end, line=\(line)")
        }
        let isNoZero = line.hasPrefix("addTenToPosNoZero(")
        guard line.hasPrefix("addTenToPos(") || isNoZero else {
            throw TexDiffConverterError.badLine("bad bounds, line=\(line)")
        }
        var str = line
        str.removeFirst(isNoZero ? "addTenToPosNoZero(".count : "addTenToPos(".count)
        str.removeLast()
        let parts = str.components(separatedBy: ",")
        var p = ""
        var items: [String] = []
        for part in parts {
            guard part != "" else { throw TexDiffConverterError.badLine("empty part, line=\(line)") }
            p += part
            if p.countInstances(of: "(") == p.countInstances(of: ")") {
                items.append(p)
                p = ""
            } else {
                p += ","
            }
        }
        guard p == "" else { throw TexDiffConverterError.badLine("non empty last, line=\(line)") }
        guard items.count == (isNoZero ? 9 : 7) else { throw TexDiffConverterError.badLine("wrong parts count, line=\(line)") }
        guard items[1] == "j" else { throw TexDiffConverterError.badLine("wrong items[1]=\(items[1]), line=\(line)") }
        var part1 = koefStr(from: items[isNoZero ? 8 : 6])
        if items[2] == items[3] {
            part1 += " e_{\(items[2])}"
        } else {
            part1 += " w_{\(items[2])\\rightarrow \(items[3])}"
        }
        part1 += "\\otimes"
        let secondShift = isNoZero ? 1 : 0
        if items[4+secondShift] == items[5+secondShift] {
            part1 += " e_{\(items[4+secondShift])},"
        } else {
            part1 += " w_{\(items[4+secondShift])\\rightarrow \(items[5+secondShift])},"
        }
        let part2 = "\\quad i=\(items[0])\(suffix);\\\\\n"
        if part1.count + part2.count > 130 {
            return part1 + "\\\\\n\\quad\\quad" + part2
        } else {
            return part1 + part2
        }
    }

    private static func koefStr(from part: String) -> String {
        switch part {
        case "1": return ""
        case "-1": return "-"
        case "minusDeg(j_1)": return "(-1)^{j_1}"
        case "minusDeg(j_1+1)": return "(-1)^{j_1+1}"
        default: return "(" + part + ")"
        }
    }
}

extension String {
    func countInstances(of stringToFind: String) -> Int {
        var stringToSearch = self
        var count = 0
        while let foundRange = stringToSearch.range(of: stringToFind, options: .diacriticInsensitive) {
            stringToSearch = stringToSearch.replacingCharacters(in: foundRange, with: "")
            count += 1
        }
        return count
    }
}


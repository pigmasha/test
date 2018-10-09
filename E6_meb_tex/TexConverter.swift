//
//  Created by M on 30.09.2018.
//

import Foundation

enum TexConverterError: Swift.Error {
    case badSuffix(String)
    case badPartsCount(String)
    case noMatrixSize(String)
    case startClearFailed(String)
    case guardWithoutReturn(String)
    case guardUnknownS(String)
    case replaceMyModFailed(String)
    case replaceKij(String)
    case replaceFor(String)
    case processAddElem(String)
    case onePerBlockJ(String)
    case finalClearFailed(String)
}

final class TexConverter {
    let type: Int
    private var nPart = 0
    private var koefPrefix = ""
    private var matrixWidth = ""
    private var forInterval: (from: String, to: String)?

    init(type: Int) {
        self.type = type
    }

    func convert(source: String) throws -> String {
        var result = ""
        result += "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
        result += "%                                          \(type)\n"
        result += "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
        result += "\\begin{pr}[Translates for the case \(type)]\n"
        result += "$({\\rm I})$ Let $r_0\\in\\N$, $r_0<11$. $r_0$-translates of the\n"
        result += "elements $Y^{(\(type))}_t$ are described by the following way.\n\n"

        let mutableSource = NSMutableString(string: source)
        mutableSource.replaceOccurrences(of: "*", with: "", range: mutableSource.wholeRange)
        if mutableSource.hasSuffix("}\n") {
            mutableSource.deleteCharacters(in: mutableSource.rangeFrom(-2))
        } else {
            throw TexConverterError.badSuffix("type=\(type), text=\(source)")
        }
        var parts = mutableSource.components(separatedBy: "override func shift")
        if parts.count < 5 {
            parts = mutableSource.components(separatedBy: "override func oddShift")
        }
        guard parts.count == 12 else { throw TexConverterError.badPartsCount("type=\(type), \(parts.count) parts") }

        nPart = 0
        koefPrefix = mutableSource.contains("oddKoef0") ? "\\kappa_0" : ""
        for i in 1 ... 11 {
            result += try convertShift(source: parts[i], shift: i - 1)
        }
        let koefSuffix = mutableSource.contains("koef11") ? ",\nand coefficients multiplied by $(-1)^{\\ell_0}$" : ""
        result += "\\medskip\n"
        result += "$({\\rm II})$ Represent an arbitrary $t_0\\in\\N$ in the form\n"
        result += "$t_0=11\\ell_0+r_0$, where $0\\le r_0\\le 10.$ Then\n"
        result += "$\\Omega^{t_0}(Y_t^{(\(type))})$ is a $\\Omega^{r_0}(Y_t^{(\(type))})$, whose left\n"
        result += "components twisted by $\\sigma^{\\ell_0}$\(koefSuffix).\n"
        result += "\\end{pr}\n\n"
        return result
    }

    private func convertShift(source: String, shift: Int) throws -> String {
        guard let sizes = source.scanFirst(regexp: "makeZeroMatrix\\(([0-9]s), h:.?([0-9]s)\\)") else {
            throw TexConverterError.noMatrixSize("type=\(type) shift=\(shift), text=\(source)")
        }
        matrixWidth = sizes[0]
        let sizeStr = "$(\(sizes[0])\\times \(sizes[1]))$"

        let mutableSource = NSMutableString(string: source)
        guard startClear(mutableSource) else {
            throw TexConverterError.startClearFailed("type=\(type) shift=\(shift), text=\(mutableSource)")
        }
        var result = ""
        var sStr = ""
        while true {
            let guardRange = mutableSource.range(of: "guards")
            if guardRange.location == NSNotFound { break }
            let guardLast = mutableSource.range(of: "return}")
            if guardLast.location == NSNotFound {
                throw TexConverterError.guardWithoutReturn("type=\(type) shift=\(shift), text=\(mutableSource)")
            }
            if mutableSource.substring(with: NSRange(from: guardRange.upperBound, len: 7)) == ">1else{" {
                let ss = mutableSource.substring(with: NSRange(from: guardRange.upperBound+7, to:guardLast.lowerBound))
                result += try convertShift(NSMutableString(string: ss), shift: shift, sizeStr: sizeStr, sStr: " and $s=1$")
                if sStr != "" { throw TexConverterError.guardUnknownS("type=\(type) shift=\(shift), text=\(mutableSource)") }
                sStr = " and $s>1$"
            } else if mutableSource.substring(with: NSRange(from: guardRange.upperBound, len: 7)) == ">2else{" {
                let ss = mutableSource.substring(with: NSRange(from: guardRange.upperBound+7, to:guardLast.lowerBound))
                result += try convertShift(NSMutableString(string: ss), shift: shift, sizeStr: sizeStr, sStr: " and $s=2$")
                if sStr != " and $s>1$" { throw TexConverterError.guardUnknownS("type=\(type) shift=\(shift), text=\(mutableSource)") }
                sStr = " and $s>2$"
            } else if mutableSource.substring(with: NSRange(from: guardRange.upperBound, len: 8)) == "!=2else{" {
                let ss = mutableSource.substring(with: NSRange(from: guardRange.upperBound+8, to:guardLast.lowerBound))
                result += try convertShift(NSMutableString(string: ss), shift: shift, sizeStr: sizeStr, sStr: " and $s=2$")
                if sStr != "" { throw TexConverterError.guardUnknownS("type=\(type) shift=\(shift), text=\(mutableSource)") }
                sStr = " and $s\\ne 2$"
            } else {
                throw TexConverterError.guardUnknownS("type=\(type) shift=\(shift), text=\(mutableSource)")
            }
            mutableSource.deleteCharacters(in: NSRange(from: guardRange.lowerBound, to: guardLast.upperBound))
        }
        result += try convertShift(mutableSource, shift: shift, sizeStr: sizeStr, sStr: sStr)
        return result
    }

    //$$b_{3s+z_0(0,\ell_0,n),3s+z_0(0,\ell_0,n)}=w_{(j+m)n+g(j+s)+1\ra (j+m+1)n+g(j+s)+1}\otimes e_{jn+g(j+s)+1}.$$
    private func convertShift(_ mutableSource: NSMutableString, shift: Int, sizeStr: String, sStr: String) throws -> String {
        let isOnePerBlock = mutableSource.range(of: "forjin").location == NSNotFound

        nPart += 1
        var result = "$(\(nPart))$ If $r_0=\(shift)$\(sStr), then $\\Omega^{\(shift)}(Y_t^{(\(type))})$ is described with\n"
        var nElems = 0
        if isOnePerBlock {
            nElems = mutableSource.components(separatedBy: "addElemToHH").count - 1
            if nElems == 1 {
                result += "\(sizeStr)-matrix with one nonzero element that is of the following form{\\rm:}\n"
            } else if nElems == 2 {
                result += "\(sizeStr)-matrix with the following two nonzero elements{\\rm:}\n"
            } else {
                result += "\(sizeStr)-matrix with the following nonzero elements{\\rm:}\n"
            }
        } else {
            result += "\(sizeStr)-matrix with the following elements $b_{ij}${\\rm:}\n\n"
        }

        guard replaceMyModS(mutableSource) else { // myModS(j+1) → (j+1)_s
            throw TexConverterError.replaceMyModFailed("type=\(type) shift=\(shift), text=\(mutableSource)")
        }
        guard replaceKij(mutableSource) else { //PathAlg.k1J(ell, j:j, m:m) → \kappa^\ell(\a_{3(j+m)})
            throw TexConverterError.replaceKij("type=\(type) shift=\(shift), text=\(mutableSource)")
        }
        guard replaceFor(mutableSource) else { // for j in 0..<s → If $0\le j<s$, then $$b_{ij}=
            throw TexConverterError.replaceFor("type=\(type) shift=\(shift), text=\(mutableSource)")
        }
        if isOnePerBlock {
            guard processBodyAddElem(mutableSource, inFor: false, nElems: nElems) else {
                throw TexConverterError.processAddElem("type=\(type) shift=\(shift), text=\(mutableSource)")
            }
            guard onePerBlockJ(mutableSource) else {
                throw TexConverterError.onePerBlockJ("type=\(type) shift=\(shift), text=\(mutableSource)")
            }
        }
        guard finalClear(mutableSource) else {
            throw TexConverterError.finalClearFailed("type=\(type) shift=\(shift), text=\(mutableSource)")
        }
        return result + (mutableSource as String) + "\n"
    }

    // myModS(j+1) → (j+1)_s
    private func replaceMyModS(_ source: NSMutableString) -> Bool {
        let regex1 = try! NSRegularExpression(pattern: "myModS\\((.*?)\\)")
        regex1.replaceMatches(in: source, range: source.wholeRange, withTemplate: "z$1Z_s")
        let regex2 = try! NSRegularExpression(pattern: "myMod2S\\((.*?)\\)")
        regex2.replaceMatches(in: source, range: source.wholeRange, withTemplate: "z$1Z_{2s}")
        return source.range(of: "myMod").location == NSNotFound
    }

    //PathAlg.k1J(ell, j:j, m:m) → \kappa^\ell(\a_{3(j+m)})
    private func replaceKij(_ source: NSMutableString) -> Bool {
        let regex1 = try! NSRegularExpression(pattern: "PathAlg.k1J\\(ell\\,j\\:(.*?)\\,m\\:(.*?)\\)")
        regex1.replaceMatches(in: source, range: source.wholeRange, withTemplate: "\\\\kappa^\\\\ellz\\\\a_{3z$1+$2Z}Z")
        let regex2 = try! NSRegularExpression(pattern: "PathAlg.k1JPlus1\\(ell\\,j\\:(.*?)\\,m\\:(.*?)\\)")
        regex2.replaceMatches(in: source, range: source.wholeRange, withTemplate: "\\\\kappa^\\\\ellz\\\\a_{3z$1+$2+1Z}Z")
        let regex3 = try! NSRegularExpression(pattern: "PathAlg.k1JPlus2\\(ell\\,j\\:(.*?)\\,m\\:(.*?)\\)")
        regex3.replaceMatches(in: source, range: source.wholeRange, withTemplate: "\\\\kappa^\\\\ellz\\\\a_{3z$1+$2+2Z}Z")
        let regex4 = try! NSRegularExpression(pattern: "PathAlg.kGamma\\(ell\\,j\\:(.*?)\\,m\\:(.*?)\\)")
        regex4.replaceMatches(in: source, range: source.wholeRange, withTemplate: "\\\\kappa^\\\\ellz\\\\g_{$1+$2}Z")
        let regex5 = try! NSRegularExpression(pattern: "PathAlg.k1J\\(ell\\+1\\,j\\:(.*?)\\,m\\:(.*?)\\)")
        regex5.replaceMatches(in: source, range: source.wholeRange, withTemplate: "\\\\kappa^{\\\\ell+1}z\\\\a_{3z$1+$2Z}Z")
        let regex6 = try! NSRegularExpression(pattern: "PathAlg.kGamma\\(ell\\+1\\,j\\:(.*?)\\,m\\:(.*?)\\)")
        regex6.replaceMatches(in: source, range: source.wholeRange, withTemplate: "\\\\kappa^{\\\\ell+1}z\\\\g_{$1+$2}Z")
        return source.range(of: "PathAlg.k").location == NSNotFound
    }

    // for j in 0..<s → If $0\le j<s$, then $$b_{ij}=
    private func replaceFor(_ source: NSMutableString) -> Bool {
        forInterval = nil
        var body = NSMutableString()
        while true {
            guard let range = forRange(source) else { break }
            body = NSMutableString(string: source.substring(with: range))
            guard processForBodyInterval(body) else { return false }
            guard processBodyAddElem(body, inFor: true) else { return false }
            source.replaceCharacters(in: range, with: body as String)
        }
        if let forInterval = forInterval, forInterval.to != matrixWidth {
            source.replaceOccurrences(of: body as String,
                                      with: "\(body)If $\(forInterval.to)\\le j<\(matrixWidth)$, then $b_{ij}=0$.\n",
                range: source.wholeRange)
        }
        return source.range(of: "forjin").location == NSNotFound
    }

    // for j in 0..<s → If $0\le j<s$, then $$b_{ij}=\begin{cases} ... \end{cases}
    private func processForBodyInterval(_ body: NSMutableString) -> Bool {
        if body.substring(with: NSRange(location: 0, length: 6)) != "forjin" { return false }
        body.deleteCharacters(in: NSRange(location: 0, length: 6))
        if body.range(of: "for").location != NSNotFound { return false }
        let openBraceRange = body.range(of: "{")
        let intervalRange = body.range(of: "..<")
        if openBraceRange.location == NSNotFound || intervalRange.location == NSNotFound ||
            intervalRange.location > openBraceRange.location { return false }
        let fromStr = body.substring(with: NSRange(to: intervalRange.lowerBound))
        let toStr = body.substring(with: NSRange(from: intervalRange.upperBound, to: openBraceRange.lowerBound))
        let prefix: String
        if let forInterval = forInterval, forInterval.to != fromStr {
            prefix = "If $\(forInterval.to)\\le j<\(fromStr)$, then $b_{ij}=0$.\n\n"
        } else {
            prefix = ""
        }
        forInterval = (from: fromStr, to: toStr)
        body.replaceCharacters(in: NSRange(to: openBraceRange.upperBound),
                               with: "\(prefix)If $\(fromStr)\\le j<\(toStr)$, then $$b_{ij}=\n\\begin{cases}\n")
        guard body.hasSuffix("}") else { return false }
        let kRange = body.range(of: "letk1=")
        if kRange.location != NSNotFound {
            let kEndRange = body.range(of: "HHElem.addElemToHH", range: body.rangeFrom(kRange))
            if kEndRange.location == NSNotFound { return false }
            body.replaceCharacters(in: body.rangeFrom(-1), with: "0,\\quad\\text{otherwise,}\n\\end{cases}$$\nwhere "
                + "$\\kappa_1=\(body.substring(with: NSRange(from: kRange.upperBound, to: kEndRange.lowerBound)))$.\n\n")
            body.deleteCharacters(in: NSRange(from: kRange.lowerBound, to: kEndRange.lowerBound))
        } else {
            body.replaceCharacters(in: body.rangeFrom(-1), with: "0,\\quad\\text{otherwise.}\n\\end{cases}$$\n\n")
        }
        return true
    }

    // HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j, right:4*j, koef:PathAlg.k1J(ell, j:j, m:m)) →
    // -w_{(j+m)n\ra (j+m)n+g(j+s)}\otimes e_{jn},\quad i=j;\\
    // $$b_{3s+z_0(0,\ell_0,n),3s+z_0(0,\ell_0,n)}=w_{(j+m)n+g(j+s)+1\ra (j+m+1)n+g(j+s)+1}\otimes e_{jn+g(j+s)+1}.$$
    private func processBodyAddElem(_ source: NSMutableString, inFor: Bool, nElems: Int = 0) -> Bool {
        if inFor == false && nElems == 0 { return false }
        source.replaceOccurrences(of: ",noZeroLenL:true", with: "", range: source.wholeRange)
        source.replaceOccurrences(of: ",noZeroLenR:true", with: "", range: source.wholeRange)
        let kappas: String
        if !inFor {
            guard let kk = processKappas(source) else { return false }
            kappas = kk
        } else {
            kappas = ""
        }
        let regex1 = try! NSRegularExpression(pattern: "^HHElem\\.addElemToHH\\(hhElem\\,i\\:(.*?)\\,j\\:j\\,"
            + "leftFrom\\:(.*?)\\,leftTo\\:(.*?)\\,right\\:(.*?)\\,koef\\:(.*?)$")
        let regex2 = try! NSRegularExpression(pattern: "^HHElem\\.addElemToHH\\(hhElem\\,i\\:(.*?)\\,j\\:j\\,"
            + "leftFrom\\:(.*?)\\,leftTo\\:(.*?)\\,rightFrom\\:(.*?)\\,rightTo\\:(.*?)\\,koef\\:(.*?)$")
        var n = 0
        while true {
            guard let range = addElemRange(source) else { break }
            let contents = source.substring(with: NSRange(from: range.lowerBound, to: range.upperBound - 1)) as NSString
            let match1 = regex1.firstMatch(in: contents as String, range: contents.wholeRange)
            let match2 = regex2.firstMatch(in: contents as String, range: contents.wholeRange)
            guard let match = match1 ?? match2 else {
                return false
            }
            let hasRightTo = match1 == nil
            var sK = contents.substring(with: match.range(at: hasRightTo ? 6 : 5))
            if sK.range(of: "noZe") != nil { return false }
            if sK == "-1" { sK = "-" }
            if sK == "1" { sK = "" }
            sK = sK.replacingOccurrences(of: "k1", with: "\\kappa_1")
            sK = sK.replacingOccurrences(of: "k2", with: "\\kappa_2")
            sK = sK.replacingOccurrences(of: "k3", with: "\\kappa_3")
            let sL1 = contents.substring(with: match.range(at: 2))
            let sL2 = contents.substring(with: match.range(at: 3))
            let sL = sL1 != sL2 ? "w_{\(sL1)\\ra \(sL2)}" : "e_{\(sL1)}"
            let sR1 = contents.substring(with: match.range(at: 4))
            let sR2 = hasRightTo ? contents.substring(with: match.range(at: 5)) : sR1
            let sR = sR1 != sR2 ? "w_{\(sR1)\\ra \(sR2)}" : "e_{\(sR1)}"
            var sJ = contents.substring(with: match.range(at: 1))
            if sJ.hasPrefix("+") { sJ.removeFirst() }
            if inFor {
                source.replaceCharacters(in: range, with: "\(sK)\(sL)\\otimes \(sR),\\quad i=\(sJ);\\\\\n")
            } else {
                n += 1
                sK += koefPrefix
                var sfx = n == nElems ? ".$$\n" : ";$$\n"
                if n == nElems && kappas != "" {
                    sfx = ",$$\nwhere \(kappas).\n"
                }
                source.replaceCharacters(in: range, with: "$$b_{\(sJ),j}=\(sK)\(sL)\\otimes \(sR)\(sfx)")
            }
        }
        return source.range(of: "addElemToHH").location == NSNotFound
    }

    private func processKappas(_ source: NSMutableString) -> String? {
        var kappas = ""
        for i in 1 ... 3 {
            let kRange = source.range(of: "letk\(i)=")
            guard kRange.location != NSNotFound else { break }
            let kEndRange = source.range(of: "HHElem.addElemToHH", range: source.rangeFrom(kRange))
            guard kEndRange.location != NSNotFound else { return nil }
            if i > 1 { kappas += ", " }
            kappas += "$\\kappa_\(i)=\(source.substring(with: NSRange(from: kRange.upperBound, to: kEndRange.lowerBound)))$"
            source.deleteCharacters(in: NSRange(from: kRange.lowerBound, to: kEndRange.lowerBound))
        }
        return kappas
    }

    private func onePerBlockJ(_ source: NSMutableString) -> Bool {
        guard source.hasPrefix("let") || source.hasPrefix("var") else { return false }
        source.deleteCharacters(in: NSRange(to: 3))
        var jS = ""
        while true {
            let r1 = source.range(of: "j=")
            let r3 = source.range(of: ",j}=")
            if r3.location == NSNotFound { break }
            //let r4 = source.range(of: "j", options: .backwards, range: source.rangeTo(r3.lowerBound))
            if r1.location == NSNotFound || r3.location < r1.location {
                guard jS != "" else { break }
                source.replaceCharacters(in: NSRange(from: r3.lowerBound + 1, len: 1), with: jS)
                /*if r4.location != NSNotFound &&
                    !source.substring(with: NSRange(from: r4.lowerBound, to: r3.lowerBound)).contains("{") {
                    source.replaceCharacters(in: r4, with: jS)
                }*/
                continue
            }
            if r1.location == NSNotFound { break }
            let r2 = source.range(of: "$$b_", range: source.rangeFrom(r1))
            if r2.location == NSNotFound || r2.location < r1.location || r3.location < r2.location { break }
            jS = source.substring(with: NSRange(from: r1.upperBound, to: r2.lowerBound))
            source.replaceCharacters(in: NSRange(from: r3.lowerBound + 1, len: 1), with: jS)
            /*if r4.location != NSNotFound && r4.location > r2.location {
                source.replaceCharacters(in: r4, with: jS)
            }*/
            source.deleteCharacters(in: NSRange(from: r1.lowerBound, to: r2.lowerBound))
        }
        return source.range(of: "j=").location == NSNotFound && source.range(of: ",j}=").location == NSNotFound
    }

    private func startClear(_ source: NSMutableString) -> Bool {
        let closeHeaderPos = source.range(of: ")", range: source.rangeFrom(source.range(of: "makeZeroMatrix(")))
        source.deleteCharacters(in: NSRange(to: closeHeaderPos.upperBound))
        source.replaceOccurrences(of: " ", with: "", range: source.wholeRange)
        source.replaceOccurrences(of: "\n", with: "", range: source.wholeRange)
        guard source.hasSuffix("}") else { return false }
        source.deleteCharacters(in: source.rangeFrom(-1))
        return true
    }

    private func finalClear(_ source: NSMutableString) -> Bool {
        source.replaceOccurrences(of: "z", with: "(", range: source.wholeRange)
        source.replaceOccurrences(of: "Z", with: ")", range: source.wholeRange)
        source.replaceOccurrences(of: "j%s", with: "(j)_s", range: source.wholeRange)
        source.replaceOccurrences(of: "f0(", with: "f_0(", range: source.wholeRange)
        source.replaceOccurrences(of: "f1(", with: "f_1(", range: source.wholeRange)
        source.replaceOccurrences(of: "f2(", with: "f_2(", range: source.wholeRange)
        source.replaceOccurrences(of: "}overridefunckoef11", with: "\n%koef11", range: source.wholeRange)
        source.replaceOccurrences(of: "}overridefuncoddKoef_0", with: "\n%oddKoef0", range: source.wholeRange)
        return source.range(of: "addElemToHH").location == NSNotFound
    }
}

extension TexConverter {
    // forjin{ ... }
    private func forRange(_ source: NSString) -> NSRange? {
        let startR = source.range(of: "forjin")
        guard startR.location != NSNotFound else { return nil }
        var nBraces = 0
        var pos = source.range(of: "{", range: source.rangeFrom(startR)).upperBound
        while true {
            let openBrace = source.range(of: "{", range: source.rangeFrom(pos))
            let closeBrace = source.range(of: "}", range: source.rangeFrom(pos))
            if closeBrace.location == NSNotFound { return nil }
            if openBrace.location != NSNotFound && openBrace.location < closeBrace.location {
                nBraces += 1
                pos = openBrace.upperBound
            } else {
                if nBraces == 0 {
                    return NSRange(location: startR.location, length: closeBrace.upperBound - startR.location)
                } else {
                    nBraces -= 1
                    pos = closeBrace.upperBound
                }
            }
        }
    }
    // addElemToHH( ... )
    private func addElemRange(_ source: NSString) -> NSRange? {
        let startR = source.range(of: "HHElem.addElemToHH")
        guard startR.location != NSNotFound else { return nil }
        var nBraces = 0
        var pos = source.range(of: "(", range: source.rangeFrom(startR)).upperBound
        while true {
            let openBrace = source.range(of: "(", range: source.rangeFrom(pos))
            let closeBrace = source.range(of: ")", range: source.rangeFrom(pos))
            if closeBrace.location == NSNotFound { return nil }
            if openBrace.location != NSNotFound && openBrace.location < closeBrace.location {
                nBraces += 1
                pos = openBrace.upperBound
            } else {
                if nBraces == 0 {
                    return NSRange(location: startR.location, length: closeBrace.upperBound - startR.location)
                } else {
                    nBraces -= 1
                    pos = closeBrace.upperBound
                }
            }
        }
    }
}

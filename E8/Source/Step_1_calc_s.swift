//
//  Created by M on 26/10/2018.
//

import Foundation

struct Step_1_calc_s {
    static var Qs: [CalcBimodQ] = []
    static var QHomos: [[PHomo]] = []

    static let printHomos = true

    static func runCase() -> Bool {
        Qs = []
        QHomos = []
        OutputFile.writeLog(.simple, header)
        OutputFile.writeLog(.simple, "N=\(PathAlg.n), S=\(PathAlg.s)\n\n")
        var res = false
        for i in 0 ... PathAlg.n-1 {
            let jMax = printHomos ? 1 : PathAlg.s
            for j in 0 ..< jMax {
                if processS(i+PathAlg.n*j) { res = true; break }
            }
            if res { break }
        }
        if !printHomos {
            for d in 0 ..< Qs.count {
                let myQ = BimodQ(deg: d)
                if !checkSameQ(Qs[d].pij, myQ.ppp, myQ.sizes) {
                    OutputFile.writeLog(.simple, "ERROR deg=\(d)!\n")
                    printQ(Qs[d].pij, deg: d)
                    OutputFile.writeLog(.simple, "My\n")
                    printQ(myQ.ppp, deg: d)
                    res = true
                    break
                }
                if d > 28 { continue }
                let myK = BimodKoefs(deg: d)
                let s = PathAlg.s
                if QHomos[d].count != 8 * s {
                    OutputFile.writeLog(.simple, "ERROR Bad count=\(QHomos[d].count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][0].matrix.count != myK.koefs.0.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count0=\(QHomos[d][0].matrix.count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][s].matrix.count != myK.koefs.1.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count1=\(QHomos[d][s].matrix.count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][2*s].matrix.count != myK.koefs.2.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count2=\(QHomos[d][2*s].matrix.count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][3*s].matrix.count != myK.koefs.3.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count3=\(QHomos[d][3*s].matrix.count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][4*s].matrix.count != myK.koefs.4.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count4=\(QHomos[d][4*s].matrix.count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][5*s].matrix.count != myK.koefs.5.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count5=\(QHomos[d][5*s].matrix.count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][6*s].matrix.count != myK.koefs.6.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count6=\(QHomos[d][6*s].matrix.count)! deg=\(d)\n")
                    return true
                }
                if QHomos[d][7*s].matrix.count != myK.koefs.7.count {
                    OutputFile.writeLog(.simple, "ERROR Bad count7=\(QHomos[d][7*s].matrix.count)! deg=\(d)\n")
                    return true
                }
            }
        }
        /*if printHomos {
            for i in 0 ..< QHomos.count {
                OutputFile.writeLog(.simple, "    private static var koefs\(i): ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {\n")
                let matrixStr = QHomos[i].map { homos in
                    "[" + homos.matrix.map { row in "[" + row.map { "\($0.koef)" }.joined(separator: ",") + "]" }.joined(separator: ",") + "]"
                }.joined(separator: ", ")
                OutputFile.writeLog(.simple, "        return (\(matrixStr))\n")
                OutputFile.writeLog(.simple, "    }\n\n")
            }
        }*/
        OutputFile.writeLog(.simple, "\\end{document}\n")
        return res
    }

    private static func processS(_ i: Int) -> Bool {
        let n = PathAlg.n
        if printHomos {  OutputFile.writeLog(.simple, "\\begin{center}{\\large $\\mathbf{S_{\(kStr(i, m: nil))}}$}\\end{center}\n\n") }
        let w = maxLenWay(end: i)
        var homos: [PHomo] = []
        var lastHomo = PHomo(from: [w.endsWith.number], to: [w.startsWith.number], matrix: [[WayKoef(koef: 1, way: w)]])
        if QHomos.count < 1 {
            QHomos += [[lastHomo]]
        } else {
            QHomos[0] = QHomos[0] + [lastHomo]
        }
        homos.append(lastHomo)
        for d in 0 ... 32 {
            print("\(Date()): d=\(d) - \(i % n)")
            if Qs.count < d + 1 { Qs += [CalcBimodQ()] }
            Qs[d].sizes += [lastHomo.from.count]
            Qs[d].pij += lastHomo.from.map { ($0, i) }
            let myKer = PKer.ker(lastHomo, onlyGen: true)
            //myKer.printTex()
            if myKer.items.count < 1 || myKer.items.count > 5 {
                OutputFile.writeLog(.simple, "bad ker count \(myKer.items.count); d=\(d)")
                myKer.printTex()
                return true
            }
            var matrix: [[WayKoef]] = []
            for i in 0 ..< myKer.items[0].count { matrix += [myKer.items.map { $0[i] }] }

            let homo = PHomo(from: myKer.items.map { $0.first{ !$0.isZero }!.way.endsWith.number },
                             to: lastHomo.from,
                             matrix: matrix)
            //if checkLast(homo, deg: d, i: i) { break }
            if checkExact(lastHomo, homo, ker: myKer) { return true }
            lastHomo = homo
            homos.append(lastHomo)
            if QHomos.count < d + 2 {
                QHomos += [[lastHomo]]
            } else {
                QHomos[d + 1] = QHomos[d + 1] + [lastHomo]
            }
            if printHomos { printHomo(lastHomo, deg: d) }
        }
        /*if printHomos {
            for d in 0 ..< homos.count { printHomo(homos[d], deg: d) }
            let start = i == 0 || i == 1 || i == 5 || i == 7 ? 1 : 23
            if (start == 1 && i > 0) { OutputFile.writeLog(.simple, "\\newpage\n") }
            for d in start ..< homos.count { if d == 1 || d % 2 == 0 { printHomo(homos[d], deg: d - 1) } }
            OutputFile.writeLog(.simple, "\\begin{center}{\\large $\\mathbf{S_{\(kStr(i, m: nil))}}$}\\end{center}\n\n")
            for d in start ..< homos.count { if d % 2 == 1 { printHomo(homos[d], deg: d - 1) } }
        }*/
        /*for i in 1 ..< homos.count {
            if checkExact(homos[i-1], homos[i]) { return true }
        }*/
        return false
    }

    //     h_2      h_1
    // Q_3 ---→ Q_2 ---→ Q_1
    private static func checkExact(_ homo1: PHomo, _ homo2: PHomo, ker: PElements) -> Bool {
        let im = PKer.im(homo2)
        var imErr = false
        for k in ker.items {
            if !im.contains(k) {
                OutputFile.writeLog(.simple, "$$\\text{No: }" +  k.str + "\\text{ in im}$$\n")
                imErr = true
            }
        }
        if imErr {
            im.printTex()
        }

        guard homo2.matrix.count == homo1.matrix[0].count else {
            fatalError("bad counts \(homo2.matrix.count) and \(homo1.matrix[0].count)")
        }

        var multErr = false
        for i in 0 ..< homo2.matrix[0].count {
            for j in 0 ..< homo1.matrix.count {
                var item = WayKoef.zero
                for k in 0 ..< homo2.matrix.count {
                    if homo2.matrix[k][i].isZero || homo1.matrix[j][k].isZero { continue }
                    let ww = homo1.matrix[j][k].compLeft(homo2.matrix[k][i].way)
                    if ww.isZero { continue }
                    item = WayKoef(koefs: item.koefs + [ww.koef * homo2.matrix[k][i].koef], ways: item.ways + [ww.way])
                }
                if !item.isZero { multErr = true }
            }
        }
        
        return imErr || multErr
    }

    private static func checkLast(_ homo: PHomo, deg: Int, i: Int) -> Bool {
        guard homo.from.count == 1 && homo.to.count == 1 else { return false }
        let w = maxLenWay(end: homo.from[0])
        guard w.isEq(homo.matrix[0][0].way) else { return false }
        OutputFile.writeLog(.simple, "$$\\Omega^{\(deg+1)}(S_{\(kStr(i, m: nil))})\\simeq S_{\(kStr(homo.from[0], m: nil))}$$\n")
        return true
    }

    private static func printHomo(_ homo: PHomo, deg: Int) {
        let matrixStr: String
        if homo.from.count == 1 && homo.to.count == 1 {
            matrixStr = homo.matrix[0][0].printStr
        } else if homo.from.count == 2 && homo.to.count == 1 {
            matrixStr = "(\(homo.matrix[0][0].printStr)\\text{ }\(homo.matrix[0][1].printStr))"
        } else if homo.from.count == 1 && homo.to.count == 2 {
            matrixStr = "\\binom{\(homo.matrix[0][0].printStr)}{\(homo.matrix[1][0].printStr)}"
        } else if homo.from.count == 1 && homo.to.count == 3 {
            matrixStr = "\\triplet{\(homo.matrix[0][0].printStr)}{\(homo.matrix[1][0].printStr)}{\(homo.matrix[2][0].printStr)}"
        } else if homo.from.count == 2 && homo.to.count == 2 {
            matrixStr = "\\binom{\\phantom{-}\(homo.matrix[0][0].printStr)\\phantom{-}"
                + "\(homo.matrix[0][1].printStr)}{\(homo.matrix[1][0].printStr)\\phantom{-}\(homo.matrix[1][1].printStr)}"
        } else if homo.from.count == 2 && homo.to.count == 3 {
            matrixStr = "\\triplet{\\phantom{-}\(homo.matrix[0][0].printStr)\\phantom{-}"
                + "\(homo.matrix[0][1].printStr)}{\(homo.matrix[1][0].printStr)\\phantom{-}\(homo.matrix[1][1].printStr)}"
                + "{\(homo.matrix[2][0].printStr)\\phantom{-}\(homo.matrix[2][1].printStr)}"
        } else if homo.to.count == 2 {
            let line1 = homo.matrix[0].map { $0.printStr }.joined(separator: "\\phantom{-}")
            var line2 = ""
            for i in 0 ..< homo.matrix[1].count {
                if homo.matrix[0][i].printStr.lengthOfBytes(using: .utf8) > homo.matrix[1][i].printStr.lengthOfBytes(using: .utf8) + 1 {
                    line2 += "\\phantom{-}"
                }
                if i > 0 { line2 += "\\phantom{-}" }
                line2 += homo.matrix[1][i].printStr
            }
            matrixStr = "\\binom{\(line1)}{\(line2)}"
        } else if homo.to.count == 3 {
            let line1 = homo.matrix[0].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line2 = homo.matrix[1].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line3 = homo.matrix[2].map { $0.printStr }.joined(separator: "\\phantom{-}")
            matrixStr = "\\triplet{\(line1)}{\(line2)}{\(line3)}"
        } else if homo.to.count == 4 {
            let line1 = homo.matrix[0].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line2 = homo.matrix[1].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line3 = homo.matrix[2].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line4 = homo.matrix[3].map { $0.printStr }.joined(separator: "\\phantom{-}")
            matrixStr = "\\quatro{\(line1)}{\(line2)}{\(line3)}{\(line4)}"
        } else if homo.from.count == 3 && homo.to.count == 5 {
            let line1 = homo.matrix[0].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line2 = homo.matrix[1].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line3 = homo.matrix[2].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line4 = homo.matrix[3].map { $0.printStr }.joined(separator: "\\phantom{-}")
            let line5 = homo.matrix[4].map { $0.printStr }.joined(separator: "\\phantom{-}")
            matrixStr = "\\quintet{\(line1)}{\(line2)}{\(line3)}{\(line4)}{\(line5)}"
        } else {
            fatalError("Bad counts \(homo.from.count) and \(homo.to.count)")
        }
        let sStr = deg == 0 ? "\\longrightarrow S_{\(kStr(homo.to[0], m: nil))}" : ""
        OutputFile.writeLog(.simple, "$$d_{\(deg)}: Q_{\(deg+1)}=\(pStr(homo.from, m: (deg + 1) / 2))"
            + "\\stackrel{\(matrixStr)}\\longrightarrow \(pStr(homo.to, m: deg / 2))\(sStr)$$\n")
    }

    private static func printQ(_ q: [(Int, Int)], deg: Int) {
        var str = ""
        var lastR = 0
        for i in 0 ..< q.count {
            if i > 0 {
                let r = q[i].1 % PathAlg.n
                let nlStr = i % 10 == 0 ? "\\\\\n" : ""
                str += r != lastR ? ") \(nlStr)\\oplus ( " : "\(nlStr)\\oplus "
                lastR = r
            }
            str += "P_{\(q[i].0),\(q[i].1)}"
        }
        OutputFile.writeLog(.simple, "\\begin{multline*}Q_{\(deg)}=(\(str))\\end{multline*}\n")
    }

    private static func checkSameQ(_ q1: [(Int, Int)], _ q2: [(Int, Int)], _ sizes: [Int]) -> Bool {
        guard q1.count == q2.count else { return false }
        let s = PathAlg.s
        var qPos = 0
        var sizeIndex = 0
        for size in sizes {
            for x in 0 ..< size {
                for i in 0 ..< 1 {
                    let errorMessage: String?
                    if q1[qPos+i*size+x].0 != q2[qPos+i+s*x].0 {
                        errorMessage = "0: \(q1[qPos+i*size+x].0) != \(q2[qPos+i+s*x].0)"
                    } else if q1[qPos+i*size+x].1 != q2[qPos+i+s*x].1 {
                        errorMessage = "1: \(q1[qPos+i*size+x].1) != \(q2[qPos+i+s*x].1)"
                    } else {
                        errorMessage = nil
                    }
                    if let errorMessage = errorMessage {
                        OutputFile.writeLog(.simple, "x=\(x), sizeIndex=\(sizeIndex), sizes \(sizes), qPos=\(qPos), "
                            + " Q: \(q1[qPos+i*size+x]) and \(q2[qPos+i+s*x]) \(errorMessage)\n\n")
                        return false
                    }
                }
            }
            qPos += s * size
            sizeIndex += 1
        }
        let sq1 = q1.sorted { $0.1 == $1.1 ? $0.0 > $1.0 : $0.1 > $1.1 }
        let sq2 = q2.sorted { $0.1 == $1.1 ? $0.0 > $1.0 : $0.1 > $1.1 }
        for i in 0 ..< sq1.count {
            if sq1[i].0 != sq2[i].0 || sq1[i].1 != sq2[i].1 { return false }
        }
        return true
    }

    private static func maxLenWay(end: Int) -> Way {
        var way = Way(from: end, to: end, noZeroLen: true)
        if way.isZero { way = Way(from: end, to: end) }
        var cnt = 1
        for i in 0 ... PathAlg.vertexMod {
            let w = Way(from: i, to: end)
            if !w.isZero && w.len > way.len { way = w; cnt = 1 }
            if !w.isZero && w.len == way.len && !w.isEq(way) { cnt += 1 }
        }
        if cnt != 1 || way.len == 0 { fatalError("Search way error: \(cnt) different ways \(way.htmlStr)") }
        return way
    }

    private static func pStr(_ p: [Int], m: Int) -> String {
        return p.map { "P_{\(kStr($0, m: m))}" }.joined(separator: "\\oplus ")
    }

    private static func kStr(_ k: Int, m: Int?) -> String {
        let n = PathAlg.n
        if let m = m {
            let k2 = myMod(k - n * m, mod: n*PathAlg.s)
            guard k2 != 0 else { return "\(n)(r+m)" }
            guard k2 != n*PathAlg.s - 1 else { return "\(n)(r+m)-1" }
            guard k2 >= n else { return "\(n)(r+m)+\(k2)" }
            return "\(n)(r+m+\(k2/n))" + (k2 % n == 0 ? "" : "+\(k2%n)")
        } else {
            guard k != 0 else { return "\(n)r" }
            guard k >= n else { return "\(n)r+\(k)" }
            return "\(n)(r+\(k/n))" + (k % n == 0 ? "" : "+\(k%n)")
        }
    }
}

struct PHomo {
    let from: [Int]
    let to: [Int]
    let matrix: [[WayKoef]]
}

enum PElementsType {
    case ker, im
}

class CalcBimodQ {
    var pij: [(Int, Int)] = []
    var sizes: [Int] = []
}

let header = """
\\documentclass[12pt]{amsart}
\\usepackage{amsmath,amsthm,amssymb,amscd,cite,array}
\\usepackage[dvips]{graphicx}

\\oddsidemargin=-0.2in \\evensidemargin=-0.2in \\textwidth=6.8in
\\topmargin=0.0in \\textheight=9in

\\newtheorem{pr}{Proposition}
\\newtheorem{lem}[pr]{Lemma}
\\newtheorem{thm}[pr]{Theorem}
\\newtheorem{s}[pr]{Corollary}
\\theoremstyle{remark}
\\newtheorem{zam}{Remark}
\\newtheorem*{obozn}{{\\rm\\bf Denotation}}
\\newtheorem*{obozns}{{\\rm\\bf Denotations}}

\\renewcommand\\div{\\text{ }\\vdots\\text{ }}
\\newcommand\\ndiv{\\not\\vdots\\text{ }}
\\newcommand{\\myChar}{\\mathrm{char\\,}K}
\\newcommand{\\myNod}{\\text{{\\rm gcd}}}
\\newcommand{\\Hom}{\\mathrm{Hom}}
\\renewcommand{\\Im}{\\mathrm{Im}}
\\newcommand{\\Ker}{\\mathrm{Ker}}
\\newcommand{\\HH}{\\mathrm{HH}}
\\newcommand{\\N}{\\mathbb{N}}
\\newcommand{\\Z}{\\mathbb{Z}}
\\newcommand{\\cl}{\\mathrm{cl}}
\\newcommand\\two[2]{\\genfrac{}{}{0pt}{}{#1}{#2}}
\\newcommand\\three[3]{\\two{#1}{\\two{#2}{#3}}}
\\newcommand\\triplet[3]{\\left(\\three{#1}{#2}{#3}\\right)}
\\newcommand\\quatro[4]{\\left(\\two{\\two{#1}{#2}}{\\two{#3}{#4}}\\right)}
\\newcommand\\quintet[5]{\\left(\\two{\\two{#1}{#2}}{\\three{#3}{#4}{#5}}\\right)}
\\def\\sm{\\scriptstyle}
\\def\\a{\\alpha}
\\def\\b{\\beta}
\\def\\g{\\gamma}
\\def\\le{\\leqslant}
\\def\\ge{\\geqslant}
\\def\\ra{\\rightarrow}

\\begin{document}

"""

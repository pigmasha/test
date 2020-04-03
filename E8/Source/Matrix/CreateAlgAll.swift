//
//  Created by M on 02/04/2020.
//

import Foundation

struct CreateAlgAll {
    private enum GoodPosMode { case first, last, index1 }

    private static var bySVal = true

    static func kerVariants(for degree: Int, onlyOne: Bool = false) -> ShiftAllVariants? {
        let dd = Diff(deg: degree)
        let colsTenzors = self.colsTenzors(deg: degree)
        //OutputFile.writeLog(.normal, colsTenzors.enumerated().map { "\($0): \($1.t.str)" }.joined(separator: "<br>\n"))
        var items: [(Int, HHElem, Matrix)] = []
        for i in 0 ..< colsTenzors.count {
            guard colsTenzors[i].row > -1 else { continue }
            let hh = HHElem(zeroMatrix: colsTenzors.count, h: 1)
            hh.rows[0][i].addComb(Comb(tenzor: colsTenzors[i].t, koef: 1))
            let multRes = Matrix(mult: hh, and: dd)
            canonicalMultRes(multRes)
            items.append((i, hh, multRes))
        }
        let variants = shiftForMultRes(items, onlyOne: onlyOne)
        guard variants.count > 0 else { return nil }
        OutputFile.writeLog(.simple, "Count \(variants.count) ")
        OutputFile.writeLog(.normal, "")
        return ShiftAllVariants(seqNumber: [0], variants: [variants])
    }

    static func colsTenzors(deg: Int) -> [(row: Int, t: Tenzor)] {
        let s = PathAlg.s
        let qFrom = BimodQ(deg: deg)
        let qTo = BimodQ(deg: 0)

        var shifts: [Int] = []
        for sz in qFrom.sizes {
            if sz > 1 {
                for _ in 0 ..< sz - 1 { shifts.append(1 - s) }
            }
            shifts.append(1)
        }
        var colsTenzors: [(row: Int, t: Tenzor)] = []
        var nonZeros = 0
        var i = 0
        for j in 0..<qFrom.pij.count {
            let v1 = Vertex(i: qFrom.pij[j].0)
            let v2 = Vertex(i: qTo.pij[i].0)
            var w = Way(from: v2.number, to: v1.number, noZeroLen: true)
            if w.isZero { w = Way(from: v2.number, to: v1.number) }
            if !w.isZero {
                colsTenzors.append((i, Tenzor(left: w, right: Way(from: v2.number, to: v2.number))))
                nonZeros += 1
            } else {
                colsTenzors.append((-1, Tenzor(left: Way(), right: Way())))
            }
            i += j % s == s - 1 ? shifts[j / s] : 1
        }
        return colsTenzors
    }

    private static func canonicalMultRes(_ m: Matrix) {
        for i in 0 ..< m.width {
            let c = m.rows[0][i]
            var totalKoef = 0.0
            var columnWay: Way?
            for p in c.content {
                guard p.koef != 0 && !p.tenzor.isZero else { continue }
                let w = Way(way: p.tenzor.leftComponent)
                let wR = Way(from: p.tenzor.leftComponent.startsWith.number, to: p.tenzor.rightComponent.endsWith.number)
                w.compRight(wR)
                w.compRight(p.tenzor.rightComponent)
                guard !w.isZero else { continue }
                columnWay = Way(way: w)
                totalKoef += p.koef
            }
            if let w = columnWay, totalKoef != 0 {
                c.setComb(Comb(tenzor: Tenzor(left: w, right: Way(from: 0, to: 0)), koef: totalKoef))
            } else {
                c.setComb(Comb())
            }
        }
    }

    private static func shiftForMultRes(_ items: [(Int, HHElem, Matrix)], onlyOne: Bool) -> [ShiftVariant] {
        var result: [ShiftVariant] = []
        for i in 0 ..< items.count {
            OutputFile.writeLog(.time, "\(i) of \(items.count)")
            shiftForMultRes(items, startIndex: i, onlyOne: onlyOne, result: &result)
            if onlyOne && !result.isEmpty { break }
        }
        return result
    }

    private static func shiftForMultRes(_ items: [(Int, HHElem, Matrix)], startIndex: Int, onlyOne: Bool, result: inout [ShiftVariant]) {
        let rowMask = twoDeg(items.count)
        for r in 1 ..< rowMask {
            guard r & (1 << startIndex) == 0 else { continue }
            for goodPosMode in [GoodPosMode.first, GoodPosMode.last, GoodPosMode.index1] {
                for useLastTenzor in (PathAlg.s == 1 ? [false, true] : [false]) {
                    let hhElem = HHElem()
                    hhElem.makeZeroMatrix(items[startIndex].1.width, h: 1)
                    hhElem.addMatrix(items[startIndex].1)
                    let nDiff = shiftForRowMask(r, items: items, multRes: items[startIndex].2,
                                                goodPosMode: goodPosMode, useLastTenzor: useLastTenzor, result: hhElem)
                    if nDiff != 0 { continue }
                    var hasHH = false
                    for v in result {
                        if v.hh.isEq(hhElem, debug: false) {
                            if (v.key!.intValue > r) { v.key!.intValue = r }
                            hasHH = true
                            break
                        }
                    }
                    if !hasHH {
                        result += [ ShiftVariant(HH: hhElem, key: NumInt(intValue: r)) ]
                        if onlyOne { return }
                    }
                }
            }
        }
    }

    private static func shiftForRowMask(_ rowMask: Int, items: [(Int, HHElem, Matrix)], multRes: Matrix,
                                        goodPosMode: GoodPosMode, useLastTenzor: Bool, result hh_shift: HHElem) -> Int {
        let multRes_shift = Matrix(zeroMatrix: multRes.width, h: multRes.height)
        multRes_shift.addMatrix(multRes)

        //PrintUtils.printMatrix("hh", hh_shift)
        //PrintUtils.printMatrix("multRes", multRes_shift)

        var nDifferents = multRes_shift.nonZeroCount
        var step = 0
        while nDifferents > 0 {
            var goodPositions: [Int]?
            var i = 0
            for i0 in 0 ..< multRes_shift.width {
                guard !multRes_shift.rows[0][i0].isZero else { continue }
                var goodPoses: [Int] = []
                for k in 0 ..< items.count {
                    guard hh_shift.rows[0][items[k].0].isZero && !items[k].2.rows[0][i0].isZero else { continue }
                    guard rowMask & (1 << k) != 0 else { continue }
                    goodPoses += [k]
                }
                guard goodPoses.count > 0 else { continue }
                if goodPositions == nil || goodPositions!.count > goodPoses.count {
                    goodPositions = goodPoses
                    i = i0
                }
                if goodPoses.count == 1 { break }
            }
            guard (goodPositions?.count ?? 0) > 0 else { break }

            let goodPos: Int
            switch goodPosMode {
            case .first: goodPos = goodPositions![0]
            case .last: goodPos = goodPositions!.last!
            case .index1: goodPos = goodPositions!.count > 1 ? goodPositions![1] : goodPositions![0]
            }

            let koef = multRes_shift.rows[0][i].terminateKoef(isLast: true) /
                items[goodPos].2.rows[0][i].terminateKoef(isLast: true)
            hh_shift.addMatrix(items[goodPos].1, koef: -koef)
            multRes_shift.addMatrix(items[goodPos].2, koef: -koef)
            nDifferents = multRes_shift.nonZeroCount
            //PrintUtils.printMatrix("hh_shift", hh_shift)
            //PrintUtils.printMatrix("multRes_shift", multRes_shift)

            if step > 5 { break }
            step += 1
        }
        return nDifferents
    }
}

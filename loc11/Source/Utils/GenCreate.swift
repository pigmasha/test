//
//  GenCreate.swift
//  Created by M on 25.05.2022.
//

import Foundation

final class GenCreate {
    static var allElements: [Gen] {
        return deg0Gens + deg1Gens + deg2Gens + deg3Gens + deg4Gens
    }

    private static var deg0Gens: [Gen] {
        return [
            Gen(label: "1", deg: 0, elem: [Element(way: Way.e)]),
            Gen(label: "p1", deg: 0, elem: [Element(way1: Way.xy, way2: Way.yx)]),
            Gen(label: "p2", deg: 0, elem: [Element(way: Way.zx)]),
            Gen(label: "p3", deg: 0, elem: [Element(way: Way.zy)]),
            Gen(label: "p4", deg: 0, elem: [Element(way: Way(type: .x, len: 2 * PathAlg.kk))])
        ]
    }

    private static var deg1Gens: [Gen] {
        let items: [Gen] = PathAlg.kk % 2 == 0 ? [
            Gen(label: "u1", deg: 1, elem: [Element(way: Way.x), Element()]),
        ] : [
            Gen(label: "u1'", deg: 1, elem: [Element(way: Way(type: .x, len: 3)), Element()])
        ]
        return items + [
            Gen(label: "u2", deg: 1, elem: [Element(way: Way.x), Element(way: Way.y)]),
            Gen(label: "u3", deg: 1, elem: [Element(way: Way.zy), Element()]),
            Gen(label: "u4", deg: 1, elem: [Element(), Element(way: Way.zx)])
        ]
    }

    private static var deg2Gens: [Gen] {
        return [
            Gen(label: "v1", deg: 2, elem: [Element(), Element(way: Way.e), Element()]),
            Gen(label: "v2", deg: 2, elem: [Element(), Element(), Element(way: Way.e)]),
            Gen(label: "v3", deg: 2, elem: [Element(), Element(way: Way.x), Element()]),
            Gen(label: "v4", deg: 2, elem: [Element(), Element(), Element(way: Way.y)]),
            Gen(label: "v5", deg: 2, elem: [Element(way1: Way.xy, way2: Way.yx),
                                            Element(way: Way.xy),
                                            Element(way: Way.xy)]),
            Gen(label: "v6", deg: 2, elem: [Element(way: Way(type: .x, len: 2 * PathAlg.kk)), Element(), Element()]),
        ]
    }

    private static var deg3Gens: [Gen] {
        return PathAlg.kk % 2 == 0 ? [
            Gen(label: "w1", deg: 3, elem: [Element(way: Way.x), Element(), Element(), Element(way: Way.y)]),
            Gen(label: "w2", deg: 3, elem: [Element(), Element(way: Way.y), Element(way: Way.x), Element()])
        ] : [
            Gen(label: "w1'", deg: 3, elem: [Element(way: Way.x), Element(), Element(way: Way.x), Element()]),
            Gen(label: "w2'", deg: 3, elem: [Element(), Element(way: Way.y), Element(), Element(way: Way.y)])
        ]
    }

    private static var deg4Gens: [Gen] {
        return [
            Gen(label: "t", deg: 4, elem: [Element(way: Way.e), Element(way: Way.e), Element(way: Way.e),
                                           Element(), Element()])
        ]
    }

    private var imRows: [[Element]] = []
    private var imRk = -1
    private let deg: Int

    init(deg: Int) {
        self.deg = deg
    }

    func check(_ elem: Gen) -> String? {
        if elem.deg != deg { return "Bad deg \(deg)" }
        if Utils.qSize(elem.deg) != elem.elem.count { return "Bad count, should be \(Utils.qSize(elem.deg))" }
        return checkKer(elem) ?? checkNotIm(elem)
    }

    private func checkKer(_ elem: Gen) -> String? {
        let m = Matrix(zeroMatrix: elem.elem.count, h: 1)
        for i in 0 ..< elem.elem.count {
            for (k, w) in elem.elem[i].contents {
                m.rows[0][i].add(left: w, right: Way.e, koef: k.n)
            }
        }
        let zeroMatrix = Matrix(mult: m, and: Diff(deg: elem.deg))
        if zeroMatrix.height != 1 { return "checkKer: Bad matrix height \(zeroMatrix.height)" }
        for c in zeroMatrix.rows[0] {
            if c.isZero { continue }
            let res = ImMatrix.element(from: c, way: nil)
            switch res {
            case .ok(let e):
                if !e.isZero { return "checkKer: Comb not zero in im " + c.str }
            case .error(let error):
                return "checkKer: " + error
            }
        }
        return nil
    }

    func checkNotIm(_ elem: Gen, inIm: Bool = false, log: Bool = false) -> String? {
        if imRk == -1 {
            if elem.deg == 0 {
                imRk = 0
                imRows = []
            } else {
                let im = ImMatrix(diff: Diff(deg: elem.deg - 1))
                imRk = KoefIntMatrix(im: im.rows).rank
                imRows = im.rows
            }
        }
        if !imRows.isEmpty && imRows[0].count != elem.elem.count { return "checkNotIm: Bad elem count, im width=\(imRows[0].count)" }
        imRows.append(elem.elem.map { Element(element: $0) })
        if log { PrintUtils.printImRows("Im", imRows); PrintUtils.printKoefIntMatrix("KK", KoefIntMatrix(im: imRows)) }
        let addRk = KoefIntMatrix(im: imRows).rank
        if inIm {
            _ = imRows.popLast()
            return addRk == imRk ? nil : "checkNotIm: Not in im"
        }
        if addRk == imRk {
            _ = imRows.popLast()
            return "checkNotIm: Same rank \(addRk)"
        } else {
            imRk = addRk
        }
        return nil
    }

    func printIm() {
        PrintUtils.printImRows("Im rows", imRows);
    }
}

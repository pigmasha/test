//
//  GenCreate.swift
//  D3
//
//  Created by M on 11.11.2021.
//

import Foundation

final class GenCreate {
    static var allElements: [Gen] {
        return deg0Gens + deg1Gens + deg2Gens + [
            Gen(label: "z1", deg: 3, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (0, Way.zero), (1, Way.e1), (1, Way.e2), (1, Way.e3),
                                            (0, Way.zero), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "z2", deg: 3, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (1, Way.e1), (1, Way.e2), (1, Way.e3)])
        ]
    }

    private static var deg0Gens: [Gen] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let c1 = Gen(label: "c1", deg: 0, elem: [(1, Way.alpha1), (1, Way.beta2), (0, Way.zero)])
        let c2 = Gen(label: "c2", deg: 0, elem: [(0, Way.zero), (1, Way.alpha2), (1, Way.beta3)])
        let c3 = Gen(label: "c3", deg: 0, elem: [(1, Way.beta1), (0, Way.zero), (1, Way.alpha3)])
        return [
            Gen(label: "1", deg: 0, elem: [(1, Way.e1), (1, Way.e2), (1, Way.e3)])
        ] + (n3 == 1 ? [] : [c1]) + (n1 == 1 ? [] : [c2]) + (n2 == 1 ? [] : [c3]) + [
            Gen(label: "p1", deg: 0, elem: [(1, Way.alpha1(deg: n3)), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "p2", deg: 0, elem: [(0, Way.zero), (1, Way.alpha2(deg: n1)), (0, Way.zero)]),
            Gen(label: "p3", deg: 0, elem: [(0, Way.zero), (0, Way.zero), (1, Way.alpha3(deg: n2))]),
        ]
    }

    private static var deg1Gens: [Gen] {
        let (n1, n2, n3, rkC) = (PathAlg.n1, PathAlg.n2, PathAlg.n3, PathAlg.rkC)
        let x1 = Gen(label: "x1", deg: 1, elem: [(n1 * n2, Way(type: .a12, len: 1)),
                                               (n2 * n3, Way(type: .a23, len: 1)),
                                               (n3 * n1, Way(type: .a31, len: 1)),
                                               (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x2 = Gen(label: "x2", deg: 1, elem: [(1, Way(type: .a12, len: 1)), (0, Way.zero), (0, Way.zero),
                                                 (1, Way(type: .a21, len: 1)), (0, Way.zero), (0, Way.zero)])
        let x3 = Gen(label: "x3", deg: 1, elem: [(1, Way(type: .a12, len: 3)), (0, Way.zero), (0, Way.zero),
                                                 (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x4 = Gen(label: "x4", deg: 1, elem: [(0, Way.zero), (0, Way.zero), (1, Way(type: .a31, len: 3)),
                                                 (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x1_1 = Gen(label: "x1_1", deg: 1, elem: [(0, Way.zero), (1, Way(type: .a23, len: 1)), (0, Way.zero),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x1_2 = Gen(label: "x1_2", deg: 1, elem: [(0, Way.zero), (0, Way.zero), (1, Way(type: .a31, len: 1)),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x2_1 = Gen(label: "x2_1", deg: 1, elem: [(1, Way(type: .a12, len: 1)), (0, Way.zero), (0, Way.zero),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x2_2 = Gen(label: "x2_2", deg: 1, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                     (1, Way(type: .a21, len: 1)), (0, Way.zero), (0, Way.zero)])
        switch rkC {
        case 0: return [x1_1, x1_2, x2_1, x2_2]
        case 1: return [x2, x1_1, x1_2] + (n3 == 1 ? [] : [x3])
        default: return n1 % 2 == 0 ? [x1, x2] + (n3 == 1 ? [] : [x3]) + (n2 == 1 ? [] : [x4]) : [x1, x2]
        }
    }

    private static var deg2Gens: [Gen] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        return [
            Gen(label: "y1", deg: 2, elem: [(1, Way.e1), (1, Way.e2), (1, Way.e3), (0, Way.zero),
                                            (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "y2", deg: 2, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (1, Way(type: .a12, len: 2 * n3 - 1)),
                                            (1, Way(type: .a23, len: 2 * n1 - 1)),
                                            (1, Way(type: .a31, len: 2 * n2 - 1)),
                                            (0, Way.zero), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "y3", deg: 2, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (1, Way(type: .a21, len: 2 * n3 - 1)),
                                            (1, Way(type: .a32, len: 2 * n1 - 1)),
                                            (1, Way(type: .a13, len: 2 * n2 - 1))])
        ]
    }

    private var imRows: [[(Int, Way)]] = []
    private var imRk = -1
    private let deg: Int

    init(deg: Int) {
        self.deg = deg
    }

    func check(_ elem: Gen) -> String? {
        if elem.deg != deg { return "Bad deg \(deg)" }
        let q = BimodQ(deg: elem.deg)
        if q.pij.count != elem.elem.count {
            return "Bad count, should be \(q.pij.count)"
        }
        for i in 0 ..< elem.elem.count {
            if elem.elem[i].0 == 0 { continue }
            let w = elem.elem[i].1
            if w.isZero {
                return "Zero \(i)-th way"
            }
            if w.startVertex != q.pij[i].1 {
                return "Bad startVertex in \(i)-th way \(w.str), should be " + q.pij[i].1.str
            }
            if w.endVertex != q.pij[i].0 {
                return "Bad endVertex in \(i)-th way \(w.str), should be " + q.pij[i].0.str
            }
        }
        return checkKer(elem) ?? checkNotIm(elem)
    }

    private func checkKer(_ elem: Gen) -> String? {
        let q = BimodQ(deg: elem.deg)
        let m = Matrix(zeroMatrix: elem.elem.count, h: 1)
        for i in 0 ..< elem.elem.count {
            if elem.elem[i].0 == 0 { continue }
            m.rows[0][i].add(left: elem.elem[i].1, right: Way(vertexType: q.pij[i].1), koef: elem.elem[i].0)
        }
        let zeroMatrix = Matrix(mult: m, and: Diff(deg: elem.deg))
        if zeroMatrix.height != 1 { return "checkKer: Bad matrix height \(zeroMatrix.height)" }
        for c in zeroMatrix.rows[0] {
            if c.isZero { continue }
            let res = ImMatrix.pair(from: c, way: nil)
            switch res {
            case .ok(let k, _):
                if k != 0 { return "checkKer: Comb not zero in im " + c.str + ", k = \(k)" }
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
        for i in 0 ..< elem.elem.count {
            if elem.elem[i].0 == 0 { continue }
            let w = elem.elem[i].1
            if let j = imRows.firstIndex(where: { $0[i].0 != 0 }) {
                if w.startVertex != imRows[j][i].1.startVertex {
                    return "checkNotIm: Bad \(i)-th startVertex, elem=" + elem.str
                }
                if w.endVertex != imRows[j][i].1.endVertex {
                    return "checkNotIm: Bad \(i)-th endVertex, elem=" + elem.str
                }
            } /*else {
                PrintUtils.printImMatrix("Im", im)
                return "checkNotIm: Zero im \(i)-th column"
            }*/
        }
        imRows.append(elem.elem)
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

//
//  Step_5_gen.swift
//  Created by M on 25.05.2022.
//

import Foundation

struct Step_5_gen {
    static func runCase() -> Bool {
        //GenCreate.allElements.forEach { OutputFile.writeLog(.normal, $0.str) }
        let deg = PathAlg.alg.someNumber
        let checker = GenCreate(deg: deg)
        var gens: [Gen] = []
        searchAllVariants(deg: deg, checker: checker, gens: &gens)
        return false
    }

    private static func searchAllVariants(deg: Int, checker: GenCreate, gens: inout [Gen]) {
        var variants: [[(Int, Way)]] = []
        var elem1: [Element] = []
        for _ in 1 ... Utils.qSize(deg) { elem1.append(Element()) }
        let ways = Way.allWays
        for i in 0 ..< elem1.count {
            var line: [(Int, Way)] = [(0, Way.zero)]
            for w in ways {
                elem1[i] = Element(way: w)
                let g = Gen(label: "S1/\(gens.count)", deg: deg, elem: elem1)
                if checker.check(g) == nil {
                    OutputFile.writeLog(.normal, "Add \(g.str)")
                    gens.append(g)
                } else if GenCreate(deg: deg).check(g) != nil {
                    line.append((1, w))
                }
                elem1[i] = Element()
            }
            variants.append(line)
        }
        for i in 0 ..< elem1.count {
            for w1 in ways {
                elem1[i] = Element(way: w1)
                for w2 in ways {
                    elem1[i].add(way: w2, koef: 1)
                    let g = Gen(label: "S1/\(gens.count)", deg: deg, elem: elem1)
                    if checker.check(g) == nil {
                        OutputFile.writeLog(.normal, "Add \(g.str)")
                        gens.append(g)
                    }
                    elem1[i].add(way: w2, koef: 1)
                }
                elem1[i] = Element()
            }
        }
        /*var sz = 1
        variants.forEach { sz *= $0.count }
        for s in 1 ..< sz {
            var elem: [Element()] = []
            var pos = s
            for v in variants {
                elem.append(v[pos % v.count])
                pos /= v.count
            }
            let g = Gen(label: "S/\(gens.count)", deg: deg, elem: elem)
            if checker.check(g) == nil {
                gens.append(g)
                OutputFile.writeLog(.normal, "Add \(g.str)")
            }
        }*/
        gens.forEach { OutputFile.writeLog(.normal, $0.str) }
    }
}

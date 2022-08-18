//
//  Step_1_calc_s.swift
//  Created by M on 15.05.2022.
//

import Foundation

struct Step_1_calc_s {
    static func runCase() -> Bool {
        //return checkD2()
        for d in 0 ..< PathAlg.alg.someNumber {
            let d1 = PDiff(deg: d)
            //OutputFile.writeLog(.normal, "d<sub>\(d)</sub>: Q<sub>\(d+1)</sub> &rarr; Q<sub>\(d)</sub>")
            PrintUtils.printPMatrix("", d1)
            let ker = PKer.ker(d1)
            OutputFile.writeLog(.normal, "\(d): " + ker.htmlStr)
            let d2 = PDiff(deg: d + 1)
            let m = PMatrix(mult: d1, and: d2)
            if !m.isZero {
                PrintUtils.printPMatrix("", d2)
                PrintUtils.printPMatrix("Mult (not zero!)", m)
                return true
            }
            let im = PKer.im(d2)
            OutputFile.writeLog(.normal, "\(d): " + im.htmlStr)
            for item in ker.items {
                if !im.contains(item) {
                    OutputFile.writeLog(.normal, item.str + " not found in im!")
                    //return true
                }
            }
        }
        return false
    }

    private static func checkD2() -> Bool {
        for d in 0 ..< PathAlg.alg.someNumber {
            let d1 = PDiff(deg: d)
            PrintUtils.printPMatrix("", d1)
            let d2 = PDiff(deg: d + 1)
            let m = PMatrix(mult: d1, and: d2)
            if !m.isZero {
                PrintUtils.printPMatrix("", d2)
                PrintUtils.printPMatrix("Mult (not zero!)", m)
                return true
            }
        }
        return false
    }
}


import Foundation

struct Utils {
    static func gcd(_ ii: Int, j jj: Int) -> Int {
        let i = ii < 0 ? -ii : ii
        let j = jj < 0 ? -jj : jj
        var k = i > j ? i : j
        var l = i > j ? j : i
        var p = 0
        while (k % l != 0) {
            p = k % l
            k = l
            l = p
        }
        return l
    }

    static func pathWithShift(_ shift: Int, type: Int) -> String {
        return OutputFile.fileName! + ".s\(PathAlg.s).sh\(shift).t\(type).txt"
    }
}

func f(_ x: Int, _ y: Int) -> Int {
    return x == y ? 1 : 0
}

func f(_ x: Int, _ y1: Int, _ y2: Int) -> Int {
    return x >= y1 && x <= y2 ? 1 : 0
}

func f0(_ x: Int, _ y: Int) -> Int {
    return x < y ? 1 : 0
}

func sigmaDeg() -> Int {
    let s = PathAlg.s
    let s0 = s / Utils.gcd(s, j: 15)

    if (PathAlg.charK == 2) { return s0 }
    return s0 % 2 == 0 ? s0 : 2*s0
}

// 2^k
func twoDeg(_ k: Int) -> Int {
    var n = 1
    for _ in 0 ..< k { n *= 2 }
    return n
}

// 3^k
func threeDeg(_ k: Int) -> Int {
    var n = 1
    for _ in 0 ..< k { n *= 3 }
    return n
}

// (-1)^s
func minusDeg(_ s: Int) -> Int {
    return s % 2 == 0 ? 1 : -1
}

func isPrimary(_ n: Int) -> Bool {
    if n < 4 { return true }
    let n2 = n / 2 + 1
    for i in 2 ..< n2 {
        if n % i == 0 { return false }
    }
    return true
}

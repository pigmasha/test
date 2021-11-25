
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

    static func isPrimary(_ n: Int) -> Bool {
        if n < 4 { return true }
        let n2 = n / 2 + 1
        for i in 2 ..< n2 {
            if n % i == 0 { return false }
        }
        return true
    }

    static func minusDeg(_ n: Int) -> Int {
        return n % 2 == 0 ? 1 : -1
    }
}

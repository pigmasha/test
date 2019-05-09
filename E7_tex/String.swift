//
//  Created by M on 30.09.2018.
//

import Foundation

extension String {
    func scanFirst(regexp: String) -> [String]? {
        let nsString = self as NSString
        let regex = try! NSRegularExpression(pattern: regexp, options: .caseInsensitive)
        guard let match = regex.firstMatch(in: self, range: nsString.wholeRange) else {
            return nil
        }

        var result: [String] = []
        for i in 1 ..< match.numberOfRanges {
            result.append(nsString.substring(with: match.range(at: i)))
        }
        return result
    }
}

extension NSString {
    var wholeRange: NSRange {
        return NSRange(location: 0, length: length)
    }

    func rangeFrom(_ l: Int) -> NSRange {
        return l < 0 ? NSRange(location: length + l, length: -l) : NSRange(location: l, length: length - l)
    }

    func rangeTo(_ l: Int) -> NSRange {
        return NSRange(location: 0, length: l)
    }

    func rangeFrom(_ range: NSRange) -> NSRange {
        return rangeFrom(range.upperBound)
    }
}

extension NSRange {
    init(to: Int) {
        self.init(location: 0, length: to)
    }

    init(from: Int, to: Int) {
        self.init(location: from, length: to - from)
    }

    init(from: Int, len: Int) {
        self.init(location: from, length: len)
    }
}

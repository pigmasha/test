//
//  Created by M on 17.04.16.
//

import Foundation

final class OutputFile {
    static var fileName : String? = nil
    private static var fileNames : [String] = []
    private var fh: FileHandle

    enum LogMode {
        case normal  // 0
        case error   // 1
        case bold    // 2
        case h2      // 3
        case simple  // 4
        case time    // 5
        case simpleTime
    }
    static func setFileName(fileName: String) throws {
        self.fileName = fileName
        if !fileNames.contains(fileName) {
            try header.write(toFile: fileName, atomically: true, encoding: .utf8)
            fileNames += [ fileName ]
        }
    }

    static func writeLog(_ mode: LogMode, _ string: String) {
        OutputFile().write(prefixForMode(mode) + string + suffixForMode(mode))
    }

    private class func prefixForMode(_ mode: LogMode) -> String {
        switch mode {
        case .error:
            return "<b style='color:red;'>ERROR!\n"
        case .bold:
            return "<b>\n"
        case .h2:
            return "<h2>\n"
        case .time:
            return "<b>" + DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium) + " \n"
        case .simpleTime:
            return DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium) + " "
        case .normal, .simple:
            return ""
        }
    }

    private class func suffixForMode(_ mode: LogMode) -> String {
        switch mode {
        case .normal:
            return "<br>\n"
        case .error, .bold, .time:
            return "</b><br>\n"
        case .h2:
            return "</h2>\n"
        case .simple, .simpleTime:
            return ""
        }
    }

    init() {
        fh = FileHandle(forWritingAtPath: OutputFile.fileName!)!
        fh.seekToEndOfFile()
    }

    func write(_ string: String) {
        fh.write(string.data(using: String.Encoding.utf8)!)
    }

    func writeln(_ string: String) {
        write(string + "\n")
    }

    static let header = "<html>\n" +
        "<head>\n" +
        "<title>Results</title>\n" +
        "<style>\n" +
        "table { border-spacing:0px; border-collapse:collapse; border:1px solid black; }\n" +
        "td { border:1px solid black; text-align:center; padding:2px; font-size:14px; }\n" +
        ".b_w { border:1px solid white; }\n" +
        ".b_l { border-left:3px solid black; }\n" +
        "</style>\n" +
        "</head>\n" +
    "<body>"
}

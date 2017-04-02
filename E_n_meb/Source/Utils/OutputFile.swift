//
//  Created by M on 17.04.16.
//
//

import Foundation

class OutputFile : NSObject {
    static var fileName : String? = nil
    private var fh: FileHandle

    static func setFileName(fileName: String) throws {
        self.fileName = fileName
        try header.write(toFile: fileName, atomically: true, encoding: .utf8)
    }

    // mode:0 - normal, 1 - error, 2 - bold, 3 - h2, 4 - simple, 5 - with time
    static func writeLog(_ mode: Int, _ format: String, _ args: CVarArg...) {
        let string = String(format: format, arguments: args)
        let file = OutputFile()
        file.write(prefixForMode(mode) + string + suffixForMode(mode))
    }

    private class func prefixForMode(_ mode: Int) -> String {
        switch mode {
        case 1: return "<b style='color:red;'>ERROR!\n"
        case 2: return "<b>\n"
        case 3: return "<h2>\n"
        case 5:
            let t = time(nil)
            let t0 = t / 60
            let t1 = t0 / 60
            return  String(format: "<b>%02d:%02d:%02d \n", Int(t1 % 60), Int(t0 % 60), Int(t % 60))
        default: return ""
        }
    }

    private class func suffixForMode(_ mode: Int) -> String {
        switch mode {
        case 0: return "<br>\n"
        case 1, 2, 5: return "</b><br>\n"
        case 3: return "</h2>\n"
        default: return ""
        }
    }

    override init() {
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
        "table { padding:0; border-spacing:0px; border-collapse:collapse; border: 1px solid black; }\n" +
        "td { border: 1px solid black; text-align: center }\n" +
        ".c_t_1 { border-top: 4px solid grey; }\n" +
        ".c_t_2 { border-top: 4px solid black; }\n" +
        ".c_l_1 { border-left:4px solid grey; }\n" +
        ".c_l_2 { border-left:4px solid black; }\n" +
        ".c_r_1 { border-right:4px solid black; }\n" +
        ".c_b_1 { border-bottom: 4px solid black; }\n" +
        ".b_w { border: 1px solid white; }\n" +
        ".b_l { border-left:4px solid black; }\n" +
        "</style>\n" +
        "</head>\n" +
    "<body>"
}

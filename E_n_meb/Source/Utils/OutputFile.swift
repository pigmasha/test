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
    class func writeLog(_ mode: Int, _ format: String, _ args: CVarArg...) {
        let string = String(format: format, arguments: args)
        let file = OutputFile()
        file.write(string)
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

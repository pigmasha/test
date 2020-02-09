//
//  Created by M on 03.04.17.
//

import Cocoa

final class Application: NSApplication {
    private let strongDelegate = AppDelegate()

    override init() {
        super.init()
        self.delegate = strongDelegate
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    private var window: NSWindow!
    private var pathFrom: NSTextField!
    private var pathTo: NSTextField!
    private var info: NSTextView!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let window = NSWindow(contentRect: NSMakeRect(0, 0, 600, 400),
                              styleMask: [.titled, .closable, .miniaturizable, .resizable],
                              backing: .buffered,
                              defer: false)
        window.minSize = NSMakeSize(400, 300)
        window.title = "E_8 - tex"
        window.delegate = self
        self.window = window

        let v = window.contentView!
        let w = v.bounds.width
        var y = v.bounds.height - 20 - Constants.buttonH

        addLabel(to: v, align: .right, autoSz: .minYMargin, x: 10, y: y - 3, w: 70, text: "Html file:")
        pathFrom = addField(to: v, autoSz: [ .width, .minYMargin], x: 90, y: y, w: w - 2 * Constants.buttonW - 10)
        _ = addButton(to: v, title: "Browse...", action: #selector(onFileFrom),
                           autoSz: [.minXMargin, .minYMargin], x: w - Constants.buttonW - 10, y: y)

        // s, n, char
        y -= 44
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: 10, y: y - 3, w: 70, text: "Result:")
        pathTo = addField(to: v, autoSz: [ .width, .minYMargin], x: 90, y: y, w: w - 2 * Constants.buttonW - 10)
        _ = addButton(to: v, title: "Browse...", action: #selector(onFileTo),
                      autoSz: [.minXMargin, .minYMargin], x: w - Constants.buttonW - 10, y: y)

        // run
        y -= 44
        _ = addButton(to: v, title: "Run", action: #selector(onRun), autoSz: .minYMargin, x: 90, y: y)
        _ = addButton(to: v, title: "Open tex", action: #selector(onOpen), autoSz: .minYMargin, x: 90 + Constants.buttonW, y: y)
        _ = addButton(to: v, title: "Exit", action: #selector(onCancel), autoSz: .minXMargin, x: 90 + 2*Constants.buttonW, y: y)

        loadDefaults()

        // info
        y -= 44
        let info = NSTextView(frame: NSMakeRect(0, 0, w - 20, y - 20))
        info.autoresizingMask = [.width, .height]
        info.font = NSFont.systemFont(ofSize: Constants.labelFontSz)
        info.isEditable = false
        let scr = NSScrollView(frame: NSMakeRect(10, 10, w - 20, y + 20))
        scr.documentView = info
        scr.hasVerticalScroller = true
        scr.hasHorizontalScroller = false
        scr.autohidesScrollers = true
        scr.borderType = .grooveBorder
        scr.autoresizingMask = [.width, .height]
        v.addSubview(scr)
        self.info = info

        // show
        window.center()
        window.makeKeyAndOrderFront(NSApp)
    }

    private func addInfoStr(_ str: String) {
        info.string = info.string == "" ? str : info.string + "\n" + str
        print(str)
    }

    // MARK:- Run
    @objc func onRun() {
        saveDefaults()

        info.string = ""
        
        let pathFrom = self.pathFrom.stringValue
        guard pathFrom != "" else {
            addInfoStr("ERROR! Select .html")
            return
        }

        let pathTo = self.pathTo.stringValue
        guard pathTo != "" else {
            addInfoStr("ERROR! Select .tex")
            return
        }

        if let errorStr = RunCase.run(pathFrom: pathFrom, pathTo: pathTo) {
            addInfoStr("ERROR! \(errorStr)")
        } else {
            addInfoStr("Success!")
        }
    }

    // MARK: Buttons actions
    @objc func onFileFrom() {
        let p = NSOpenPanel()
        p.message = "Select source folder"
        p.canChooseDirectories = true
        p.canChooseFiles = false
        p.beginSheetModal(for: window) { [unowned self] returnCode in
            if returnCode == .OK {
                self.pathFrom.stringValue = p.url?.path ?? ""
                self.saveDefaults()
            }
        }
    }

    @objc func onFileTo() {
        let p = NSSavePanel()
        p.message = "Save to .tex"
        p.nameFieldStringValue = "res"
        p.allowedFileTypes = ["tex"]
        p.beginSheetModal(for: window) { [unowned self] returnCode in
            if returnCode == .OK {
                self.pathTo.stringValue = p.url?.path ?? ""
                self.saveDefaults()
            }
        }
    }

    @objc func onCancel() {
        saveDefaults()
        window.close()
    }

    @objc func onOpen() {
        NSWorkspace.shared.openFile(pathTo.stringValue)
        onCancel()
    }

    // MARK: UI
    private func addLabel(to superView: NSView, align: NSTextAlignment, autoSz: NSView.AutoresizingMask,
                          x: CGFloat, y: CGFloat, w: CGFloat, text: String) {
        let view = NSTextField(frame: NSMakeRect(x, y, w, Constants.buttonH))
        view.autoresizingMask = autoSz
        view.alignment = align
        view.isBezeled = false
        view.drawsBackground = false
        view.isEditable = false
        view.font = .systemFont(ofSize: Constants.labelFontSz)
        view.stringValue = text
        superView.addSubview(view)
    }
    private func addField(to superView: NSView, autoSz: NSView.AutoresizingMask, x: CGFloat, y: CGFloat, w: CGFloat) -> NSTextField {
        let view = NSTextField(frame: NSMakeRect(x, y, w, Constants.buttonH))
        view.autoresizingMask = autoSz
        view.font = .systemFont(ofSize: Constants.labelFontSz)
        superView.addSubview(view)
        return view
    }
    private func addButton(to superView: NSView, title: String, action: Selector, autoSz: NSView.AutoresizingMask,
                           x: CGFloat, y: CGFloat) -> NSButton {
        let view = NSButton(frame: NSMakeRect(x, y, Constants.buttonW, Constants.buttonH))
        view.autoresizingMask = autoSz
        view.bezelStyle = .rounded
        view.font = .systemFont(ofSize: 13)
        view.title = title
        view.target = self
        view.action = action
        superView.addSubview(view)
        return view
    }

    // MARK: Defaults
    private func loadDefaults() {
        pathFrom.stringValue = UserDefaults.standard.object(forKey: "P1") as? String ?? ""
        pathTo.stringValue = UserDefaults.standard.object(forKey: "P2") as? String ?? ""
    }
    private func saveDefaults() {
        UserDefaults.standard.set(pathFrom.stringValue, forKey: "P1")
        UserDefaults.standard.set(pathTo.stringValue, forKey: "P2")
    }

    // MARK: NSApplicationDelegate
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    // MARK: NSWindowDelegate
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        saveDefaults()
        return true
    }
}

private enum Constants {
    static let buttonW: CGFloat = 100
    static let buttonH: CGFloat = 24
    static let labelFontSz: CGFloat = 15
}

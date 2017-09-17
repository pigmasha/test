//
//  Created by M on 03.04.17.
//
//

import Cocoa

class Application: NSApplication {
    let strongDelegate = AppDelegate()

    override init() {
        super.init()
        self.delegate = strongDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@NSApplicationMain
class AppDelegate : NSObject, NSApplicationDelegate, NSWindowDelegate {
    private let kNN = 6

    private let kButtonW: CGFloat = 100
    private let kButtonH: CGFloat = 24
    private let kLabelFontSz: CGFloat = 15

    private var window: NSWindow? = nil
    private var path: NSTextField? = nil
    private var info: NSTextView? = nil
    private var sFrom: NSTextField? = nil
    private var sTo: NSTextField? = nil
    private var charKFrom: NSTextField? = nil
    private var charKTo: NSTextField? = nil
    private var dummy1: NSTextField? = nil

    private var btRun: NSButton? = nil
    private var btFile: NSButton? = nil
    private var btCancel: NSButton? = nil

    private var isRun = false
    private var isErr = false
    private var sMax = 0
    private var charMax = 0

    func applicationDidFinishLaunching(_ notification: Notification) {
        let window = NSWindow(contentRect: NSMakeRect(0, 0, 700, 520),
                              styleMask: [.titled, .closable, .miniaturizable, .resizable],
                              backing: .buffered,
                              defer: false)
        window.minSize = NSMakeSize(700, 450)
        window.title = "E_n meb"
        window.delegate = self
        self.window = window

        let v = window.contentView!
        let w = v.bounds.width
        var y = v.bounds.height - 20 - kButtonH

        addLabel(to: v, align: .right, autoSz: .viewMinYMargin, x: 10, y: y - 3, w: 70, text: "Html file:")
        path = addField(to: v, autoSz: [ .viewWidthSizable, .viewMinYMargin], x: 90, y: y, w: w - 2 * kButtonW - 10)
        btFile = addButton(to: v, title: "Browse...", action: #selector(onFile),
                           autoSz: [.viewMinXMargin, .viewMinYMargin], x: w - kButtonW - 10, y: y)

        // s, n, char
        y -= 44
        addLabel(to: v, align: .left, autoSz: .viewMinYMargin, x: 20, y: y - 3, w: 50, text: "N = \(kNN)")
        var x: CGFloat = 70
        sFrom = addField(to: v, autoSz: .viewMinYMargin, x: x + 22, y: y, w: 40)
        addLabel(to: v, align: .right, autoSz: .viewMinYMargin, x: x + 55, y: y - 3, w: 50, text: "≤ S ≤")
        sTo = addField(to: v, autoSz: .viewMinYMargin, x: x + 110, y: y, w: 40)

        x += 180
        charKFrom = addField(to: v, autoSz: .viewMinYMargin, x: x + 16, y: y, w: 40)
        addLabel(to: v, align: .right, autoSz: .viewMinYMargin, x: x + 55, y: y - 3, w: 65, text: "≤ char ≤")
        charKTo = addField(to: v, autoSz: .viewMinYMargin, x: x + 126, y: y, w: 40)

        x += 160
        addLabel(to: v, align: .right, autoSz: .viewMinYMargin, x: x + 35, y: y - 3, w: 85, text: "Step From")
        dummy1 = addField(to: v, autoSz: .viewMinYMargin, x: x + 126, y: y, w: 40)

        loadDefaults()

        // run
        y -= 44
        btRun = addButton(to: v, title: "Run", action: #selector(onRun), autoSz: .viewMinYMargin, x: 90, y: y)
        _ = addButton(to: v, title: "Open html", action: #selector(onOpen), autoSz: .viewMinYMargin, x: 90 + kButtonW, y: y)

        // info
        y -= 44
        let info = NSTextView(frame: NSMakeRect(0, 0, w - 20, y - 20))
        info.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        info.font = NSFont.systemFont(ofSize: kLabelFontSz)
        info.isEditable = false
        let scr = NSScrollView(frame: NSMakeRect(10, 50, w - 20, y - 20))
        scr.documentView = info
        scr.hasVerticalScroller = true
        scr.hasHorizontalScroller = false
        scr.autohidesScrollers = true
        scr.borderType = .grooveBorder
        scr.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        v.addSubview(scr)
        self.info = info

        // cancel
        btCancel = addButton(to: v, title: "Exit", action: #selector(onCancel), autoSz: .viewMinXMargin, x: w - kButtonW - 10, y: 10)

        // show
        window.center()
        window.makeKeyAndOrderFront(NSApp)
    }

    private func addInfoStr(_ str: String) {
        info!.string = info!.string == "" ? str : info!.string! + "\n" + str
    }

    // MARK:- Run
    func onRun() {
        saveDefaults()
        guard isRun == false else { return }

        let n = kNN
        info?.string = ""
        addInfoStr("Check params")

        let s = sTo?.integerValue ?? 0
        guard s > 0 else {
            addInfoStr("ERROR! s < 1")
            return
        }
        let path = self.path?.stringValue ?? ""
        guard path != "" else {
            addInfoStr("ERROR! Select .html")
            return
        }

        PathAlg.n = n;
        sMax = s
        charMax = charKTo?.integerValue ?? 0
        PathAlg.alg.dummy1 = dummy1?.integerValue ?? 0

        do {
            try OutputFile.setFileName(fileName: path)
        } catch {
            addInfoStr("ERROR! Can't open .html file for writing")
            return
        }

        isRun = true
        btRun?.isEnabled = false
        btCancel?.isEnabled = false
        btFile?.isEnabled = false
        isErr = false

        PathAlg.s = sFrom?.integerValue ?? 0
        PathAlg.charK = charKFrom?.integerValue ?? 0
        addInfoStr("s=\(PathAlg.s)")
        performSelector(inBackground: #selector(threadCase), with: nil)
    }
    func threadCase() {
        isErr = RunCase.runCase()
        performSelector(onMainThread: #selector(caseFinished), with: nil, waitUntilDone: false)
    }
    func caseFinished() {
        if isErr {
            addInfoStr("ERROR!")
            onRunFinish()
            return
        }

        var s = PathAlg.s;
        var charK = PathAlg.charK + 1
        if charK == 1 { charK += 1 }
        while (!isPrimary(charK)) { charK += 1 }

        if (charK > charMax) {
            charK = charKFrom?.integerValue ?? 0
            s += 1
        }
        if (s > sMax) {
            addInfoStr("Success! Results are in .html")
            onRunFinish()
            return
        }

        PathAlg.s = s;
        PathAlg.charK = charK
        addInfoStr("s=\(s)")
        performSelector(inBackground: #selector(threadCase), with: nil)
    }
    private func onRunFinish() {
        isRun = false
        btRun?.isEnabled = true
        btCancel?.isEnabled = true
        btFile?.isEnabled = true
    }

    // MARK: Buttons actions
    func onFile() {
        let p = NSSavePanel()
        p.message = "Save to .html"
        p.nameFieldStringValue = "res"
        p.allowedFileTypes = ["html"]
        p.beginSheetModal(for: window!) { [unowned self] returnCode in
            if returnCode == NSFileHandlingPanelOKButton {
                self.path?.stringValue = p.url?.path ?? ""
                self.saveDefaults()
            }
        }
    }
    func onCancel() {
        saveDefaults()
        if isRun == false {
            window?.close()
        }
    }
    func onOpen() {
        NSWorkspace.shared().openFile(path!.stringValue)
    }

    // MARK: UI
    private func addLabel(to superView: NSView, align: NSTextAlignment, autoSz: NSAutoresizingMaskOptions,
                          x: CGFloat, y: CGFloat, w: CGFloat, text: String) {
        let view = NSTextField(frame: NSMakeRect(x, y, w, kButtonH))
        view.autoresizingMask = autoSz
        view.alignment = align
        view.isBezeled = false
        view.drawsBackground = false
        view.isEditable = false
        view.font = .systemFont(ofSize: kLabelFontSz)
        view.stringValue = text
        superView.addSubview(view)
    }
    private func addField(to superView: NSView, autoSz: NSAutoresizingMaskOptions, x: CGFloat, y: CGFloat, w: CGFloat) -> NSTextField {
        let view = NSTextField(frame: NSMakeRect(x, y, w, kButtonH))
        view.autoresizingMask = autoSz
        view.font = .systemFont(ofSize: kLabelFontSz)
        superView.addSubview(view)
        return view
    }
    private func addButton(to superView: NSView, title: String, action: Selector, autoSz: NSAutoresizingMaskOptions,
                           x: CGFloat, y: CGFloat) -> NSButton {
        let view = NSButton(frame: NSMakeRect(x, y, kButtonW, kButtonH))
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
        path?.stringValue = UserDefaults.standard.object(forKey: "P") as? String ?? ""
        sFrom?.integerValue = UserDefaults.standard.integer(forKey: "Smin")
        sTo?.integerValue = UserDefaults.standard.integer(forKey: "Smax")
        charKFrom?.integerValue = UserDefaults.standard.integer(forKey: "Cmin")
        charKTo?.integerValue = UserDefaults.standard.integer(forKey: "Cmax")
        dummy1?.integerValue = UserDefaults.standard.integer(forKey: "Dummy1")
    }
    private func saveDefaults() {
        UserDefaults.standard.set(path?.stringValue, forKey: "P")
        UserDefaults.standard.set(sFrom?.integerValue, forKey: "Smin")
        UserDefaults.standard.set(sTo?.integerValue, forKey: "Smax")
        UserDefaults.standard.set(charKFrom?.integerValue, forKey: "Cmin")
        UserDefaults.standard.set(charKTo?.integerValue, forKey: "Cmax")
        UserDefaults.standard.set(dummy1?.integerValue, forKey: "Dummy1")
    }

    // MARK: NSApplicationDelegate
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    // MARK: NSWindowDelegate
    func windowShouldClose(_ sender: Any) -> Bool {
        saveDefaults()
        return true
    }
}

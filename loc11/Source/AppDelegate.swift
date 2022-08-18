//
//  Created by M on 03.04.17.
//

import Cocoa

typealias FieldsTuple = (from: NSTextField, to: NSTextField, label: String)
typealias IntervalTuple = (from: Int, to: Int)

@objc(D3Application)
final class Application: NSApplication {
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
final class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow?
    private var terminateByClose = true

    private let kButtonW: CGFloat = 100
    private let kButtonH: CGFloat = 24
    private let kLabelFontSz: CGFloat = 15

    private var mainWindow: MainWindow? = nil
    private var statusBarItem: NSStatusItem?
    private let path = NSTextField(frame: .zero)
    private var info: NSTextView? = nil
    private let kkFields: FieldsTuple = (from: NSTextField(frame: .zero), to: NSTextField(frame: .zero), label: "kk")
    private let currentStep = NSTextField(frame: .zero)
    private let someNumber = NSTextField(frame: .zero)

    private let btRun = NSButton(frame: .zero)
    private let btFile = NSButton(frame: .zero)
    private let btCancel = NSButton(frame: .zero)
    private let btOpen = NSButton(frame: .zero)
    private let btSwitch = NSButton(frame: .zero)
    private let btClear = NSButton(frame: .zero)

    private var isRun = false
    private var isErr = false
    private var kkInterval: IntervalTuple = (from: 0, to: 0)

    private var intFields: [(NSTextField, String)] = []
    private var tupleFields: [FieldsTuple] = []

    func applicationDidFinishLaunching(_ notification: Notification) {
        self.window?.close()
        self.window = nil
        intFields = [(currentStep, "currentStep"), (someNumber, "someNumber")]
        tupleFields = [kkFields]
        self.mainWindow = MainWindow()

        let v = mainWindow!.window!.contentView!
        let w = v.bounds.width
        var y = v.bounds.height - 20 - kButtonH

        addLabel(to: v, align: .right, autoSz: .minYMargin, x: 10, y: y - 3, w: 70, text: "Html file:")
        addField(path, to: v, autoSz: [ .width, .minYMargin], x: 90, y: y, w: w - 2 * kButtonW - 10)
        addButton(btFile, to: v, title: "Browse...", action: #selector(onFile),
                  autoSz: [.minXMargin, .minYMargin], x: w - kButtonW - 10, y: y)

        let addTuple: (CGFloat, CGFloat, FieldsTuple) -> Void = { x, y, t in
            self.addField(t.from, to: v, autoSz: .minYMargin, x: x, y: y, w: 40)
            self.addLabel(to: v, align: .center, autoSz: .minYMargin, x: x + 35, y: y - 3, w: 60, text: "≤ " + t.label + " ≤")
            self.addField(t.to, to: v, autoSz: .minYMargin, x: x + 90, y: y, w: 40)
        }
        // s, n, char
        y -= 44
        var x: CGFloat = 50
        addTuple(x, y, kkFields)

        addButton(btClear, to: v, title: "Clear html", action: #selector(onClear), autoSz: .minYMargin, x: 190 + kButtonW, y: y)

        // run
        y -= 44
        addButton(btRun, to: v, title: "Run", action: #selector(onRun), autoSz: .minYMargin, x: 90, y: y)
        addButton(btOpen, to: v, title: "Open html", action: #selector(onOpen), autoSz: .minYMargin, x: 90 + kButtonW, y: y)

        x = 250
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x, y: y - 3, w: 85, text: "Step")
        addField(currentStep, to: v, autoSz: .minYMargin, x: x + 90, y: y, w: 40)

        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x + 120, y: y - 3, w: 85, text: "Num")
        addField(someNumber, to: v, autoSz: .minYMargin, x: x + 210, y: y, w: 40)

        loadDefaults()
        btOpen.title = path.stringValue.hasSuffix(".tex") ? "Open tex" : "Open html"

        // info
        y -= 44
        let info = NSTextView(frame: NSMakeRect(0, 0, w - 20, y - 20))
        info.autoresizingMask = [.width, .height]
        info.font = NSFont.systemFont(ofSize: kLabelFontSz)
        info.isEditable = false
        let scr = NSScrollView(frame: NSMakeRect(10, 50, w - 20, y - 20))
        scr.documentView = info
        scr.hasVerticalScroller = true
        scr.hasHorizontalScroller = false
        scr.autohidesScrollers = true
        scr.borderType = .grooveBorder
        scr.autoresizingMask = [.width, .height]
        v.addSubview(scr)
        self.info = info

        // cancel
        addButton(btCancel, to: v, title: "Exit", action: #selector(onCancel), autoSz: .minXMargin, x: w - kButtonW - 10, y: 10)
        addButton(btSwitch, to: v, title: "Menu mode", action: #selector(onSwitch), autoSz: .minXMargin, x: w - 2*kButtonW - 20, y: 10)

        // show
        mainWindow?.window?.center()
        mainWindow?.window?.makeKeyAndOrderFront(NSApp)

        //DispatchQueue.main.async { [weak self] in self?.onRun() }
    }

    private func addInfoStr(_ str: String) {
        info!.string = info!.string == "" ? str : info!.string + "\n" + str
    }

    // MARK: - Run
    @objc func onRun() {
        saveDefaults()
        guard isRun == false else { return }

        PathAlg.alg.currentStep = currentStep.integerValue
        PathAlg.alg.someNumber = someNumber.integerValue
        info?.string = ""
        addInfoStr("     -- " + RunCase.stepTitle + " --")

        let readInterval: (FieldsTuple) -> IntervalTuple? = { t in
            let tFrom = t.from.integerValue
            let tTo = t.to.integerValue
            if tFrom < 0 { self.addInfoStr("ERROR! " + t.label + ".from < 0"); return nil }
            if tTo < 0 { self.addInfoStr("ERROR! " + t.label + ".to < 0"); return nil }
            if tTo < tFrom { self.addInfoStr("ERROR! " + t.label + ".to < " + t.label + ".from"); return nil }
            return (tFrom, tTo)
        }
        if let kkI = readInterval(kkFields) {
            kkInterval = kkI
        } else { return }
        guard kkInterval.from > 1 else { self.addInfoStr("ERROR! kk.from < 2"); return }
        PathAlg.kk = kkInterval.from

        let path = self.path.stringValue
        guard path != "" else {
            addInfoStr("ERROR! Select .html")
            return
        }
        if path.hasSuffix(".tex") {
            try? FileManager.default.removeItem(atPath: path.replacingOccurrences(of: ".tex", with: ".pdf"))
            PathAlg.isTex = true
        }

        do {
            try OutputFile.setFileName(fileName: path)
        } catch {
            addInfoStr("ERROR! Can't open .html file for writing")
            return
        }

        isRun = true
        btRun.isEnabled = false
        btCancel.isEnabled = false
        btFile.isEnabled = false
        btClear.isEnabled = false
        isErr = false

        Application.shared.dockTile.badgeLabel = "•"
        startCase()
    }

    private func startCase() {
        addInfoStr("kk=\(PathAlg.kk)")
        performSelector(inBackground: #selector(threadCase), with: nil)
    }

    @objc func threadCase() {
        isErr = RunCase.runCase()
        performSelector(onMainThread: #selector(finishCase), with: nil, waitUntilDone: false)
    }

    @objc func finishCase() {
        if isErr {
            addInfoStr("ERROR!")
            onRunFinish()
            return
        }

        if PathAlg.kk < kkInterval.to {
            PathAlg.kk += 1
            startCase()
            return
        }

        if PathAlg.isTex { OutputFile.writeLog(.normal, "\\end{tiny}\\end{document}") }
        addInfoStr("Success! Results are in .html")
        onRunFinish()
    }
    private func onRunFinish() {
        isRun = false
        btRun.isEnabled = true
        btCancel.isEnabled = true
        btFile.isEnabled = true
        btClear.isEnabled = true
        Application.shared.dockTile.badgeLabel = nil
    }

    // MARK: Buttons actions
    @objc func onFile() {
        let p = NSSavePanel()
        p.message = "Save to .html"
        p.nameFieldStringValue = "res"
        p.allowedFileTypes = ["html"]
        p.beginSheetModal(for: mainWindow!.window!) { [unowned self] returnCode in
            if returnCode == .OK {
                self.path.stringValue = p.url?.path ?? ""
                self.btOpen.title = self.path.stringValue.hasSuffix(".tex") ? "Open tex" : "Open html"
                self.saveDefaults()
            }
        }
    }
    @objc func onCancel() {
        saveDefaults()
        if isRun == false {
            terminateByClose = true
            mainWindow?.window?.close()
        }
    }
    @objc func onOpen() {
        NSWorkspace.shared.openFile(path.stringValue)
        onCancel()
    }

    @objc func onSwitch() {
        terminateByClose = !terminateByClose
        if terminateByClose {
            statusBarItem = nil
            NSApp.setActivationPolicy(.regular)
        } else {
            statusBarItem = statusBarItem ?? NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
            statusBarItem?.button.flatMap { button in
                button.title = "loc11"
                button.target = self
                button.action = #selector(showApp)
            }
            NSApp.setActivationPolicy(.accessory)
        }
    }

    @objc func onClear() {
        let path = self.path.stringValue
        guard path != "" else { return }
        do {
            try OutputFile.setFileName(fileName: path, forceClear: true)
        } catch {
            addInfoStr("ERROR! Can't open .html file for writing")
        }
    }

    // MARK: UI
    private func addLabel(to superView: NSView, align: NSTextAlignment, autoSz: NSView.AutoresizingMask,
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
    private func addField(_ field: NSTextField, to superView: NSView, autoSz: NSView.AutoresizingMask, x: CGFloat, y: CGFloat, w: CGFloat) {
        field.frame = NSMakeRect(x, y, w, kButtonH)
        field.autoresizingMask = autoSz
        field.font = .systemFont(ofSize: kLabelFontSz)
        superView.addSubview(field)
    }
    private func addButton(_ button: NSButton, to superView: NSView, title: String, action: Selector,
                           autoSz: NSView.AutoresizingMask, x: CGFloat, y: CGFloat) {
        button.frame = NSMakeRect(x, y, kButtonW, kButtonH)
        button.autoresizingMask = autoSz
        button.bezelStyle = .rounded
        button.font = .systemFont(ofSize: 13)
        button.title = title
        button.target = self
        button.action = action
        superView.addSubview(button)
    }

    private let dPrefix = ""

    // MARK: Defaults
    private func loadDefaults() {
        path.stringValue = UserDefaults.standard.object(forKey: dPrefix + "P") as? String ?? ""
        for (field, name) in intFields {
            field.integerValue = UserDefaults.standard.integer(forKey: dPrefix + name)
        }
        for t in tupleFields {
            t.from.integerValue = UserDefaults.standard.integer(forKey: dPrefix + t.label + ".from")
            t.to.integerValue = UserDefaults.standard.integer(forKey: dPrefix + t.label + ".to")
        }
    }
    private func saveDefaults() {
        UserDefaults.standard.set(path.stringValue, forKey: dPrefix + "P")
        for (field, name) in intFields {
            UserDefaults.standard.set(field.integerValue, forKey: dPrefix + name)
        }
        for t in tupleFields {
            UserDefaults.standard.set(t.from.integerValue, forKey: dPrefix + t.label + ".from")
            UserDefaults.standard.set(t.to.integerValue, forKey: dPrefix + t.label + ".to")
        }
    }

    // MARK: NSApplicationDelegate
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return terminateByClose
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        showApp()
        return false
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        showApp()
    }

    @objc private func showApp() {
        mainWindow?.window?.makeKeyAndOrderFront(NSApp)
    }
}

final class MainWindow: NSWindowController {
    var statusBarItem: NSStatusItem?
    init() {
        let window = NSWindow(contentRect: NSMakeRect(0, 0, 700, 520),
                          styleMask: [.titled, .closable, .miniaturizable, .resizable],
                          backing: .buffered,
                          defer: false)
        window.minSize = NSMakeSize(700, 450)
        window.title = "loc11"
        super.init(window: window)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

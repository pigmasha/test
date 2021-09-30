//
//  Created by M on 03.04.17.
//

import Cocoa

@objc(DDApplication)
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
    private let kFrom = NSTextField(frame: .zero)
    private let cFrom = NSTextField(frame: .zero)
    private let dFrom = NSTextField(frame: .zero)
    private let charKFrom = NSTextField(frame: .zero)
    private let currentStep = NSTextField(frame: .zero)

    private let btRun = NSButton(frame: .zero)
    private let btFile = NSButton(frame: .zero)
    private let btCancel = NSButton(frame: .zero)
    private let btOpen = NSButton(frame: .zero)
    private let btSwitch = NSButton(frame: .zero)

    private var isRun = false
    private var isErr = false

    private var intFields: [(NSTextField, String)] = []

    func applicationDidFinishLaunching(_ notification: Notification) {
        self.window?.close()
        self.window = nil
        intFields = [ (kFrom, "kFrom"), (cFrom, "cFrom"), (dFrom, "dFrom"),
                      (charKFrom, "charKFrom"), (currentStep, "currentStep")]
        self.mainWindow = MainWindow()

        let v = mainWindow!.window!.contentView!
        let w = v.bounds.width
        var y = v.bounds.height - 20 - kButtonH

        addLabel(to: v, align: .right, autoSz: .minYMargin, x: 10, y: y - 3, w: 70, text: "Html file:")
        addField(path, to: v, autoSz: [ .width, .minYMargin], x: 90, y: y, w: w - 2 * kButtonW - 10)
        addButton(btFile, to: v, title: "Browse...", action: #selector(onFile),
                  autoSz: [.minXMargin, .minYMargin], x: w - kButtonW - 10, y: y)

        // s, n, char
        y -= 44
        var x: CGFloat = 70
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: 15, y: y - 3, w: 70, text: "k = ")
        addField(kFrom, to: v, autoSz: .minYMargin, x: x + 22, y: y, w: 40)
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x + 55, y: y - 3, w: 50, text: "c = ")
        addField(cFrom, to: v, autoSz: .minYMargin, x: x + 110, y: y, w: 40)

        x += 180
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x - 40, y: y - 3, w: 50, text: "d = ")
        addField(dFrom, to: v, autoSz: .minYMargin, x: x + 16, y: y, w: 40)
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x + 55, y: y - 3, w: 65, text: "char = ")
        addField(charKFrom, to: v, autoSz: .minYMargin, x: x + 126, y: y, w: 40)

        // run
        y -= 44
        addButton(btRun, to: v, title: "Run", action: #selector(onRun), autoSz: .minYMargin, x: 90, y: y)
        addButton(btOpen, to: v, title: "Open html", action: #selector(onOpen), autoSz: .minYMargin, x: 90 + kButtonW, y: y)

        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x, y: y - 3, w: 85, text: "Step")
        addField(currentStep, to: v, autoSz: .minYMargin, x: x + 90, y: y, w: 40)

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

    // MARK:- Run
    @objc func onRun() {
        saveDefaults()
        guard isRun == false else { return }

        PathAlg.alg.currentStep = currentStep.integerValue
        info?.string = ""
        addInfoStr(RunCase.stepTitle)
        addInfoStr("Check params")

        let k = kFrom.integerValue
        guard k > 1 else {
            addInfoStr("ERROR! k < 2")
            return
        }
        PathAlg.k = k

        let c = cFrom.integerValue
        PathAlg.c = c

        let d = dFrom.integerValue
        PathAlg.d = d

        let path = self.path.stringValue
        guard path != "" else {
            addInfoStr("ERROR! Select .html")
            return
        }
        if path.hasSuffix(".tex") {
            try? FileManager.default.removeItem(atPath: path.replacingOccurrences(of: ".tex", with: ".pdf"))
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
        isErr = false

        PathAlg.k = kFrom.integerValue
        PathAlg.charK = charKFrom.integerValue
        addInfoStr("k=\(PathAlg.k), char=\(PathAlg.charK)")
        Application.shared.dockTile.badgeLabel = "•"
        performSelector(inBackground: #selector(threadCase), with: nil)
    }
    @objc func threadCase() {
        isErr = RunCase.runCase()
        performSelector(onMainThread: #selector(caseFinished), with: nil, waitUntilDone: false)
    }
    @objc func caseFinished() {
        if isErr {
            addInfoStr("ERROR!")
            onRunFinish()
            return
        }

        addInfoStr("Success! Results are in .html")
        onRunFinish()
    }
    private func onRunFinish() {
        isRun = false
        btRun.isEnabled = true
        btCancel.isEnabled = true
        btFile.isEnabled = true
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
                button.title = "DD"
                button.target = self
                button.action = #selector(showApp)
            }
            NSApp.setActivationPolicy(.accessory)
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
    }
    private func saveDefaults() {
        UserDefaults.standard.set(path.stringValue, forKey: dPrefix + "P")
        for (field, name) in intFields {
            UserDefaults.standard.set(field.integerValue, forKey: dPrefix + name)
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
        window.title = "DD"
        super.init(window: window)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

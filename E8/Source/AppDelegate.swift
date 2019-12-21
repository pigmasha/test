//
//  Created by M on 03.04.17.
//

import Cocoa

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
    private let kNN = 8
    private var terminateByClose = true

    private let kButtonW: CGFloat = 100
    private let kButtonH: CGFloat = 24
    private let kLabelFontSz: CGFloat = 15

    private var mainWindow: MainWindow? = nil
    private var statusBarItem: NSStatusItem?
    private let path = NSTextField(frame: .zero)
    private var info: NSTextView? = nil
    private let sFrom = NSTextField(frame: .zero)
    private let sTo = NSTextField(frame: .zero)
    private let charKFrom = NSTextField(frame: .zero)
    private let charKTo = NSTextField(frame: .zero)
    private let dummy1 = NSTextField(frame: .zero)
    private let currentType = NSTextField(frame: .zero)
    private let currentStep = NSTextField(frame: .zero)

    private let btRun = NSButton(frame: .zero)
    private let btFile = NSButton(frame: .zero)
    private let btCancel = NSButton(frame: .zero)
    private let btOpen = NSButton(frame: .zero)
    private let btSwitch = NSButton(frame: .zero)

    private var isRun = false
    private var isErr = false
    private var sMax = 0
    private var charMax = 0

    func applicationDidFinishLaunching(_ notification: Notification) {
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
        addLabel(to: v, align: .left, autoSz: .minYMargin, x: 20, y: y - 3, w: 50, text: "N = \(kNN)")
        var x: CGFloat = 70
        addField(sFrom, to: v, autoSz: .minYMargin, x: x + 22, y: y, w: 40)
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x + 55, y: y - 3, w: 50, text: "≤ S ≤")
        addField(sTo, to: v, autoSz: .minYMargin, x: x + 110, y: y, w: 40)

        x += 180
        addField(charKFrom, to: v, autoSz: .minYMargin, x: x + 16, y: y, w: 40)
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x + 55, y: y - 3, w: 65, text: "≤ char ≤")
        addField(charKTo, to: v, autoSz: .minYMargin, x: x + 126, y: y, w: 40)

        x += 150
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x + 35, y: y - 3, w: 85, text: "Step From")
        addField(dummy1, to: v, autoSz: .minYMargin, x: x + 126, y: y, w: 40)

        x += 150
        addLabel(to: v, align: .right, autoSz: .minYMargin, x: x, y: y - 3, w: 85, text: "Type")
        addField(currentType, to: v, autoSz: .minYMargin, x: x + 90, y: y, w: 40)

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
        let n = kNN
        info?.string = ""
        addInfoStr(RunCase.stepTitle)
        addInfoStr("Check params")

        let s = sTo.integerValue
        guard s > 0 else {
            addInfoStr("ERROR! s < 1")
            return
        }
        let path = self.path.stringValue
        guard path != "" else {
            addInfoStr("ERROR! Select .html")
            return
        }
        if path.hasSuffix(".tex") {
            try? FileManager.default.removeItem(atPath: path.replacingOccurrences(of: ".tex", with: ".pdf"))
        }

        PathAlg.n = n;
        sMax = s
        charMax = charKTo.integerValue
        PathAlg.alg.dummy1 = dummy1.integerValue
        PathAlg.alg.currentType = currentType.integerValue

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

        PathAlg.s = sFrom.integerValue
        PathAlg.charK = charKFrom.integerValue
        addInfoStr("s=\(PathAlg.s), char=\(PathAlg.charK)")
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

        var s = PathAlg.s;
        var charK = PathAlg.charK + 1
        if charK == 1 { charK += 1 }
        while (!isPrimary(charK)) { charK += 1 }

        if (charK > charMax) {
            charK = charKFrom.integerValue
            s += 1
        }
        if (s > sMax) {
            addInfoStr("Success! Results are in .html")
            onRunFinish()
            return
        }

        PathAlg.s = s;
        PathAlg.charK = charK
        addInfoStr("s=\(s), char=\(charK)")
        performSelector(inBackground: #selector(threadCase), with: nil)
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
                button.title = "E8"
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
        sFrom.integerValue = UserDefaults.standard.integer(forKey: dPrefix + "Smin")
        sTo.integerValue = UserDefaults.standard.integer(forKey: dPrefix + "Smax")
        charKFrom.integerValue = UserDefaults.standard.integer(forKey: dPrefix + "Cmin")
        charKTo.integerValue = UserDefaults.standard.integer(forKey: dPrefix + "Cmax")
        dummy1.integerValue = UserDefaults.standard.integer(forKey: dPrefix + "Dummy1")
        currentType.integerValue = UserDefaults.standard.integer(forKey: dPrefix + "Type")
        currentStep.integerValue = UserDefaults.standard.integer(forKey: dPrefix + "Step")
    }
    private func saveDefaults() {
        UserDefaults.standard.set(path.stringValue, forKey: dPrefix + "P")
        UserDefaults.standard.set(sFrom.integerValue, forKey: dPrefix + "Smin")
        UserDefaults.standard.set(sTo.integerValue, forKey: dPrefix + "Smax")
        UserDefaults.standard.set(charKFrom.integerValue, forKey: dPrefix + "Cmin")
        UserDefaults.standard.set(charKTo.integerValue, forKey: dPrefix + "Cmax")
        UserDefaults.standard.set(dummy1.integerValue, forKey: dPrefix + "Dummy1")
        UserDefaults.standard.set(currentType.integerValue, forKey: dPrefix + "Type")
        UserDefaults.standard.set(currentStep.integerValue, forKey: dPrefix + "Step")
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
        window.title = "E8"
        super.init(window: window)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

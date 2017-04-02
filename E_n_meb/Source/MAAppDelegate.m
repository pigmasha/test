//
//  AppDelegate.m
//  MAProvisions
//
//  Created by M on 17.04.15.
//  Copyright (c) 2015 M. All rights reserved.
//

#import "MAAppDelegate.h"
#import "MADefsUI.h"
#import "Utils.h"

@interface MAAppDelegate ()<NSWindowDelegate> {
    NSWindow *_window;
    NSTextField *_path;
    NSTextView *_info;
    NSTextField *_s;
    NSTextField *_charK;
    
    NSButton *_btRun;
    NSButton *_btFile;
    NSButton *_btCancel;
    
    BOOL _isRun;
    BOOL _isErr;
    
    NSInteger _sMax;
    NSInteger _charMax;
}
@end

//=================================================================================

@implementation MAAppDelegate

//---------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 700, 520)
                                          styleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask
                                            backing:NSBackingStoreBuffered defer:NO];
    _window.minSize = NSMakeSize(700, 450);
    _window.title = @"E_n meb";
    _window.delegate = self;
    
    NSView *v = _window.contentView;
    NSInteger w = v.bounds.size.width;
    NSInteger y = v.bounds.size.height - 20;
    y -= BUTTON_H;
    
    NSTextField *l;
    ADD_LABEL(l, v, LABEL_FONT_SZ, NO, NSRightTextAlignment, SZ_M(MinY), 10, y - 3, 70, BUTTON_H);
    l.stringValue = @"Html file:";
    
    ADD_FIELD(_path, v, LABEL_FONT_SZ, NO, SZ(Width) | SZ_M(MinY), 90, y, w - 100 - 110, BUTTON_H);
    ADD_BUTTON(_btFile, v, @"Browse...", self, @selector(onFile), SZ_M(MinX) | SZ_M(MinY), w - 110, y, 100, BUTTON_H);
    
    // s, n, char
    y -= 44;
    ADD_LABEL(l, v, LABEL_FONT_SZ, NO, NSLeftTextAlignment, SZ_M(MinY), 20, y - 3, 50, BUTTON_H);
    l.stringValue = [NSString stringWithFormat:@"N = %d", NN];
    
    ADD_LABEL(l, v, LABEL_FONT_SZ, NO, NSRightTextAlignment, SZ_M(MinY), 70, y - 3, 50, BUTTON_H);
    l.stringValue = @"s =";
    ADD_FIELD(_s, v, LABEL_FONT_SZ, NO, SZ_M(MinY), 125, y, 50, BUTTON_H);
    
    ADD_LABEL(l, v, LABEL_FONT_SZ, NO, NSRightTextAlignment, SZ_M(MinY), 200, y - 3, 50, BUTTON_H);
    l.stringValue = @"char =";
    ADD_FIELD(_charK, v, 15, NO, SZ_M(MinY), 255, y, 50, BUTTON_H);
    
    [self loadDefaults];
    
    // run
    y -= 44;
    ADD_BUTTON(_btRun, v, @"Run", self, @selector(onRun), SZ_M(MinY), 90, y, 100, BUTTON_H);
    
    NSButton *b;
    ADD_BUTTON(b, v, @"Open html", self, @selector(onOpen), SZ_M(MinY), 190, y, 100, BUTTON_H);
    
    // info
    y -= 44;
    _info = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, w - 20, y - 20)];
    _info.autoresizingMask = SZ(Width) | SZ(Height);
    _info.font = [NSFont systemFontOfSize:15];
    _info.editable = NO;
    NSScrollView *scr = [[NSScrollView alloc] initWithFrame:NSMakeRect(10, 50, w - 20, y - 20)];
    [scr setDocumentView:_info];
    scr.hasVerticalScroller = YES;
    scr.hasHorizontalScroller = NO;
    scr.autohidesScrollers = YES;
    scr.borderType = NSGrooveBorder;
    [v addSubview:scr];
    
    // cancel
    ADD_BUTTON(_btCancel, v, @"Exit", self, @selector(onCancel), SZ_M(MinX), w - 110, 10, 100, BUTTON_H);
    
    // show
    [_window center];
    [_window makeKeyAndOrderFront:NSApp];
}

//---------------------------------------------------------------------------------
- (void)addInfoStr:(NSString *)s {
    if ([_info.string length]) {
        _info.string = [[NSString alloc] initWithFormat:@"%@\n%@", _info.string, s];
    } else {
        _info.string = s;
    }
}

#pragma mark - Run

//---------------------------------------------------------------------------------
- (void)onRun {
    [self saveDefaults];
    if (_isRun) return;
    
    NSInteger n = NN;
    
    _info.string = @"";
    [self addInfoStr:@"Check params"];
    
    NSInteger s = (NSInteger)_s.integerValue;
    if (s < 1) {
        [self addInfoStr:@"ERROR! s < 1"];
        return;
    }
    NSString *path = _path.stringValue;
    if (![path length]) {
        [self addInfoStr:@"ERROR! Select .html"];
        return;
    }

    PathAlg.alg.n = n;
    
    _sMax = s;
    _charMax = (NSInteger)_charK.integerValue;
    
    if (!SetFileName(path)) {
        [self addInfoStr:@"ERROR! Can't open .html file for writing"];
        return;
    }
    
    _isRun = YES;
    _btRun.enabled = NO;
    _btCancel.enabled = NO;
    _btFile.enabled = NO;
    _isErr = NO;

    PathAlg.alg.s = S_FROM;
    PathAlg.alg.charK = CHAR_FROM;
    [self addInfoStr:[NSString stringWithFormat:@"s=%d", S_FROM]];
    [self performSelectorInBackground:@selector(threadCase) withObject:nil];
}

//---------------------------------------------------------------------------------
- (void)threadCase {
    _isErr = [RunCase runCase];
    [self performSelectorOnMainThread:@selector(caseFinished) withObject:nil waitUntilDone:NO];
}

//---------------------------------------------------------------------------------
- (void)caseFinished {
    if (_isErr) {
        [self addInfoStr:@"ERROR!"];
        [self onRunFinish];
        return;
    }
    
    NSInteger s = PathAlg.alg.s;
    NSInteger charK = [PathAlg.alg charK] + 1;
    if (charK == 1) charK++;
    while (!isPrimary(charK)) charK++;
    
    if (charK > _charMax) {
        charK = CHAR_FROM;
        s++;
    }
    if (s > _sMax) {
        [self addInfoStr:@"Success! Results are in .html"];
        [self onRunFinish];
        return;
    }
    
    PathAlg.alg.s = s;
    PathAlg.alg.charK = charK;
    [self addInfoStr:[NSString stringWithFormat:@"s=%zd", s]];
    [self performSelectorInBackground:@selector(threadCase) withObject:nil];
}

//---------------------------------------------------------------------------------
- (void)onRunFinish {
    _isRun = NO;
    _btRun.enabled = YES;
    _btCancel.enabled = YES;
    _btFile.enabled = YES;
}

#pragma mark - Buttons actions

//---------------------------------------------------------------------------------
- (void)onFile {
    NSSavePanel *p = [NSSavePanel savePanel];
    p.message = @"Save to .html";
    p.nameFieldStringValue = @"res";
    p.allowedFileTypes = [NSArray arrayWithObject:@"html"];
    [p beginSheetModalForWindow:_window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSFileHandlingPanelOKButton) {
            _path.stringValue = [[p URL] path];
            [self saveDefaults];
        }
    }];
}

//---------------------------------------------------------------------------------
- (void)onCancel {
    [self saveDefaults];
    if (_isRun) return;
    [_window close];
}

//---------------------------------------------------------------------------------
- (void)onOpen {
    [[NSWorkspace sharedWorkspace] openFile:_path.stringValue];
}

#pragma mark - Defaults

//---------------------------------------------------------------------------------
- (void)loadDefaults {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"P"]) {
        _path.stringValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"P"];
    }
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"s"]) {
        _s.integerValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"s"];
    }
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"c"]) {
        _charK.integerValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"c"];
    }
}

//---------------------------------------------------------------------------------
- (void)saveDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:_path.stringValue forKey:@"P"];
    [[NSUserDefaults standardUserDefaults] setInteger:_s.integerValue forKey:@"s"];
    [[NSUserDefaults standardUserDefaults] setInteger:_charK.integerValue forKey:@"c"];
}

#pragma mark - NSApplicationDelegate

//---------------------------------------------------------------------------------
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

#pragma mark - NSWindowDelegate

//---------------------------------------------------------------------------------
- (BOOL)windowShouldClose:(id)sender {
    [self saveDefaults];
    return YES;
}

@end

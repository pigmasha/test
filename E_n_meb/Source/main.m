//
//  main.m
//  E_n_meb
//
//  Created by M on 25.04.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "MAAppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        id d = [[MAAppDelegate alloc] init];
        [NSApplication sharedApplication].delegate = d;
        [[NSApplication sharedApplication] run];
    }

    return 0;
}

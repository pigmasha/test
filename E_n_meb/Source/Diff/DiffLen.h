//
//  DiffLen.h
//  E_n_meb
//
//  Created by M on 06.05.15.
//
//

#import <Foundation/Foundation.h>

@class IntPair;

@interface DiffLen : NSObject

- (instancetype)initWithDeg:(NSInteger)deg;
- (NSArray<NSArray<IntPair *> *>*)items;

@end

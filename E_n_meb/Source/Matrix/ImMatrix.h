//
//  ImMatrix.h
//  E_n_meb
//
//  Created by M on 16.06.15.
//
//

// Matrix with elements WayPair

@class Diff;
@class WayPair;

@interface ImMatrix : NSObject

- (instancetype)initWithDiff:(Diff *)diff;
- (NSArray<NSArray<WayPair *> *> *)rows;
- (NSInteger)deg;
- (void)addRow:(NSArray<WayPair *> *)row;

@end

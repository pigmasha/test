//
//  ImMatrix.m
//  E_n_meb
//
//  Created by M on 16.06.15.
//
//

#import "ImMatrix.h"
#import "E_n_meb-Swift.h"

// Matrix with elements WayPair

@interface ImMatrix () {
    NSMutableArray<NSArray<WayPair *> *> *_items;
}

@property (nonatomic, readonly) NSInteger deg;

@end


@implementation ImMatrix

- (instancetype)initWithDiff:(Diff *)diff {
    if (self = [super init]) {
        _deg = diff.deg;
        _items = [[NSMutableArray alloc] init];
        for (NSArray* row in [diff rows]) {
            NSMutableArray* item = [[NSMutableArray alloc] init];
            for (Comb *c in row) {
                WayPair* p = nil;
                
                if ([c isZero]) {
                    p = [[WayPair alloc] initWithWay:nil koef:0];
                } else {
                    TenzorPair *t = [[c content] lastObject];
                    Way *w = [[Way alloc] initFrom:t.tenzor.rightComponent.endsWith.number to:t.tenzor.leftComponent.startsWith.number];
                    if (![w isZero]) {
                        [w compLeft:t.tenzor.leftComponent];
                        [w compRight:t.tenzor.rightComponent];
                    }

                    if (w.isZero) {
                        p = [[WayPair alloc] initWithWay:nil koef:0];
                    } else {
                        float k = 0;
                        for (TenzorPair *t in [c content]) {
                            Way *w2 = [[Way alloc] initFrom:t.tenzor.rightComponent.endsWith.number to:t.tenzor.leftComponent.startsWith.number];
                            if (!w2.isZero) {
                                [w2 compLeft:t.tenzor.leftComponent];
                                [w2 compRight:t.tenzor.rightComponent];
                            }
                            if (!w2.isZero) k += t.koef;
                        }
                        p = [WayPair pairWithWay:w koef:k];
                    }
                }
                [item addObject:p];
            }
            [_items addObject:item];
        }
    }
    return self;
}

- (NSArray<NSArray<WayPair *> *> *)rows {
    return _items;
}

- (void)addRow:(NSArray<WayPair *> *)row {
    if (row.count != _items.lastObject.count) {
        [_items removeAllObjects];
    } else {
        [_items addObject:row];
    }
}

@end

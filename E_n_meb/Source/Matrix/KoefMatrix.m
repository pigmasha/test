#import "KoefMatrix.h"
#import "ImMatrix.h"
#import "Utils.h"
#import "PrintUtils.h"

@interface KoefMatrix () {
    NSMutableArray<NSArray<NumFloat *> *>* _items;
    NSInteger _deg;
}
@end


@implementation KoefMatrix

//---------------------------------------------------------------------------------
- (instancetype)initWithIm:(ImMatrix *)im {
    if (self = [super init]) {
        _deg = [im deg];
        _items = [[NSMutableArray alloc] init];
        for (NSArray *row in [im rows]) {
            NSMutableArray* item = [[NSMutableArray alloc] init];
            for (WayPair *p in row) {
                [item addObject:[NumFloat numWithFloat:p.koef]];
            }
            [_items addObject:item];
        }
    }
    return self;
}

//---------------------------------------------------------------------------------
- (NSArray<NSArray<NumFloat *> *> *)rows {
    return _items;
}

@end

//=================================================================================

@interface KoefIntMatrix () {
    NSMutableArray<NSArray<NumInt *> *> *_items;
}
@property (nonatomic, readonly) NSInteger deg;

@end


@implementation KoefIntMatrix

//---------------------------------------------------------------------------------
- (instancetype)initWithIm:(ImMatrix *)im {
    self = [super init];
    if (self) {
        _deg = [im deg];
        _items = [[NSMutableArray alloc] init];
        for (NSArray *row in [im rows]) {
            NSMutableArray* item = [[NSMutableArray alloc] init];
            for (WayPair *p in row) {
                [item addObject:[NumInt numWithInt:p.koef]];
            }
            [_items addObject:item];
        }
    }
    return self;
}

//---------------------------------------------------------------------------------
- (instancetype)initWithSize:(NSInteger)sz {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < sz; i++) {
            NSMutableArray* item = [[NSMutableArray alloc] init];
            for (NSInteger j = 0; j < sz; j++) {
                [item addObject:[NumInt numWithInt:0]];
            }
            [_items addObject:item];
        }
    }
    return self;
}

//---------------------------------------------------------------------------------
- (NSArray<NSArray<NumInt *> *> *)rows {
    return _items;
}

//---------------------------------------------------------------------------------
- (NSInteger)rank {
    /*int n = PathAlg.n;
    NSInteger s = PathAlg.s;
    
    NSInteger r = (_deg % PathAlg.twistPeriod);
    NSInteger m = (NSInteger)(r / 2);
    NSInteger ell = _deg / PathAlg.twistPeriod;
    
    BOOL eq2s0  = ((ell * (n + s) + m) % (2 * s) == 0);
    BOOL eqs2s0 = ((ell * (n + s) + m) % (2 * s) == s);
    
    if (r == 3 && eqs2s0)
        [self rank3s];

    if (r == 4 && eqs2s0 && ell % 2 == 0)
        [self rank4s];

    if (r == 4 && eqs2s0 && ell % 2 == 1)
        [self rank4s2];

    if (r == 5 && eq2s0)
        [self rank5s];

    if (r == 6 && eq2s0)
        [self rank6s];

    if (r == 10 && eqs2s0)
        [self rank10s];*/

    //WriteLog(2, "After"); printKoefIntMatrix(self, _deg, 0);
    
    NSMutableArray<NumInt *>* nLineOfColumnPos = [[NSMutableArray alloc] init];
    NSInteger c = (NSInteger)[_items.lastObject count];
    for (NSInteger i = 0; i < c; i++) {
        [nLineOfColumnPos addObject:[NumInt numWithInt:-1]];
    }
    
    NSInteger charK = PathAlg.charK;
    NSInteger nCols = (NSInteger)[[_items lastObject] count];
    
    for (NSInteger i = 0; i < [_items count]; i++) {
        BOOL findPos = NO;
        NSInteger j = 0;
        while (!findPos) {
            NSArray<NumInt *>* row = _items[i];
            j = 0;
            while (j < nCols) {
                NSInteger n2 = row[j].intValue;
                if (charK > 0) {
                    if (n2 % charK) break;
                } else {
                    if (n2) break;
                }
                j++;
            }
            if (j == nCols) break; // line is zero
            
            NSInteger j2 = nLineOfColumnPos[j].intValue;
            if (j2 == -1) {
                nLineOfColumnPos[j].intValue = (int)i;
                findPos = YES;
            } else {
                [self addLineTo:i tok:-_items[j2][j].intValue line:j2 k:row[j].intValue];
                
                if (charK > 0) {
                    for (NSInteger k = 0; k < nCols; k++) {
                        NumInt* n2 = row[k];
                        if (n2.intValue == 0) continue;
                        if (n2.intValue % charK == 0)
                        {
                            n2.intValue = 0;
                        } else {
                            while (n2.intValue > charK) [n2 setIntValue:n2.intValue - (int)charK];
                            while (n2.intValue < 0) [n2 setIntValue:n2.intValue + (int)charK];
                        }
                    }
                }
                
                NSInteger nod = 0;
                for (NSInteger k = 0; k < nCols; k++) {
                    NumInt* n2 = row[k];
                    
                    if (n2.intValue) {
                        if (nod) {
                            nod = [Utils gcd:n2.intValue j: nod];
                        } else {
                            nod = n2.intValue;
                        }
                    }
                }
                if (nod > 1) [self divLine:i tok:nod];
            }
        }
    }
    
    NSInteger dim = 0;
    for (NumInt *n in nLineOfColumnPos) {
        if (n.intValue > -1) dim++;
    }
    return dim;
}

//---------------------------------------------------------------------------------
- (void)addLineTo:(NSInteger)addTo tok:(NSInteger)addToK line:(NSInteger)add k:(NSInteger)k {
    NSArray<NumInt *> *rowTo  = _items[addTo];
    NSArray<NumInt *> *rowAdd = _items[add];
    
    for (NSInteger i = 0; i < [rowTo count]; i++) {
        NumInt* n = rowTo[i];
        n.intValue = (int)addToK * n.intValue + (int)k * rowAdd[i].intValue;
    }
}

//---------------------------------------------------------------------------------
- (void)divLine:(NSInteger)line tok:(NSInteger)k {
    NSArray<NumInt *> *rowTo = _items[line];
    for (NumInt *n in rowTo) {
        n.intValue = n.intValue / k;
    }
}

//---------------------------------------------------------------------------------
- (void)multCol:(NSInteger)col tok:(NSInteger)k {
    for (NSArray *row in _items) {
        NumInt *n = row[col];
        n.intValue = n.intValue * (int)k;
    }
}

@end

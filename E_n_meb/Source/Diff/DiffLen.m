//
//  DiffLen.m
//  E_n_meb
//
//  Created by M on 06.05.15.
//
//

#import "DiffLen.h"
#import "Utils.h"

void addLenToPos(NSMutableArray<NSArray<IntPair *> *>* items, NSInteger i, NSInteger j, NSInteger l0, NSInteger l1) {
    IntPair *n = [[items objectAtIndex:i] objectAtIndex:j];
    [n setN0: l0];
    [n setN1: l1];
}

//=================================================================================

@interface DiffLen () {
    NSMutableArray<NSArray<IntPair *> *> *_items;
}
@end

//=================================================================================

@implementation DiffLen

- (instancetype)initWithDeg:(NSInteger)deg {
    if (self = [super init]) {
        _items = [[NSMutableArray alloc] init];
        NSInteger r = (deg % PathAlg.twistPeriod);
        NSInteger m = (NSInteger)(r / 2);
        
        if (r % 2 == 0) {
            [self createEven: m];
        } else {
            [self createOdd: m];
        }
    }
    return self;
}

//---------------------------------------------------------------------------------
- (NSArray<NSArray<IntPair *> *> *)items {
    return _items;
}

//---------------------------------------------------------------------------------
- (void)createEven:(NSInteger)m {
    switch (m) {
        case 0: [self create0]; break;
        case 1: [self create2]; break;
        case 2: [self create4]; break;
        case 3: [self create6]; break;
        case 4: [self create8]; break;
        case 5: [self create10]; break;
    }
}

//---------------------------------------------------------------------------------
- (void)createOdd:(NSInteger)m {
    switch (m) {
        case 0: [self create1]; break;
        case 1: [self create3]; break;
        case 2: [self create5]; break;
        case 3: [self create7]; break;
        case 4: [self create9]; break;
    }
}

//---------------------------------------------------------------------------------
- (void)create0 {
    NSInteger s = PathAlg.s;
    [self createZero:7*s h: 6*s];
    
    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        addLenToPos(_items, j%s, j, 1, 0);
        addLenToPos(_items, j+s, j, 0, 1);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        addLenToPos(_items, j-s, j, 1, 0);
        addLenToPos(_items, j+s, j, 0, 1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        addLenToPos(_items, j-s, j, 1, 0);
        addLenToPos(_items, j%s+5*s, j, 0, 1);
    }
    
    for (j = 6*s; j < 7*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 0, 1);
        addLenToPos(_items, j-s, j, 1, 0);
    }
}

//---------------------------------------------------------------------------------
- (void)create2 {
    NSInteger s = PathAlg.s;
    [self createZero:8*s h: 6*s];
    
    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        addLenToPos(_items, j%s, j, 3, 0);
        addLenToPos(_items, j+s, j, 0, 1);
        addLenToPos(_items, (j+s)%(2*s)+3*s, j, 1, 2);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 0, 3);
        addLenToPos(_items, j-s, j, 1, 0);
        addLenToPos(_items, j+s, j, 2, 1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        if (j<5*s-1 || j==6*s-1)addLenToPos(_items, (j+1)%s, j, 1, 2);
        addLenToPos(_items, j-s, j, 3, 0);
        addLenToPos(_items, j%s+5*s, j, 0, 1);
    }
    
    for (j = 6*s; j < 8*s; j++) {
        if (j<7*s-1 || j==8*s-1)addLenToPos(_items, (j+1)%s, j, 2, 1);
        addLenToPos(_items, (j+s+1)%(2*s)+3*s, j, 0, 3);
        addLenToPos(_items, j%s+5*s, j, 1, 0);
    }
}

//---------------------------------------------------------------------------------
- (void)create4 {
    NSInteger s = PathAlg.s;
    [self createZero:8*s h: 9*s];
    
    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        if (j<s) addLenToPos(_items, j, j, 2, 0);
        addLenToPos(_items, j%s+s, j, 1, 0);
        addLenToPos(_items, (j+s)%(2*s)+2*s, j, 0, 1);
        addLenToPos(_items, j+(5-f0(j,s))*s, j, 0, 2);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        if(j<3*s-1||j==4*s-1)addLenToPos(_items, (j+1)%s, j, 1, 3);
        addLenToPos(_items, (j+1)%s+s, j, 0, 3);
        addLenToPos(_items, j, j, 3, 0);
        addLenToPos(_items, j+(4-f0(j,3*s))*s, j, 2, 1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        if(j<5*s-1||j==6*s-1)addLenToPos(_items, (j+1)%s, j, 0, 2);
        addLenToPos(_items, j+(1-f0(j,5*s))*s, j, 2, 0);
        addLenToPos(_items, j+(2-f0(j,5*s))*s, j, 1, 0);
        addLenToPos(_items, j%s+8*s, j, 0, 1);
    }
    
    for (j = 6*s; j < 8*s; j++) {
        if(j<7*s-1||j==8*s-1)addLenToPos(_items, (j+1)%s, j, 3, 1);
        addLenToPos(_items, (j+s+1)%(2*s)+2*s, j, 1, 2);
        if(j<7*s-1||j==8*s-1)addLenToPos(_items, (j+1)%s+7*s, j, 0, 3);
        if(j>=7*s-1&&j<8*s-1)addLenToPos(_items, (j+1)%s+5*s, j, 0, 3);
        addLenToPos(_items, j%s+8*s, j, 3, 0);
    }
}

//---------------------------------------------------------------------------------
- (void)create6 {
    NSInteger s = PathAlg.s;
    [self createZero:8*s h: 9*s];
    
    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        NSInteger j_2 = j / s;
        addLenToPos(_items, j%s, j, 2, 0);
        addLenToPos(_items, j+(j_2+1)*s, j, 1, 1);
        addLenToPos(_items, j+(4-3*j_2)*s, j, 0, 1);
        addLenToPos(_items, j+5*s, j, 0, 2);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        NSInteger j_2 = j / s;
        addLenToPos(_items, j+s*(j_2-3), j, 2, 0);
        addLenToPos(_items, j+s*(j_2-2), j, 1, 0);
        addLenToPos(_items, j+3*s, j, 1, 1);
        addLenToPos(_items, j%s+7*s, j, 0, 2);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        if (j>=5*s) addLenToPos(_items, (j+1)%s, j, 0, 2);
        addLenToPos(_items, j+s, j, 2, 0);
        if (j>=5*s) addLenToPos(_items, j+2*s, j, 1, 1);
        addLenToPos(_items, j%s+8*s, j, 0, 1);
    }
    
    for (j = 6*s; j < 8*s; j++) {
        if (j<7*s) addLenToPos(_items, (j+1)%s, j, 1, 1);
        if (j<7*s-1||j==8*s-1)addLenToPos(_items, (j+1)%(2*s)+s, j, 0, 2);
        if (j>=7*s-1&&j<8*s-1)addLenToPos(_items, (j+1)%(2*s)+2*s, j, 0, 2);
        if (j<7*s) addLenToPos(_items, j+s, j, 2, 0);
        addLenToPos(_items, j%s+8*s, j, 1, 0);
    }
}

//---------------------------------------------------------------------------------
- (void)create8 {
    NSInteger s = PathAlg.s;
    [self createZero:7*s h: 6*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        addLenToPos(_items, j, j, 4, 0);
        addLenToPos(_items, (j+1)%s, j, 0, 4);
        addLenToPos(_items, j+s, j, 1, 1);
        addLenToPos(_items, j+2*s, j, 1, 1);
        addLenToPos(_items, j+3*s, j, 2, 2);
        addLenToPos(_items, j+4*s, j, 2, 2);
    }
    
    for (j = s; j < 3*s; j++) {
        if(j<2*s-1||j==3*s-1)addLenToPos(_items, (j+1)%s, j, 1, 3);
        addLenToPos(_items, j, j, 2, 0);
        addLenToPos(_items, j+2*s, j, 3, 1);
        addLenToPos(_items, j%s+5*s, j, 0, 2);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        if(j<4*s-1||j==5*s-1)addLenToPos(_items, (j+1)%s, j, 2, 2);
        addLenToPos(_items, j, j, 4, 0);
        addLenToPos(_items, (j+s+1)%(2*s)+3*s, j, 0, 4);
        addLenToPos(_items, j%s+5*s, j, 1, 1);
    }
    
    for (j = 5*s; j < 7*s; j++) {
        if(j>=6*s-1&&j<7*s-1) addLenToPos(_items, (j+1)%s, j, 3, 1);
        addLenToPos(_items, (j+s+1)%(2*s)+s, j, 0, 2);
        addLenToPos(_items, (j+1)%(2*s)+3*s, j, 1, 3);
        addLenToPos(_items, j%s+5*s, j, 2, 0);
    }
}

//---------------------------------------------------------------------------------
- (void)create10 {
    NSInteger s = PathAlg.s;
    [self createZero:6*s h: 6*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        addLenToPos(_items, (j+1)%s, j, 0, 4);
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addLenToPos(_items, j+(2*j_1+1)*s, j, 3 - j_1, 1 + j_1);
        }
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addLenToPos(_items, j+2*j_1*s, j, 4 - j_1, j_1);
        }
    }
    
    for (j = s; j < 3*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 1, 3);
        addLenToPos(_items, j, j, 4, 0);
        addLenToPos(_items, (j+s+1)%(2*s)+s, j, 0, 4);
        addLenToPos(_items, j+2*s, j, 3, 1);
        addLenToPos(_items, j%s+5*s, j, 2, 2);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 2, 2);
        addLenToPos(_items, (j+s+1)%(2*s)+s, j, 1, 3);
        addLenToPos(_items, j, j, 4, 0);
        addLenToPos(_items, (j+s+1)%(2*s)+3*s, j, 0, 4);
        addLenToPos(_items, j%s+5*s, j, 3, 1);
    }
    
    for (j = 5*s; j < 6*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 3, 1);
        addLenToPos(_items, j-4*s+1, j, 2, 2);
        addLenToPos(_items, (j+1)%(2*s)+s, j, 2, 2);
        addLenToPos(_items, j-2*s+1, j, 1, 3);
        addLenToPos(_items, (j+1)%(2*s)+3*s, j, 1, 3);
        addLenToPos(_items, j, j, 4, 0);
        addLenToPos(_items, (j+1)%s+5*s, j, 0, 4);
    }
}

//----------------------------------------------------------------------------
- (void)create1 {
    NSInteger s = PathAlg.s;
    [self createZero:6*s h: 7*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addLenToPos(_items, j+2*j_1*s, j, 2 - j_1, j_1);
        }
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addLenToPos(_items, j+(2*j_1+1)*s, j, 2 - j_1, j_1);
        }
    }
    
    for (j = s; j < 3*s; j++) {
        addLenToPos(_items, (j<2*s)?j-s+1:(j+s+1)%(2*s), j, 1, 3);
        addLenToPos(_items, j+s, j, 4, 0);
        addLenToPos(_items, (j<2*s)?j+s+1:(j+s+1)%(2*s)+2*s, j, 0, 4);
        addLenToPos(_items, j+3*s, j, 3, 1);
        addLenToPos(_items, j%s+6*s, j, 2, 2);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        addLenToPos(_items, (j<4*s) ? (j+1)%(2*s):j-4*s+1, j, 0, 2);
        addLenToPos(_items, j+s, j, 2, 0);
        addLenToPos(_items, j%s+6*s, j, 1, 1);
    }
    
    for (j = 5*s; j < 6*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 3, 1);
        addLenToPos(_items, (j+1)%s+2*s, j, 2, 2);
        addLenToPos(_items, (j+1)%s+4*s, j, 1, 3);
        addLenToPos(_items, j+s, j, 4, 0);
        addLenToPos(_items, (j+1)%s+6*s, j, 0, 4);
    }
}

//----------------------------------------------------------------------------
- (void)create3 {
    NSInteger s = PathAlg.s;
    [self createZero:9*s h: 8*s];
    
    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        NSInteger j_2 = j / s;
        addLenToPos(_items, j%s, j, (j_2 == 0) ? 1 : 2, 0);
        addLenToPos(_items, j+s+3*j_2*s, j, (j_2 == 0) ? 1 : 0, (j_2 == 0) ? 0 : 2);
        addLenToPos(_items, j+(2+j_2)*s, j, 0, (j_2 == 0) ? 1 : 2);
        addLenToPos(_items, (j+s)%(2*s)+2*s, j, (j_2 == 0) ? 0 : 1, 1);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        addLenToPos(_items, j, j, 2, 0);
        addLenToPos(_items, j+2*s, j, 1, 1);
        addLenToPos(_items, (j+s)%(2*s)+6*s, j, 0, 2);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        NSInteger j_2 = j / s;
        if (j>=5*s) addLenToPos(_items, (j+1)%(2*s), j, 0, 2);
        addLenToPos(_items, j%s+4*s, j, (j_2 == 4) ? 1 : 2, 0);
        addLenToPos(_items, j+2*s, j, (j_2 == 4) ? 0 : 1, 1);
    }
    
    for (j = 6*s; j < 8*s; j++) {
        NSInteger j_2 = j / s;
        if (j>=7*s)addLenToPos(_items, j-7*s+1, j, 0, 2);
        addLenToPos(_items, j%s+5*s, j, (j_2 == 6) ? 1 : 2, 0);
        addLenToPos(_items, (j+s)%(2*s)+6*s, j, (j_2 == 6) ? 0 : 1, 1);
    }
    
    for (j = 8*s; j < 9*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 1, 1);
        addLenToPos(_items, (j+1)%s+2*s, j, 0, 2);
        addLenToPos(_items, j-2*s, j, 2, 0);
        addLenToPos(_items, j-s, j, 2, 0);
    }
}

//----------------------------------------------------------------------------
- (void)create5 {
    NSInteger s = PathAlg.s;
    [self createZero:9*s h: 8*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addLenToPos(_items, j+2*j_1*s, j, (j_1 == 0) ? 3 :((j_1 == 1) ? 0 : 1), j_1);
        }
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addLenToPos(_items, j+(2*j_1+1)*s, j, (j_1 == 0) ? 3 :((j_1 == 1) ? 0 : 1), j_1);
        }
    }
    
    for (j = s; j < 3*s; j++) {
        NSInteger j_2 = j / s;
        addLenToPos(_items, (j+s+1)%(2*s), j, (j_2 == 1) ? 0 : 1, 3);
        addLenToPos(_items, j%s+2*s, j, (j_2 == 1) ? 1 : 2, 0);
        if(j>=2*s)addLenToPos(_items, j+2*s, j, 3, 1);
        if(j>=2*s)addLenToPos(_items, j+5*s, j, 0, 2);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        NSInteger j_2 = j / s;
        addLenToPos(_items, (j+1)%(2*s), j, (j_2 == 3) ? 0 : 1, 3);
        addLenToPos(_items, j%s+3*s, j, (j_2 == 3) ? 1 : 2, 0);
        if(j>=4*s)addLenToPos(_items, j+s, j, 3, 1);
        if(j>=4*s)addLenToPos(_items, j+2*s, j, 0, 2);
    }
    
    for (j = 5*s; j < 7*s; j++) {
        addLenToPos(_items, j-s, j, 3, 0);
        addLenToPos(_items, j+s, j, 0, 1);
    }
    
    for (j = 7*s; j < 8*s; j++) {
        addLenToPos(_items, j-7*s+1, j, 2, 1);
        addLenToPos(_items, (j+1)%(2*s), j, 2, 1);
        addLenToPos(_items, j-3*s+1, j, 0, 3);
        addLenToPos(_items, (j+1)%(2*s)+4*s, j, 0, 3);
        addLenToPos(_items, j-s, j, 1, 0);
        addLenToPos(_items, j, j, 1, 0);
    }
    
    for (j = 8*s; j < 9*s; j++) {
        addLenToPos(_items, (j+s+1)%(2*s)+2*s, j, 0, 2);
        addLenToPos(_items, j-2*s, j, 2, 0);
    }
}

//----------------------------------------------------------------------------
- (void)create7 {
    NSInteger s = PathAlg.s;
    [self createZero:6*s h: 8*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        addLenToPos(_items, j, j, 1, 0);
        addLenToPos(_items, j+s, j, 1, 0);
        addLenToPos(_items, j+2*s, j, 0, 1);
        addLenToPos(_items, j+3*s, j, 0, 1);
    }
    
    for (j = s; j < 3*s; j++) {
        addLenToPos(_items, (j+s+1)%(2*s), j, 0, 3);
        addLenToPos(_items, j+s, j, 3, 0);
        addLenToPos(_items, j+3*s, j, 2, 1);
        addLenToPos(_items, j+5*s, j, 1, 2);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        addLenToPos(_items, j+s, j, 1, 0);
        addLenToPos(_items, j%(2*s)+6*s, j, 0, 1);
    }
    
    for (j = 5*s; j < 6*s; j++) {
        addLenToPos(_items, (j+1)%s+s, j, 2, 1);
        addLenToPos(_items, (j+1)%s+2*s, j, 1, 2);
        addLenToPos(_items, (j+1)%s+4*s, j, 0, 3);
        addLenToPos(_items, (j+1)%s+5*s, j, 0, 3);
        addLenToPos(_items, j+s, j, 3, 0);
        addLenToPos(_items, j+2*s, j, 3, 0);
    }
}

//----------------------------------------------------------------------------
- (void)create9 {
    NSInteger s = PathAlg.s;
    [self createZero:6*s h: 7*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        addLenToPos(_items, j, j, 1, 0);
        addLenToPos(_items, j+s, j, 0, 1);
        addLenToPos(_items, j+2*s, j, 0, 1);
    }
    
    for (j = s; j < 3*s; j++) {
        addLenToPos(_items, j, j, 1, 0);
        addLenToPos(_items, j+2*s, j, 0, 1);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        addLenToPos(_items, j, j, 1, 0);
        addLenToPos(_items, j%(2*s)+5*s, j, 0, 1);
    }
    
    for (j = 5*s; j < 6*s; j++) {
        addLenToPos(_items, (j+1)%s, j, 0, 1);
        addLenToPos(_items, j, j, 1, 0);
        addLenToPos(_items, j+s, j, 1, 0);
    }
}

//---------------------------------------------------------------------------------
- (void)createZero:(NSInteger)width h:(NSInteger)height {
    for (NSInteger i = 0; i < height; i++) {
        NSMutableArray* line = [[NSMutableArray alloc] init];
        for (NSInteger j = 0; j < width; j++) {
            [line addObject:[IntPair pairWithN0:0 n1:0]];
        }
        [_items addObject:line];
    }
}

@end

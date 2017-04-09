#import "BimodQ.h"
#import "Utils.h"

@interface BimodQ () {
    NSMutableArray<IntPair *> *_p_ij;
    NSMutableArray<NumInt *> *_sizes;
}
@end

//=================================================================================

@implementation BimodQ

//---------------------------------------------------------------------------------
- (instancetype)initForDeg:(NSInteger)deg {
    if (self = [super init]) {
        _p_ij  = [[NSMutableArray alloc] init];
        _sizes = [[NSMutableArray alloc] init];
        
        //int n = PathAlg.n;
        NSInteger s = PathAlg.s;
        
        NSInteger d = deg % PathAlg.twistPeriod;
        NSInteger m = d / 2;
        
        BimodQ *q = (d % 2 == 0) ? [[BimodQ alloc] initEvenQ: m] : [[BimodQ alloc] initOddQ: m];
        
        for (IntPair *pij in q->_p_ij) {
            for (NSInteger r = 0; r < s; r++) {
                [_p_ij addObject:[IntPair pairWithN0:4*r+pij.n0
                                                  n1:4*r+pij.n1]];
            }
        }
        [_sizes addObjectsFromArray: q->_sizes];
        
        NSInteger r = deg / PathAlg.twistPeriod;
        for (NSInteger i = 0; i < r; i++) {
            for (IntPair *pij in _p_ij) [pij setN0:[PathAlg sigma:[pij n0]]];
        }
    }
    return self;
}

//---------------------------------------------------------------------------------
- (instancetype)initEvenQ:(NSInteger)m {
    if (self = [super init]) {
        _p_ij  = [[NSMutableArray alloc] init];
        _sizes = [[NSMutableArray alloc] init];
        
        NSInteger s = PathAlg.s;
        
        for (NSInteger i = 0; i <= f(m, 2); i++) {
            [_p_ij addObject:[IntPair pairWithN0:4*m-1+h(m,2)+i
                                              n1:0]];
        }
        [_sizes addObject:[NumInt numWithInt:f(m, 2)+1]];

        for (NSInteger j = 0; j <= 1; j++) {
            for (NSInteger i = 0; i <= f(m, 3); i++) {
                [_p_ij addObject:[IntPair pairWithN0:4*(m+j*s+(f(m,2)+f(m,5))*s)+2-h(m,3)+i*(4*s+1)
                                                  n1:4*j*s+1]];
            }
        }

        [_sizes addObject:[NumInt numWithInt:f(m, 3)+1]];
        [_sizes addObject:[NumInt numWithInt:f(m, 3)+1]];

        for (NSInteger j = 0; j <= 1; j++) {
            for (NSInteger i = 0; i <= f(m, 2); i++) {
                [_p_ij addObject:[IntPair pairWithN0:4*(m+j*s+(f(m,1)+f(m,4)+f(m,5))*s)+1+h(m,2)+i*(4*s+1)
                                                  n1:4*j*s+2]];
            }
        }

        [_sizes addObject:[NumInt numWithInt:f(m, 2)+1]];
        [_sizes addObject:[NumInt numWithInt:f(m, 2)+1]];
        
        for (NSInteger i = 0; i <= f(m, 3); i++) {
            [_p_ij addObject:[IntPair pairWithN0:4*(m+1)-h(m,3)+i
                                              n1:3]];
        }
        [_sizes addObject:[NumInt numWithInt:f(m, 3)+1]];
    }
    return self;
}

//---------------------------------------------------------------------------------
- (instancetype)initOddQ:(NSInteger)m {
    if (self = [super init]) {
        _p_ij  = [[NSMutableArray alloc] init];
        _sizes = [[NSMutableArray alloc] init];
        
        NSInteger s = PathAlg.s;
        
        for (NSInteger i = 0; i <= 1 - f(m, 4); i++) {
            [_p_ij addObject:[IntPair pairWithN0:4*m+1+h(m,0)+2*f(m,4)+4*s*i
                                              n1:0]];
        }
        [_sizes addObject:[NumInt numWithInt:2-f(m, 4)]];
        
        for (NSInteger j = 0; j <= 1; j++) {
            [_p_ij addObject:[IntPair pairWithN0:4*(m+1+j*s)-h(m,0)-2*f(m,0)
                                              n1:4*j*s+1]];
        }
        
        for (NSInteger j = 0; j <= 1; j++) {
            [_p_ij addObject:[IntPair pairWithN0:4*(m+1+j*s+f(m,4)*s)-h(m,5)+2*f(m,4)
                                              n1:4*j*s+2]];
        }

        [_sizes addObject:[NumInt numWithInt:1]];
        [_sizes addObject:[NumInt numWithInt:1]];
        [_sizes addObject:[NumInt numWithInt:1]];
        [_sizes addObject:[NumInt numWithInt:1]];

        for (NSInteger i = 0; i <= 1 - f(m, 0); i++) {
            [_p_ij addObject:[IntPair pairWithN0:4*(m+1)+1+h(m,5)-2*f(m,0)+4*s*i
                                              n1:3]];
        }
        [_sizes addObject:[NumInt numWithInt:2-f(m, 0)]];
    }
    return self;
}

//---------------------------------------------------------------------------------
- (NSArray<IntPair *> *)pij {
    return _p_ij;
}

//---------------------------------------------------------------------------------
- (NSArray<NumInt *> *)sizes {
    return _sizes;
}

//---------------------------------------------------------------------------------
- (void)html {
    FILE_OPEN();
    NSInteger s = PathAlg.s;
    
    NSInteger sPos = 0;
    NSInteger sIn = 0;
    fprintf(f, "<big>(</big>");
    for (NSInteger i = 0; i < [_p_ij count]; i++) {
        IntPair *p = _p_ij[i];
        fprintf(f, "P<sub>%zd,%zd</sub>", [p n0], [p n1]);
        sIn++;
        if (sIn == [_sizes[sPos] intValue] * s) {
            sIn = 0;
            sPos++;
            fprintf(f, "<big>)</big>");
            if (i < [_p_ij count] - 1)  fprintf(f, "&bull;<big>(</big>");
        } else {
            if (i < [_p_ij count] - 1) fprintf(f, "&bull; ");
        }
    }
    fprintf(f, "<br>\n");
    FILE_CLOSE();
}

@end

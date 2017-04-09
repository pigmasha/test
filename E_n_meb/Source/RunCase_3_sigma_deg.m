#ifdef MAIN_SIGMA_DEG

#import "Utils.h"

//----------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger s = PathAlg.s;
    
    WriteLog(2, "s=%d, char=%d", s, [PathAlg.alg charK]);
    
    NSInteger sDeg = sigmaDeg();
    
    NSInteger myDeg = 1;
    while (YES) {
        BOOL isSame = YES;
        // vertices
        for (NSInteger i = 0; i < 7; i++) {
            NSInteger from = (i < 4) ? i : i + 4 * s - 4;
            
            NSInteger v = from;
            for (NSInteger j = 0; j < myDeg; j++) v = [PathAlg.alg sigma:v];
            Vertex *v1 = [[Vertex alloc] initWithI:v];
            Vertex *v2 = [[Vertex alloc] initWithI:from];
            BOOL isEq = [v1 isEq: v2];
            [v1 release];
            [v2 release];
            
            if (!isEq) {
                isSame = NO;
                break;
            }
        }
        
        if (!isSame) {
            myDeg++;
            continue;
        }
        
        // arrows
        for (NSInteger i = 0; i < 7; i++) {
            NSInteger from = (i < 4) ? i : i + 4 * s - 4;
            Way *w = [[Way alloc] initFrom: from to:from + 1];
            if ([w isZero]) {
                WriteLog(1, "Zero way %d -> %d", from, from + 1);
                return YES;
            }
            Way *w0 = [[Way alloc] initFrom: 0 to:0];
            Tenzor *t = [[Tenzor alloc] initWithLeft:w right:w0];
            [w release];
            [w0 release];
            Comb *c = [[Comb alloc] initWithTenzor: t koef: 1];
            [t release];
            Comb *c0 = [[Comb alloc] initWithComb: c];
            for (NSInteger j = 0; j < myDeg; j++) [c twist];
            float k = [c comparek:c0];
            [c release];
            [c0 release];
            
            if (k != 1) {
                isSame = NO;
                break;
            }
        }
        
        if (!isSame) {
            myDeg++;
            continue;
        }
        
        break;
    }
    
    if (myDeg != sDeg) {
        WriteLog(1, "Deg=%d, right=%d", sDeg, myDeg);
        return YES;
    }
    return NO;
}


#endif

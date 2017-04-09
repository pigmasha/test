#import "Utils.h"

//---------------------------------------------------------------------------------
NSInteger f(NSInteger x, NSInteger y) {
    return (x == y) ? 1 : 0;
}

//---------------------------------------------------------------------------------
NSInteger f0(NSInteger x, NSInteger y) {
    return (x < y) ? 1 : 0;
}

//---------------------------------------------------------------------------------
NSInteger f1(NSInteger x, NSInteger y) {
    return (x < y) ? 1 : -1;
}

//---------------------------------------------------------------------------------
NSInteger h(NSInteger x, NSInteger y) {
    return (x >= y) ? ((x % 2) ? 1 : 0) :((x % 2) ? 0 : 1);
}

// ---------------------------------------------------------------------
NSInteger gcd(NSInteger i, NSInteger j) {
    return [Utils gcd:i j: j];
}

//---------------------------------------------------------------------------------
NSInteger sigmaDeg() {
    NSInteger n = PathAlg.n;
    NSInteger s = PathAlg.s;

    NSInteger s0 = 2*s / gcd(n+s, 2*s);

    if (PathAlg.charK == 2) return s0;
    return (s0 % 4 == 0) ? s0 : 2*s0;
}

// (-1)^s
NSInteger minusDeg(NSInteger s) {
    return (s % 2 == 0) ? 1 : -1;
}

// 2^k
NSInteger twoDeg(NSInteger k) {
    NSInteger n = 1;
    for (NSInteger i = 0; i < k; i++) n *= 2;
    return n;
}

//---------------------------------------------------------------------------------
BOOL isPrimary(NSInteger n) {
    if (n < 4) return YES;
    NSInteger n2 = n / 2 + 1;
    for (NSInteger i = 2; i < n2; i++) {
        if (n % i == 0) return NO;
    }
    return YES;
}

//---------------------------------------------------------------------------------
// mode:0 - normal, 1 - error, 2 - bold, 3 - h2, 4 - simple, 5 - with time
//---------------------------------------------------------------------------------
void WriteLog(NSInteger mode, const char* format, ...) {
    FILE_OPEN();
    
    switch (mode) {
        case 1: fprintf(f, "<b style='color:red;'>ERROR!\n"); break;
        case 2: fprintf(f, "<b>\n"); break;
        case 3: fprintf(f, "<h2>\n"); break;
        case 5: {
            long t = time(0);
            long t0 = t / 60;
            long t1 = t0 / 60;
            fprintf(f, "<b>%02d:%02d:%02d \n", (int)(t1 % 60), (int)(t0 % 60), (int)(t % 60));
            break;
        }
    }
    va_list args;
    va_start(args, format);
    vfprintf(f, format, args);
    va_end(args);

    switch (mode) {
        case 0: fprintf(f, "<br>\n"); break;
        case 1: 
        case 2:
        case 5: fprintf(f, "</b><br>\n"); break;
        case 3: fprintf(f, "</h2>\n"); break;
    }
    
    FILE_CLOSE();
}

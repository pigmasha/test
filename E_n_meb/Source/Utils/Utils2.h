//
//  Created by M on 09.04.16.
//
//

#define TYPE_MAX 22

NSInteger f(NSInteger x, NSInteger y);
NSInteger f0(NSInteger x, NSInteger y);
NSInteger f1(NSInteger x, NSInteger y);
NSInteger h(NSInteger x, NSInteger y);

NSInteger gcd(NSInteger i, NSInteger j);

NSInteger sigmaDeg();

// (-1)^s
NSInteger minusDeg(NSInteger s);
// 2^k
NSInteger twoDeg(NSInteger k);

BOOL isPrimary(NSInteger n);

#define FILE_OPEN() { FILE* f = fopen([GetFileName() UTF8String], "a")
#define FILE_CLOSE() fclose(f); }

NSString* GetFileName();
bool SetFileName(NSString* path);

// mode:0 - normal, 1 - error, 2 - bold, 3 - h2, 4 - simple, 5 - with time
void WriteLog(NSInteger mode, const char* format, ...);

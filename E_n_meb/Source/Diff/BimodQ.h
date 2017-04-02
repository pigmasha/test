@class IntPair;
@class NumInt;

@interface BimodQ : NSObject

- (instancetype)initForDeg:(NSInteger)deg;
- (void)html;

- (NSArray<IntPair *> *)pij;
- (NSArray<NumInt *> *)sizes;

@end

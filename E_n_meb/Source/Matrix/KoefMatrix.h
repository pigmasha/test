@class ImMatrix;
@class NumFloat;
@class NumInt;


@interface KoefMatrix : NSObject

- (instancetype)initWithIm:(ImMatrix *)im;
- (NSArray<NSArray<NumFloat *> *> *)rows;

@end


@interface KoefIntMatrix : NSObject

- (instancetype)initWithIm:(ImMatrix *)im;
- (instancetype)initWithSize:(NSInteger)sz;
- (NSArray<NSArray<NumInt *> *> *)rows;
- (NSInteger)rank;

- (void)addLineTo:(NSInteger)addTo tok:(NSInteger)addToK line:(NSInteger)add k:(NSInteger)k;
- (void)multCol:(NSInteger)col tok:(NSInteger)k;
- (void)divLine:(NSInteger)line tok:(NSInteger)k;

@end

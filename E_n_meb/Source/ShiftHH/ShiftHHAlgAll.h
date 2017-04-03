//
//  Created by M on 08.03.16.
//
//

#import <Foundation/Foundation.h>

@class HHElem;
@class ShiftAllVariants;

@interface ShiftHHAlgAll : NSObject

+ (ShiftAllVariants *)allVariantsForHHElem:(HHElem *)hh degree:(NSInteger)degree shift:(NSInteger)shift;
+ (HHElem *)selectFromAllVariants:(ShiftAllVariants *)allVariants type:(NSInteger)type shift:(NSInteger)shift;

@end

#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    NSArray<NSNumber*> *filteredArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
        return [object isKindOfClass:[NSNumber class]];
    }]];
    
    if ([filteredArray count] == 0) {
        return 0;
    }
    
    NSInteger N = numberOfItems > [filteredArray count] ? [filteredArray count] : numberOfItems;
    
    filteredArray = [filteredArray sortedArrayUsingComparator:^NSComparisonResult(id left, id right) {
        int first = abs([left intValue]);
        int second = abs([right intValue]);
        return (second < first) ? NSOrderedAscending : NSOrderedDescending;
    }];
    
    NSInteger resultItem = 1;
    int lastNegativeItem = 0;
    int lastPositiveItem = 0;
    
    for (int i = 0; i < N; i++) {
        int number = [filteredArray[i] intValue];
        
        if (number < 0) {
            lastNegativeItem = number;
        } else {
            lastPositiveItem = number;
        }
        
        resultItem *= number;
    }
    
    if ((resultItem < 0) && (N < [filteredArray count])) {
        int negativeItem = 0;
        int positiveItem = 0;
        
        for (NSInteger i = N; i < [filteredArray count]; i++) {
            int number = [filteredArray[i] intValue];
            
            if (number < 0 && negativeItem == 0) {
                negativeItem = number;
            } else if (positiveItem == 0) {
                positiveItem = number;
            } else {
                break;
            }
        }
        
        if ((negativeItem * lastNegativeItem) > (positiveItem * lastPositiveItem)) {
            resultItem /= lastPositiveItem;
            resultItem *= negativeItem;
        } else {
            resultItem /= lastNegativeItem;
            resultItem *= positiveItem;
        }
    }
    
    return resultItem;
}

@end

//
//  NSDecimalNumber+extension.m
//  OCCategory
//
//  Created by Broccoli on 15/7/13.
//  Copyright (c) 2015年 brocccoli. All rights reserved.
//

#import "NSDecimalNumber+extension.h"

@implementation NSDecimalNumber (Extensions)

- (NSDecimalNumber *)roundToScale:(NSUInteger)scale {
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundPlain scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handler];
}

- (NSDecimalNumber*)decimalNumberWithPercentage:(CGFloat)percent {
    NSDecimalNumber *percentage = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithFloat:percent] decimalValue]];
    return [self decimalNumberByMultiplyingBy:percentage];
}

- (NSDecimalNumber *)decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage {
    NSDecimalNumber *hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *percent = [self decimalNumberByMultiplyingBy:[discountPercentage decimalNumberByDividingBy:hundred]];
    return [self decimalNumberBySubtracting:percent];
}

- (NSDecimalNumber *)decimalNumberWithDiscountPercentage:(NSDecimalNumber *)discountPercentage roundToScale:(NSUInteger)scale {
    NSDecimalNumber *value = [self decimalNumberWithDiscountPercentage:discountPercentage];
    return [value roundToScale:scale];
}

- (NSDecimalNumber *)discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue {
    NSDecimalNumber *hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *percentage = [[self decimalNumberByDividingBy:baseValue] decimalNumberByMultiplyingBy:hundred];
    return [hundred decimalNumberBySubtracting:percentage];
}

- (NSDecimalNumber *)discountPercentageWithBaseValue:(NSDecimalNumber *)baseValue roundToScale:(NSUInteger)scale {
    NSDecimalNumber *discount = [self discountPercentageWithBaseValue:baseValue];
    return [discount roundToScale:scale];
}


@end

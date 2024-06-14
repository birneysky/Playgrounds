//
//  UIColor+Hex.m
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/14.
//

#import "UIColor+Hex.h"


UIColor* rgba(NSString* hexString) {
    NSString *cleanedHexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cleanedHexString = [cleanedHexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    cleanedHexString = [cleanedHexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];

    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:cleanedHexString];
    [scanner scanHexInt:&rgbValue];

    CGFloat red = ((rgbValue & 0xFF000000) >> 24) / 255.0;
    CGFloat green = ((rgbValue & 0x00FF0000) >> 16) / 255.0;
    CGFloat blue = ((rgbValue & 0x0000FF00) >> 8) / 255.0;
    CGFloat alpha = (rgbValue & 0x000000FF) / 255.0;

    CGFloat alphaValue = [cleanedHexString length] == 6 ? 1.0 : alpha;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alphaValue];
}

//
//  ObjectA.m
//  FoundationTest
//
//  Created by birney on 2020/3/3.
//

#import "ObjectA.h"

@implementation ObjectA

- (instancetype)init {
    if (self = [super init]) {
        _var1 = 42;
        _var2 = 62;
        _var3 = 72;
        _var4 = 82;
        //_var5 = 92; /// instance variable '_var5' is private
        //_var6 = 102; /// use of undecleard identifier '_var6'
    }
    return self;
}

@end

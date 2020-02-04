//
//  TestObject.m
//  FoundationTest
//
//  Created by birney on 2019/10/25.
//

#import "TestObject.h"

@implementation TestObject

- (void)doSomething {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end

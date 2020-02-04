//
//  NSArrayTest.m
//  FoundationTest
//
//  Created by birney on 2019/12/11.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface NSArrayTest : XCTestCase

@end

@implementation NSArrayTest

- (void)setUp {
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_nsarray_class_instance_size {
    NSArray *array1 = @[ @"one" ];
    NSArray *array2 = @[ @"one", @"two" ];
    NSArray *array3 = @[ @"one", @"two", @"three" ];
    
    NSLog(@"array1:%lu", class_getInstanceSize([array1 class]));
    NSLog(@"array2:%lu", class_getInstanceSize([array2 class]));
    NSLog(@"array3:%lu", class_getInstanceSize([array3 class]));
}

- (void)test_nsarray_malloc_size {
    NSArray *array0 = @[];
    NSArray *array1 = @[ @"one" ];
    NSArray *array2 = @[ @"one", @"two" ];
    NSArray *array3 = @[ @"one", @"two", @"three" ];
    
    NSLog(@"array0:%lu", malloc_size((__bridge const void *)(array0)));
    NSLog(@"array1:%lu", malloc_size((__bridge const void *)(array1)));
    NSLog(@"array2:%lu", malloc_size((__bridge const void *)(array2)));
    NSLog(@"array3:%lu", malloc_size((__bridge const void *)(array3)));
    
    NSArray *array4  = @[ @1, @2, @3, @4 ];
    NSArray *array5  = @[ @1, @2, @3, @4, @5 ];
    NSArray *array6  = @[ @1, @2, @3, @4, @5, @6 ];
    NSArray *array7  = @[ @1, @2, @3, @4, @5, @6, @7 ];
    NSArray *array8  = @[ @1, @2, @3, @4, @5, @6, @7, @8 ];
    NSArray *array9  = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    NSArray *array10 = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9, @10 ];
    
    NSLog(@"array4:%lu", malloc_size((__bridge const void *)(array4)));
    NSLog(@"array5:%lu", malloc_size((__bridge const void *)(array5)));
    NSLog(@"array6:%lu", malloc_size((__bridge const void *)(array6)));
    NSLog(@"array7:%lu", malloc_size((__bridge const void *)(array7)));
    NSLog(@"array8:%lu", malloc_size((__bridge const void *)(array8)));
    NSLog(@"array9:%lu", malloc_size((__bridge const void *)(array9)));
    NSLog(@"array10:%lu", malloc_size((__bridge const void *)(array10)));
}

- (void)test_nsarray_length {
    NSArray *array0 = @[];
    NSArray *array1 = @[ @"one" ];
    NSArray *array2 = @[ @"one", @"two" ];
    NSArray *array3 = @[ @"one", @"two", @"three" ];
    char *bytes0 = (char *)(__bridge void *)array0;
    char *bytes1 = (char *)(__bridge void *)array1;
    char *bytes2 = (char *)(__bridge void *)array2;
    char *bytes3 = (char *)(__bridge void *)array3;
    
    NSLog(@"length0:%llu", *(uint64_t *)(bytes0 + 8));/// ??????
    NSLog(@"length1:%llu", *(uint64_t *)(bytes1 + 8));
    NSLog(@"length2:%llu", *(uint64_t *)(bytes2 + 8));
    NSLog(@"length3:%llu", *(uint64_t *)(bytes3 + 8));
    

    NSArray *array4  = @[ @1, @2, @3, @4 ];
    NSArray *array5  = @[ @1, @2, @3, @4, @5 ];
    NSArray *array6  = @[ @1, @2, @3, @4, @5, @6 ];
    NSArray *array7  = @[ @1, @2, @3, @4, @5, @6, @7 ];
    NSArray *array8  = @[ @1, @2, @3, @4, @5, @6, @7, @8 ];
    NSArray *array9  = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    NSArray *array10 = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9, @10 ];
    
    char *bytes4 = (char *)(__bridge void *)array4;
    char *bytes5 = (char *)(__bridge void *)array5;
    char *bytes6 = (char *)(__bridge void *)array6;
    char *bytes7 = (char *)(__bridge void *)array7;
    char *bytes8 = (char *)(__bridge void *)array8;
    char *bytes9 = (char *)(__bridge void *)array9;
    char *bytes10 = (char *)(__bridge void *)array10;
    
    NSLog(@"length4:%llu", *(uint64_t *)(bytes4 + 8));
    NSLog(@"length5:%llu", *(uint64_t *)(bytes5 + 8));
    NSLog(@"length6:%llu", *(uint64_t *)(bytes6 + 8));
    NSLog(@"length7:%llu", *(uint64_t *)(bytes7 + 8));
    NSLog(@"length8:%llu", *(uint64_t *)(bytes8 + 8));
    NSLog(@"length9:%llu", *(uint64_t *)(bytes9 + 8));
    NSLog(@"length10:%llu", *(uint64_t *)(bytes10 + 8));
}

- (void)test_explore_the_memory_of_a_constant_array {
    ////  http://note.youdao.com/noteshare?id=039c3c9d24c85c20c286df6c52e91071
    NSArray *array = @[ @"one", @"two", @"three" ];
    NSLog(@"%@",[array class]);
    char *bytes = (char *)(__bridge void *)array;
    NSLog(@"%@", (__bridge id)(void*)*(uint64_t* )(bytes + 16));
    NSLog(@"%@", (__bridge id)(void*)*(uint64_t *)(bytes + 24));
    NSLog(@"%@", (__bridge id)(void*)*(uint64_t *)(bytes + 32));
    NSLog(@"%@", (__bridge id)(void*)*(uint64_t *)(bytes + 40));
}

- (void)test_nsarray_alloc {
    NSLog(@"%@",[[NSArray alloc] class]);
    NSLog(@"%@",[[[NSArray alloc] init] class]);
    NSLog(@"%p",[NSArray alloc]);
    NSLog(@"%p",[NSArray alloc]);
    NSLog(@"%p",[NSArray alloc]);
    
    NSLog(@"------------");
    ///  it turns out that the alloc method on NSArray returns an NSPlaceholderArray singleton， the singleton is an factory
    
    NSLog(@"%@",[[[NSMutableArray alloc] init] class]);
    NSLog(@"%@",[[NSMutableArray alloc] class]);
    NSLog(@"%p",[NSMutableArray alloc]);
    NSLog(@"%p",[NSMutableArray alloc]);
    NSLog(@"%p",[NSMutableArray alloc]);
    
    /// the alloc method on NSMutableArray also returns an an NSPlaceholderArray singleton, it is not the same  one that returned by nsarray's alloc method
}

@end

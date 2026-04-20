//
//  CPlusPlusSmartPointerTest.m
//  KataTest
//
//  Created by birneysky on 2020/8/22.
//

#import <XCTest/XCTest.h>
#include "Empty.hpp"
#include "Base.hpp"

#include <memory>

@interface CPlusPlusSmartPointerTest : XCTestCase

@end

@implementation CPlusPlusSmartPointerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testUseCount {
    std::shared_ptr<Empty> ptr(new Empty());
    XCTAssertEqual(ptr.use_count(), 1);
    
    std::shared_ptr<VEmpty> ptr2(new VEmpty());
    XCTAssertEqual(ptr2.use_count(), 1);
    
    std::shared_ptr<Empty> ptr3 = std::make_shared<Empty>();
    XCTAssertEqual(ptr3.use_count(), 1);
    
}

- (void)testOwnsNoPointer {
    
    std::shared_ptr<Empty> ptr1;
    XCTAssertEqual(ptr1.use_count(), 0);
    
    std::shared_ptr<int> ptr2(nullptr);
    XCTAssertEqual(ptr2.use_count(), 0);
}

- (void)testCopy {
    Empty *e = new Empty;
    std::shared_ptr<Empty> ptr(e);
    XCTAssertEqual(ptr.use_count(), 1);
    
    std::shared_ptr<Empty> ptr2(ptr);
    XCTAssertEqual(ptr.use_count(), 2);
    XCTAssertEqual(ptr2.use_count(), 2);
    
    XCTAssertEqual(ptr.get(), e);
    XCTAssertEqual(ptr2.get(), e);
}

- (void)testAssign {
    std::shared_ptr<Empty> ptr(new Empty());
    XCTAssertEqual(ptr.use_count(), 1);
    
    std::shared_ptr<Empty> ptr2 = ptr;
    XCTAssertEqual(ptr.use_count(), 2);
    XCTAssertEqual(ptr2.use_count(), 2);
}

- (void)testMove {
    std::shared_ptr<Empty> ptr(new Empty());
    XCTAssertEqual(ptr.use_count(), 1);
    
    std::shared_ptr<Empty> mp = std::move(ptr);
    XCTAssertEqual(mp.use_count(), 1);
    XCTAssertEqual(ptr.use_count(), 0);
}

- (void)testEmptySize {
    Empty a;
    XCTAssertEqual(sizeof(a), 1);
    XCTAssertEqual(sizeof(Empty), 1);
}

- (void)testVirutalFunction {
    Base b;
    std::cout << "b address:" << &b << " size:" << sizeof(b)  << std::endl;
    /// 第一步：获取对象的起始地址，并将其转为 long*，以便读取 8 字节的 vptr
    long* vptr = (long*)(&b);

    /// 第二步：解引用 vptr，得到 vtable 的首地址
    long* vtable = (long*)(*vptr);

    /// 第三步：从 vtable 中提取函数地址
    long func_f = vtable[0];
    long func_g = vtable[1];
    long func_h = vtable[1];
    
    typedef void (*FunWithThis)(void*);
    ((FunWithThis)func_f)(&b);
    ((FunWithThis)func_g)(&b);
    ((FunWithThis)func_h)(&b);
}

- (void)testVirutalFunction1 {
    Derive d;
    Base& b = d;
    /// 第一步：获取对象的起始地址，并将其转为 long*，以便读取 8 字节的 vptr
    long* vptr = (long*)(&b);

    /// 第二步：解引用 vptr，得到 vtable 的首地址
    long* vtable = (long*)(*vptr);

    /// 第三步：从 vtable 中提取函数地址
    long func_f = vtable[0];
    long func_g = vtable[1];
    long func_h = vtable[1];
    
    typedef void (*FunWithThis)(void*);
    ((FunWithThis)func_f)(&b);
    ((FunWithThis)func_g)(&b);
    ((FunWithThis)func_h)(&b);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

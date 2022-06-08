//
//  CPlusPlutMemoryLayout.m
//  KataTest
//
//  Created by Bruce on 2022/6/2.
//

#import <XCTest/XCTest.h>
#include "Empty.hpp"
#include <iostream>
#include <string>
#include <vector>
#include "KataHelper.hpp"
@interface CPlusPlutMemoryLayout : XCTestCase

@end

@implementation CPlusPlutMemoryLayout

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testEmpty {
    Empty t;
    /// c++ 空对象内存中占用一个字节
    std::cout << sizeof(class Empty) << std::endl;
    std::cout << sizeof(t) << std::endl;
    XCTAssertEqual(sizeof(t), 1);
    

}

- (void)testVirtualEmpty {
    /// c++ 带有虚函数，编译器在类中添加虚函数表指针 vptr， 该指针指向 virutal table
    /// virtual table 存放了虚函数地址
    std::cout << sizeof(class VEmpty) << std::endl;
    XCTAssertEqual(sizeof(class VEmpty), 8);
}

- (void)testString {
    std::cout << sizeof(std::string) << std::endl;
    XCTAssertEqual(sizeof(std::string), 24);
}

- (void)testTestObject {
    XCTAssert(sizeof(TestObject<int>) == sizeof(int));
    XCTAssert(sizeof(TestObject<double>) == sizeof(double));
    XCTAssert(sizeof(TestObject<long>) == sizeof(long));
    XCTAssert(sizeof(TestObject<char>) == sizeof(char));
    
    TestObject<int> a;
    std::cout << a.getA() << std::endl;
    
    TestObject<double> b;
    std::cout << b.getA() << std::endl;
    
    TestObject<std::string> c;
    std::cout << c.getA() << std::endl;
    
    TestObject<std::vector<int>> d;
    std::cout << d.getA() << std::endl;
}

- (void)testPointer {
    void* a = nullptr;
    int*  b = nullptr;
    double* c = nullptr;
    std::string* d = nullptr;
    XCTAssert(sizeof(a) ==  8);
    XCTAssert(sizeof(b) ==  8);
    XCTAssert(sizeof(c) ==  8);
    XCTAssert(sizeof(d) ==  8);
}

- (void)testObjectSize {
    X x;
    Y y;
    Z z;
    A a;
    std::cout << "sizeof(x):" << sizeof(x) << std::endl;
    std::cout << "sizeof(y):" << sizeof(y) << std::endl;
    std::cout << "sizeof(z):" << sizeof(z) << std::endl;
    std::cout << "sizeof(a):" << sizeof(a) << std::endl;
    /// c++ 中对于一个空的对象（没有任何成员变量）占用一个字节，
    /// 这是因为编译器向这个类中安插了一个 char 类型的变量进入
    XCTAssertEqual(sizeof(x), 1);
    XCTAssertEqual(sizeof(y), 8);
    XCTAssertEqual(sizeof(z), 8);
    XCTAssertEqual(sizeof(a), 16);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

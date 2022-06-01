//
//  OStreamTest.m
//  KataTest
//
//  Created by Bruce on 2022/5/23.
//

#import <XCTest/XCTest.h>
#include <iostream>
#include <iomanip>
using std::ios;
using std::cout;
using std::endl;

@interface OStreamTest : XCTestCase

@end

@implementation OStreamTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


/// 格式标志
- (void)testFormatFlg {
    
    /// 返回所有目前设置的 format flag
    ios::fmtflags oldFlags = cout.flags();
    cout << oldFlags << endl;
    
    int x = 255;
    cout << std::hex  << x << endl;
    
    cout.setf(ios::uppercase);
    cout << std::hex  << x << endl;
    
    cout.setf(ios::showpos | ios::showbase);
    cout << std::hex  << x << endl;
    
    cout.setf(ios::internal, ios::adjustfield);
    cout << std::hex  << x << endl;
    
    /// 恢复保存的 flag
    cout.flags(oldFlags);
    
    cout << std::hex  << x << endl;
}

- (void)testHexFlag {
    int x = 255;
    cout << std::hex  << x << endl;
    
    cout.setf(ios::uppercase);
    cout << std::hex  << x << endl;
}

- (void)testShowFlag {
    int x = 255;
    cout << std::hex  << x << endl;

    
    cout.setf(ios::showpos | ios::showbase | ios::uppercase);
    cout.setf(ios::internal, ios::adjustfield);
    cout << std::hex  << x << endl;
}

- (void)testBoolean {
    bool b = true;
    /// boolalpha 强制使用文本表示法
    /// noboolalpha 强制使用数字表示法
    cout << std::noboolalpha << b << " == "
    << std::boolalpha << b << endl;
}

- (void)testWidth {
    cout << 3 << 4 << endl;
    cout << cout.width() << endl;
    cout.width(5);
    cout << 3 << 4 << endl;
    cout << 5 << 6 << endl;
    
    cout.width(10);
    cout.fill('-');
    cout << 3 << endl;
    cout << 5 << endl;
    
}

- (void)testSetWAndFill {
    cout << std::setw(1) << std::setfill('_') << 1 << endl;
    cout << std::setw(2) << std::setfill('_') << 2 << endl;
    cout << std::setw(3) << std::setfill('_') << 3 << endl;
    cout << std::setw(4) << std::setfill('_') << 4 << endl;
    cout << std::setw(5) << std::setfill('_') << 5 << endl;
    cout << std::setw(6) << std::setfill('_') << 6 << endl;
    cout << std::setw(7) << std::setfill('_') << 7 << endl;
    cout << std::setw(8) << std::setfill('_') << 8 << endl;
    cout << std::setw(9) << std::setfill('_') << 9 << endl;
    cout << 10 << endl;
}


- (void)testSetf {
    cout.setf(ios::left, ios::adjustfield);
    cout.fill('_');
    cout.width(10);
    cout << 3 << endl;
    cout << 4 << endl;
    
    cout.setf(ios::right, ios::adjustfield);
    cout.fill('_');
    cout.width(10);
    cout << 3 << endl;
    
    
    cout.setf(ios::internal, ios::adjustfield);
    cout.fill('_');
    cout.width(10);
    cout << -3 << endl;
}

- (void)testFloat {
    cout << std::showpoint << std::setprecision(2) << 3.1415926 << endl;
    cout << std::fixed << std::setprecision(2) << 3.1415926 << endl;
    cout << std::fixed << std::setprecision(3) << 3.1415926 << endl;
    
    cout << std::scientific << 3.1414926 << endl;
    /// 整数不起作用
    cout << std::scientific << 314149260000000 << endl;
    cout << std::scientific <<  std::setprecision(2) << 314149260000000 << endl;
    
    cout << std::scientific << std::hexfloat << 3.1414926 << endl;
    
    cout << std::hexfloat << 3.1414926 << endl;
}





- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

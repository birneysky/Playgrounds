//
//  ColorTests.m
//  TestXcodePreviewTests
//
//  Created by Bruce on 2024/4/9.
//

#import <XCTest/XCTest.h>
#import "TestXcodePreview-Swift.h"
/**
 遇到 'TestXcodePreview-Swift.h' file not found 的错误通常是因为 Xcode 无法找到或生成所需的 Swift 接口头文件。这里有一些可能的解决方案：

 1.
 确保项目名称没有包含空格。如果有，尝试移除空格或用下划线替换。
 2.
 检查 Build Settings：
 •  确认 Objective-C Generated Interface Header Name 设置正确无误。

 •  确认 $(SWIFT_MODULE_NAME)-Swift.h 文件存在。

 •  在 Header Search Paths 中添加路径 $(TARGET_TEMP_DIR)/../$(PROJECT_NAME).build/DerivedSources。

 1.
 导入语句的位置：确保你是在 Objective-C 的 .m 文件中导入 Project-Swift.h，而不是在 .h 文件中。

 如果这些方法仍然无法解决问题，可能需要检查以下设置：
 •  在测试目标的 Build Settings 中设置 Embedded Content Contains Swift Code 为 YES。

 •  确保桥接头文件（Bridging Header）的路径设置正确。
 */

@interface ColorTests : XCTestCase

@end

@implementation ColorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    XCTAssert([UIColor.clearColor isEqual:UIColor.clearColor]);
    UnitTestClass* testClas =  [[UnitTestClass alloc] init];
    XCTAssert([testClas isKindOfClass:UnitTestClass.class]);
    //[[KTVAchievementEntranceViewController alloc] init];
    KTVRankItemViewController* a = [KTVRankItemViewController controller];
    XCTAssert([a isKindOfClass: KTVRankItemViewController.class]);
    
    KTVEntranceItemView* itemView = [KTVEntranceItemView view];
    XCTAssert([itemView isKindOfClass: KTVEntranceItemView.class]);
    
    KTVADScrollingBubblesViewController* b = [KTVADScrollingBubblesViewController controller];
    XCTAssert([b isKindOfClass: KTVADScrollingBubblesViewController.class]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

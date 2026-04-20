//
//  TestViewController.m
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import "TestViewController.h"
#import "TestViewControllerProtocol.h"
#import "ComponentRegister.h"

RegisterComponent(TestViewControllerProtocol, TestViewController)

@interface TestViewController ()<TestViewControllerProtocol>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (__kindof UIViewController*)testViewControllerWithURL:(NSString*)url arg1:(NSInteger)arg1 arg2:(NSInteger)arg2 {
    TestViewController *vc = [[TestViewController alloc] init];
    // 这里可以解析 url，并将参数赋值给 vc
    // vc.url = url;
    return vc;
}


- (void)testWithArg:(NSInteger)a {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end

//
//  DetailViewController.m
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import "DetailViewController.h"
#import "DetailViewControllerProtocol.h"
#import "Mediator.h"


@interface DetailViewController () <DetailViewControllerProtocol>

@end

@implementation DetailViewController

+ (void)load {
    [Mediator registerProtocol:@protocol(DetailViewControllerProtocol) class:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 实现协议中的工厂方法：在此处进行实例化
+ (__kindof UIViewController *)detailViewControllerWithURL:(NSString *)url {
    DetailViewController *vc = [[DetailViewController alloc] init];
    // 这里可以解析 url，并将参数赋值给 vc
    // vc.url = url;
    return vc;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

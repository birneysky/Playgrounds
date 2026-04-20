//
//  } } } } DetailViewControllerProtocol.h
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DetailViewControllerProtocol <NSObject>

+ (__kindof UIViewController*)detailViewControllerWithURL:(NSString*)url;

@end

NS_ASSUME_NONNULL_END

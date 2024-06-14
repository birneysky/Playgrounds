//
//  UIColor+Hex.h
//  TestXcodePreview
//
//  Created by Bruce on 2024/6/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 十六进制字符串转换为 UIColor
/// - Parameter hexString: 十六进制字符串 rgba 格式，支持 “#123456FF”、 @“0x123456FF”、 @“123456FF” 或者 #123456”、 @“0x123456”、 @“123456”
/// 非法字符串返回不确定颜色, 如果字符串没有提供 alpha 值，将其设置为1。
UIColor* rgba(NSString* hexString);


NS_ASSUME_NONNULL_END

//
//  Object.h
//  FoundationTest
//
//  Created by birney on 2020/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Object : NSObject {
    NSInteger _var1;
@package
    NSInteger _var2;
@protected
    NSInteger _var3;
@public
    NSInteger _var4;
@private
    NSInteger _var5;
}

@end

NS_ASSUME_NONNULL_END

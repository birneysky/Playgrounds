//
//  KTVNickNameEffectModel.h
//  ktv
//
//  Created by Bruce on 2024/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KTVNickNameEffectModel : NSObject

@property (nonatomic, copy) NSString* webp;
@property (nonatomic, copy) NSString* svga;
@property (nonatomic, copy) NSArray<NSString*>* darkColors;
@property (nonatomic, copy) NSArray<NSString*>* lightColors;
@property (nonatomic, copy) NSArray<NSNumber*>* positions;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSInteger degree;

@end

NS_ASSUME_NONNULL_END

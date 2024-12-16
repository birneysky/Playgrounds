//
//  KTVShiningEffectLabel.h
//  ktv
//
//  Created by Bruce on 2024/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KTVNickNameEffectModel;
@interface KTVShiningEffectLabel1 : UILabel

- (void)setEffect:(nullable KTVNickNameEffectModel *)effect;
- (void)setImageURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END

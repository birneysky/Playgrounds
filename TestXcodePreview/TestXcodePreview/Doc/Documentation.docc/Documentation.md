# ``TestXcodePreview``

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### 红包

- 1. 播放页 送礼成功后会收到  kKTVSendGiftSuccessNotifaction 通知
- 2. 通知处理，判断是否是红包礼物 
    KTVGift *gift = notifaction.userInfo[@"gift"];
    if (gift.isRedPacketGift) {
        /// 如果是的话，请求 gift.giftpackage.getgiftpackageinfo 接口， 
    }
- 3. 该接口返回红包入口信息， 包括红包的状态

```
    typedef NS_ENUM(NSUInteger, KTVRedPacketStatus) {
        KTVRedPacketStatusInvalid,      //不可抢
        KTVRedPacketStatusValid,        //可抢
        KTVRedPacketStatusFinish,       //已抢
        KTVRedPacketStatusEmpty         //抢光
    };
```
- 4. 点击红包入口
    - 4.1 如果红包状态是 KTVRedPacketStatusValid 状态时，弹出抢红包页面 KTVGrabRedPacketViewController
        - 4.1.1 点击抢红包 调用 /ktvbox.php?ac=pickgiftpackage 接口，成功后刷新 红包详情页面
    - 4.2 如果红包状态是 KTVRedPacketStatusFinish ｜｜ KTVRedPacketStatusEmpty 状态时，
            弹出红包详情页（KTVGrabRedPacketResultViewController）， 调用 /ktvbox.php?ac=getgiftpackagehistory 接口

- 5. KTVGrabRedPacketResultViewController 和 KTVGrabRedPacketCoverViewController 被显示在 KTVGrabRedPacketViewController 中的 _resultarea 和 _converare 中




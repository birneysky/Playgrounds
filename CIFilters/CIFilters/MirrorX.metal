//
//  MirrorX.metal
//  CIFilters
//
//  Created by Bruce on 2021/7/9.
//  Copyright © 2021 COOL. All rights reserved.
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>
//using namespace metal;
//using namespace coreimage;

/// 注意这里一定要加 extern "C"， 否则内核会初始化失败
/// 原因猜测是如果没有，会已 C++ 的方式生成函数符号名，mirrorX 的函数名符号可能会是  mirrorXfd 之类的
extern "C" {
    
metal::float2 mirrorX( float imageWidth, coreimage::destination dest) {
    metal::float2 curVec = dest.coord();
    return metal::float2(imageWidth - curVec.x, curVec.y);
}
    
}


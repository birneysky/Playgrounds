//
//  TestMediator.m
//  FoundationTest
//
//  Created by Bruce on 2026/4/20.
//

#import "TestMediator.h"
#import "ComponentRegister.h"
/// 需要引入底层库
#import <mach-o/getsect.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>

// 在 @implementation Mediator 上方，或者文件任何空白处，写一个空的 C 函数
static void __dummy_function_for_dladdr(void) {}

@implementation TestMediator

// 使用静态变量保存映射表，并在第一次使用时懒加载
static NSMutableDictionary<NSString *, Class> *protocolCache = nil;

+ (NSMutableDictionary *)caches {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        protocolCache = [[NSMutableDictionary alloc] init];
        [self loadComponentsFromMachO:protocolCache];
    });
    return protocolCache;
}

+ (void)registerProtocol:(Protocol*)protocol class:(Class)cls {
        if(protocol  && cls) {
        [self.caches setObject:cls forKey:NSStringFromProtocol(protocol)];
    }
}
+ (Class)classFroProtocol:(Protocol*)protocol {
    if (protocol) {
        NSString *protocolName = NSStringFromProtocol(protocol);
        return [[self caches] objectForKey:protocolName];
    }
    return nil;
}

// 私有方法：读取 Mach-O 数据
+ (void)loadComponentsFromMachO:(NSMutableDictionary *)cache {
    // 1. 获取当前 App 所在的内存基地址
    Dl_info info;
    dladdr((const void *)&__dummy_function_for_dladdr, &info);
    
    // 2. 查找我们在宏里定义的 __DATA 段下的 __components section (64位系统)
#ifndef __LP64__
    const struct section *sect = getsectbynamefromheader((void *)info.dli_fbase, "__DATA", "__components");
#else
    const struct section_64 *sect = getsectbynamefromheader_64((void *)info.dli_fbase, "__DATA", "__components");
#endif
    
    if (sect == NULL) return; // 如果没有注册任何组件，直接返回
    
    // 3. 计算数据大小和内存起始地址
    uint32_t size = (uint32_t)sect->size;
    char *memoryStart = (char *)info.dli_fbase + sect->offset;
    
    // 4. 根据结构体大小，计算出注册了多少个组件
    uint32_t structSize = sizeof(struct ComponentData);
    uint32_t count = size / structSize;
    
    // 5. 遍历内存区块，提取字符串
    for (uint32_t i = 0; i < count; i++) {
        struct ComponentData *data = (struct ComponentData *)(memoryStart + i * structSize);
        NSString *protocolStr = [NSString stringWithUTF8String:data->protocolName];
        NSString *classStr = [NSString stringWithUTF8String:data->className];
        
        if (protocolStr && classStr) {
            Class cls = NSClassFromString(classStr);
            if (cls) {
                [cache setObject:cls forKey:protocolStr];
            }
        }
    }
}

@end

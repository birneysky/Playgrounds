//
//  ComponentRegister.h
//  experiment
//
//  Created by Bruce on 2026/4/20.
//

#ifndef ComponentRegister_h
#define ComponentRegister_h

struct ComponentData {
    char *protocolName;
    char *className;
};

#define RegisterComponent(protocol_name, class_name) \
\
/* === 亮点在这里：增加一个编译期校验的静态函数 === */ \
__attribute__((unused)) static void __Component_Check_##protocol_name##_##class_name(void) { \
    /* 核心校验：声明一个指针，强制要求 class_name 必须遵守 protocol_name 协议 */ \
    class_name<protocol_name> *verify_conformance = nil; \
    (void)verify_conformance; /* 消除未使用变量的警告 */ \
} \
\
/* === 下面是原本的数据写入逻辑 === */ \
__attribute__((used, section("__DATA,__components"))) \
static const struct ComponentData __component_##protocol_name##_##class_name = { \
    #protocol_name, \
    #class_name \
};


#endif /* ComponentRegister_h */

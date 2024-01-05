# summry

这是一个 OpenGL 的练手项目

## Overview

这个项目主要展示 OpenGL 基础概念的理解与实践

## Topics

### Swift C++ 互操作

- Build setting -> swift compiler - language-> C++ and Objective-c interoperabllity -->  C++ / Objective-C++

### 消除 OpenGL API deprecated warnings
 Preprocessor Macros 中添加 GL_SILENCE_DEPRECATION，消除 eprecated warnings

### macOS GLFW 构建

当然也可以直接下载以编译好的库

- 下载 GLFW 源码 https://www.glfw.org/download.html
- 编译
```shell
cd glfw-3.3.9
cmake -S . -B build
cd build
make
```
- 编译成功后，库文件在 /build/src/libglfw3.a， 头文件在 glfw-3.3.9/include
- 将 libglfw3 导入工程。

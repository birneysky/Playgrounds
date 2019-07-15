在 target 为应用时，

1. swift 中调用 oc 需要建立 targetName-Bridging-Header.h 文件
在文件中引入 需要调用的 oc 的头文件即可
2. 在 Build Settings 中的 Objective-c Bridging head 
的编译选项中设置 targetName-Bridging-Header.h 的所在路径
```
./PromiseKitDemo/PromiseKitDemo-Bridging-Header.h
```

在 target 为 framework 时，上述方式不再适用

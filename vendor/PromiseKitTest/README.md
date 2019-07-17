Carthage 的使用

1 touch Cartfile
2 编辑 Cartfile 文件，写入
```

```
3 运行 Carthage
```
carthage update --platform iOS
/// 其中--platform iOS命令是可选的，
/// 作用是只编译 iOS 平台的  framework，
/// 如果不指定平台，会为全平台编译framework文件。
/// 如果想要了解更多的命令，可以运行carthage help update查看。


/// 升级指定 framework
carthage update SVProgressHUD --platform iOS
```

## Jupyter NoteBook 魔法命令
### %run 
```
/// 执行 hello.py 这个脚本
%run ./myscript/hello.py
```
### %timeit
```
/// 测试代码性能
%timeit L = [i**2 for i in range(1000)]
/// 一段代码进行测试
%%timeit
    L = []
    for n in range(1000):
        L.append(n ** 2)
```
### %time
    /// 仅执行一次
    %time L = [i**2 for i in range(1000)]


### %lsmagic
```
/// 输出所有的魔法命令

%run?
查看run命令相应的文档

```

## PyCoreImgage
https://www.cnblogs.com/xilifeng/p/9269066.html
https://www.cnblogs.com/xilifeng/p/9269066.html
https://github.com/yarshure/CoreImagePython

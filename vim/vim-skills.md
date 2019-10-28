# Edit
### 插入
```
a append
i insert
o open a line below

A append after line
I insert before line
O append a line above

```


#### 保存退出
- :wq save and quit

#### 如何快速纠错

- ctrl + h 在插入模式下，删除上一个字符
- ctrl + w 在插入模式下，删除上一个单词
- ctrl + u 在插入模式下，删除当前行

#### 上面的快捷键在终端输入命令时，也是适用的

另外还有一些：

- ctrl + a 快速移动到行首 0 也快速移动到行首
- ctrl + e 快速移动到行位
- ctrl + b 光标快速向前移动
- ctrl + f 光标向后移

#### inert->norrmal 模式切换快捷键

- ctrl + c  # 可能会中断件工作
- ctrl + [

#### normal->insert 快捷键

- gi 快速调转到最后一次编辑的地方并进入插入模式

#### 如何快速快速删除一个字符和单词呢

- normal 模式下使用 x 快速删除一个字符
- 使用 d(delete) 配合删除一个单词,使用daw (d around word)
- d 和 x 可以搭配数字来执行多次
- 使用 dw 删除一个单词, daw  diw 也可以删除单词，对空格的处理不同
- dd 删除一行 2dd 删除 2 行
- 删除括号中的内容，使用 `dt +` ( 表示”delete to (“
- 同理删除双引号中的内容，使用 `dt+"`
- d + $ 删除到行位
- d + 0 删除光标之前的字符

#### vim 快速修改

常用的有三个 r(replace), c(change), s(substitue)

- noremal 模式下使用 r 可以替换一个字符。 s 替换并进入插入模式
- 使用 c 配合文本对象，我们可以快速修改

```
- r + a 将光标所在的字符修改成a  r+b r+c 以此类推
- s 删除光标所在的当前字符，并进入插入模式
- R 直接开始替换光标开始的字符
- S 会将整行删除并进入插入模式
- 也同样可以配合数字来使用，比如 4s ，会删除4个字符并进入插入模式

- c+w 删除当前单词并进入插入模式
- C 删除整行来进行插入操作

例如修改双引号中的内容 c+t+"

```
#### normal 下 删除行

# Command
- :w
- :q

- :vs vertical split
- :sp vertical split
- :% s/foo/bar/g 全局替换，

# Move quickly

#### vim normal 模式使用了反人类的hjkl 来移动

- 据说编辑器作者在编写 vim 时候键盘还没有流行上下左右键


#### 如何在单词之间快速飞舞

- w/W 移动到下一个 word/WORD 的开头
- e/E 移动到下一个 word/WORD 尾部
- b/B 回到上一个 word/WORD 开头， backword

> word 是指以非空白符分隔的单词，WORD 以空白符分隔的单词


#### 行间搜索移动

同一行快速移动的方式，其实是搜索一个字符并且移动到该字符

- 使用 f+char 可以快速移动到 char 字符上， t+char  移动到 char 的前一个字符
- 如果第一次没搜索到， 可以使用分号(;)/都好(,) 继续搜索该行下一个/上一个
- 大写的 F 表示反过来搜索全面的字符，光标在行尾是有用。


#### 如何快速移动到一行的行首或者行尾呢

- 0 移动到行首的第一个字符，^ 移动到第一个非空白字符
- $  移动到行位， g_ 移动到行尾非空白字符
- 0 和 $ 就可以满足日常需求了

#### 在句子和段落间移动 不常用

- 使用 () 在句子间移动，可以使用:help 来查看帮助文档


#### 常用页面移动命令

- gg/G 移动到文件的开头和结尾， 你可以使用 ctrl + o 快速返回

- H/M/L 跳转到屏幕的开头(Head)  中间 (Middle) 和结尾 (Lower)

- ctrl + u, ctrl + f 上下翻页， (upword/forward). zz 把光标所在的行防止在屏幕中间

# Search
#### 文件中查找单词
- normal 模式下，使用/ 或者？进行前向或者反向的搜索
- 使用 n 或者 N 跳转到下一个或者上一个匹配
- 使用 * 或者 # 进行当前单词的前向或者后向匹配


:set hls  # 表示把结果高亮 highlight search
:set incsearch # 增量搜索 increment search

#### 搜索替换文本

> substitute 命令允许我们查找并替换文本，并且支持正则表达式

# Visual
normal 模式下使用 v 进入 visual 模式

使用 V 选择行

使用 ctrl + v 进行方块选择

# Code hints

### vim 内置补全方式

ctrl + n 和 ctrol +p 补全单词
ctrl +x 和 ctrl + f 补全文件名
ctrl +x  ctrl +o 代码补全，需要开启文件类型检查，安装插件


filetype on 文件类型开启

# Map 
基本映射指的是 normal 模式下的映射

- 使用map 实现基本映射 比如 :map - x   按 - 就会删除字符
- :map <space> viw  按下空格的时候选中整个单词
- :map <c-d> dd 可以使用 ctrl + d 执行dd 删除一行

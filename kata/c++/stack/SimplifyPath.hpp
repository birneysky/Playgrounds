//
//  SimplifyPath.hpp
//  KataTest
//
//  Created by birney on 2020/9/8.
//

#ifndef SimplifyPath_hpp
#define SimplifyPath_hpp
#include <string>
#include <stack>

/*
 71. 简化路径
 以 Unix 风格给出一个文件的绝对路径，你需要简化它。或者换句话说，将其转换为规范路径。
 在 Unix 风格的文件系统中，一个点（.）表示当前目录本身；此外，两个点 （..） 表示将目录切换到上一级（指向父目录）；
 两者都可以是复杂相对路径的组成部分。更多信息请参阅：Linux / Unix中的绝对路径 vs 相对路径
 
 请注意，返回的规范路径必须始终以斜杠 / 开头，并且两个目录名之间必须只有一个斜杠 /。
 最后一个目录名（如果存在）不能以 / 结尾。此外，规范路径必须是表示绝对路径的最短字符串。

 示例 1：

 输入："/home/"
 输出："/home"
 解释：注意，最后一个目录名后面没有斜杠。
 示例 2：

 输入："/../"
 输出："/"
 解释：从根目录向上一级是不可行的，因为根是你可以到达的最高级。
 示例 3：

 输入："/home//foo/"
 输出："/home/foo"
 解释：在规范路径中，多个连续斜杠需要用一个斜杠替换。
 示例 4：

 输入："/a/./b/../../c/"
 输出："/c"
 示例 5：

 输入："/a/../../b/../c//.//"
 输出："/c"
 示例 6：

 输入："/a//b////c/d//././/.."
 输出："/a/b/c"
 https://leetcode-cn.com/problems/simplify-path/
 **/


/// 解题思路：把路径中的字符 '/' 全部忽略， 从字符串开始到结束，只取出 当前目录 (.), 上一级目录(..)，
///  还有目录名或者文件名，依次压入栈中，如果遇到 .. 就弹出栈顶的元素，
///  这样就把有效路径中的目录名和文件名存储在栈中了，最后再依次弹出栈中字符串元素，重新组装路径
class SimplifyPath {
private:
    std::stack<std::string> result;
private:
    void handleComponent(const std::string& name) {
        if (name != "." && name != "..") {
            result.push(name);
        } else if (name == ".." && !result.empty()) {
            result.pop();
        }
    }
public:
    
    std::string simplifyPath(std::string path) {
        int begin = 0;
        int end = 0;
        while (begin < path.size()) {
            if (path[begin] == '/') {
                begin ++;
                end ++;
            } else if (path[end] == '/' || end  == path.size()) {
                std::string dirName = path.substr(begin, (end - 1) - begin + 1);
                handleComponent(dirName);
                begin = end;
            } else {
                end ++;
            }
        }
        
        std::string resultPath;
        if (result.empty()) {
            resultPath =  "/";
        }
        while (!result.empty()) {
            resultPath = '/' +  result.top() + resultPath;
            result.pop();
        }
        return resultPath;
    }
};

#endif /* SimplifyPath_hpp */

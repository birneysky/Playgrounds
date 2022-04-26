//
//  Solution93.hpp
//  KataTest
//
//  Created by Bruce on 2022/4/20.
//

#ifndef Solution93_hpp
#define Solution93_hpp

/**
 
 有效 IP 地址 正好由四个整数（每个整数位于 0 到 255 之间组成，且不能含有前导 0），整数之间用 '.' 分隔。

 例如："0.1.2.201" 和 "192.168.1.1" 是 有效 IP 地址，但是 "0.011.255.245"、"192.168.1.312" 和 "192.168@1.1" 是 无效 IP 地址。
 给定一个只包含数字的字符串 s ，用以表示一个 IP 地址，返回所有可能的有效 IP 地址，这些地址可以通过在 s 中插入 '.' 来形成。你 不能 重新排序或删除 s 中的任何数字。你可以按 任何 顺序返回答案。

  

 示例 1：

 输入：s = "25525511135"
 输出：["255.255.11.135","255.255.111.35"]
 示例 2：

 输入：s = "0000"
 输出：["0.0.0.0"]
 示例 3：

 输入：s = "101023"
 输出：["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"]
  

 提示：

 1 <= s.length <= 20
 s 仅由数字组成
 
 **/

/****
                                                    101023
                              /                        |                            \
                          1(01023)                   10(1023)                     101(023)
               /           |     \            /           |        \           /       |       \
            0(1023)        01     010     1(023)         10(23)    102(3)     0        02      023
    /          |       \               /    |    \      /    |       |       /  \
   1(023)    10(23)  102(3)           0    02   023   2(3)   23      3     2(3)  23
    /           |      |              /                |                     |
  023          23      3             23                3                     3
 
 
 void backtrack(const std::string& s, int start, const int num, std::string p) {
    if(num == 4) {
        result.push_back(p);
        return;
    }
    
    for (auto stride: {1, 2, 3}) {
        std::string onsub;
        if (start + stride > s.size() ) {
            onesub = s.substr(start);
        } else {
            onesub = s.substr(start, stride);
        }
        backtrack(s, start + stride, num + 1, p + onsub);
    }
    
 }
 
 
 1.0.10.23
 1.0.102.3
 10.1.0.23
 10.10.2.3
 10.10.23
 10.102.3
 101.0.2.3
 
 1.0.1.023  N
 1.01   N
 1.010  N
 10.1.02  N
 10.1.023  N
 101.0.23 N
 101.02 N
 101.023  N
 
 */

#include <vector>
#include <string>
#include <iostream>
using namespace std;

class Solution93 {
public:
    vector<string> restoreIpAddresses(string s) {

    }
};

#endif /* Solution93_hpp */

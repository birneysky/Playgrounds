//
//  LongestPalindrome.hpp
//  KataTest
//
//  Created by birney on 2020/8/17.
//

#ifndef LongestPalindrome_hpp
#define LongestPalindrome_hpp

#include <string>

/* 5
 给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。

 示例 1：

 输入: "babad"
 输出: "bab"
 注意: "aba" 也是一个有效答案。
 示例 2：

 输入: "cbbd"
 输出: "bb"

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-palindromic-substring
 **/

class LongestPalindrome {
public:
    std::string longestPalindrome(std::string s);
};

#endif /* LongestPalindrome_hpp */

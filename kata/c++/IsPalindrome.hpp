//
//  IsPalindrome.hpp
//  KataTest
//
//  Created by birneysky on 2020/8/18.
//

#ifndef IsPalindrome_hpp
#define IsPalindrome_hpp

#include <string>
/*
 给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。

 说明：本题中，我们将空字符串定义为有效的回文串。

 示例 1:

 输入: "A man, a plan, a canal: Panama"
 输出: true
 示例 2:

 输入: "race a car"
 输出: false

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-palindrome

 **/

class IsPalindrome {
public:
    bool isPalindrome(std::string s);
};

#endif /* IsPalindrome_hpp */

//
//  IsPalindrome.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/18.
//

#include "IsPalindrome.hpp"


bool IsPalindrome::isPalindrome(std::string s) {
    /// 由于题目只考虑字母和数字，所以这里将其他字符，去掉其他字符
    std::string cleanStr;
    for (char c : s) {
        if (isalnum(c)) {
            /// 由于可以忽略字母的大小写。所以全部转化为小写
            cleanStr += tolower(c);
        }
    }
    size_t l = 0;
    size_t r = cleanStr.size() -1;
    while (l < r) {
        if (cleanStr[l] != cleanStr[r]) {
            return false;
        }
        l ++;
        r --;
    }
    return true;
}

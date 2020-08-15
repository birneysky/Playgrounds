//
//  LengthOfLongestSubstring.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/15.
//

#include "LengthOfLongestSubstring.hpp"

/// 滑动窗口
int lengthOfLongestSubstring(std::string s) {
    int l = 0, r = -1;/// 定义 滑动窗口 s[l, r];
    int freq[256] = {0}; /// 记录某个字符出现的次数
    int result = 0;
    while (l < s.size()) {
        if (r + 1 < s.size() && freq[s[r+1]] == 0) {
            r ++;
            freq[s[r]] ++;
            result = std::max(result, r - l + 1);
        } else {
            freq[s[l]] --;
            l ++;
        }
    }
    return result;
}

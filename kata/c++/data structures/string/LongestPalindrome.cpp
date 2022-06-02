//
//  LongestPalindrome.cpp
//  KataTest
//
//  Created by birney on 2020/8/17.
//

#include "LongestPalindrome.hpp"
#include <iostream>

std::string LongestPalindrome::longestPalindrome(std::string s) {
    auto isPalindrome = [] (const std::string& str,int l, int r) {
        bool ret = true;
        while (l <= r) {
            if (str[l] != str[r]) {
                ret = false;
                break;
            }
            l ++;
            r --;
        }
        return ret;
    };
    
    
    int l = 0;
    int r = -1;
    std::string result = "";
    while (l < s.size()) {
        if (r + 1 < s.size() && !isPalindrome(s, l, r+1)) {
            r ++;
        } else  {
            std::string aPanlin = s.substr(l, r -l + 1);
            if(aPanlin.size() > result.size()) {
                result = aPanlin;
            }
            l ++;
            r ++;
        }
    }
    return result;
}

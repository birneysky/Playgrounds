//
//  IsPalindrome.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/18.
//

#include "IsPalindrome.hpp"


bool IsPalindrome::isPalindrome(std::string s) {
    int l = 0;
    int r = s.size() -1;
    bool result = true;
    while (l <= r) {
        if (s[l] != s[r]) {
            result = false;
            break;
        }
        l ++;
        r --;
    }
    return result;
}

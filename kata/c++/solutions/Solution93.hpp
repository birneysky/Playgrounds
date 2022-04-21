//
//  Solution93.hpp
//  KataTest
//
//  Created by Bruce on 2022/4/20.
//

#ifndef Solution93_hpp
#define Solution93_hpp

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
private:
    std::vector<std::string> result;
    void backtrack(const std::string& s, int start, const int num, std::string p) {
        if (num == 4 && start == s.size()) {
            p.pop_back();
            result.push_back(p);
            return;
        }
        
        for (auto stride: {1, 2, 3}) {
            std::string oneSub;

            if (start + stride <= s.size()) {
                oneSub = s.substr(start, stride);
            } else {
                break;
            }
            
            if (oneSub.front() == '0' && oneSub.size() > 1) {
                break;
            }
            
            if (atoi(oneSub.c_str()) > 255) {
                break;
            }
            
            backtrack(s, start + stride, num + 1, p + oneSub + ".");
        }
 
    }
public:
    vector<string> restoreIpAddresses(string s) {
        result.clear();
        std::string p;
        backtrack(s, 0, 0, p);
        return result;
    }
};

#endif /* Solution93_hpp */

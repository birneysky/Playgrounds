//
//  Solution17.hpp
//  kata
//
//  Created by Bruce on 2022/4/24.
//

#ifndef Solution17_hpp
#define Solution17_hpp

/**
 给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回。

 给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。

0 " " 空格
1 ""
2 "abc"
3 "def"
4 "ghi"
5 "jkl"
6 "mno"
7 "pqrs"
8 "tuv"
9 "wxyz"
 

 示例 1：

 输入：digits = "23"
 输出：["ad","ae","af","bd","be","bf","cd","ce","cf"]
 示例 2：

 输入：digits = ""
 输出：[]
 示例 3：

 输入：digits = "2"
 输出：["a","b","c"]
  

 提示：

 0 <= digits.length <= 4
 digits[i] 是范围 ['2', '9'] 的一个数字。
 **/

#include <vector>
#include <string>
#include <cassert>
using namespace std;
class Solution17 {
private:
    const vector<string> leeterMap {
        " ",
        "",
        "abc",
        "def",
        "ghi",
        "jkl",
        "mno",
        "pqrs",
        "tuv",
        "wxyz"
    };
    vector<string> result;
    void backtrack(const string& digits, int index, string& p) {
        if (index == digits.size()) {
            result.push_back(p);
            return;
        }
        
        char ch = digits[index];
        assert(ch >= '0' && ch <= '9');
        string one = leeterMap[ch - '0'];
        for (auto& character: one) {
            p.push_back(character);
            backtrack(digits, index + 1, p);
            p.pop_back();
        }
    }
public:
        vector<string> letterCombinations(string digits) {
        result.clear();
        if (digits.size() <= 0) {
            return {};
        }
        std::string s;
        backtrack(digits, 0, s);
        return result;
    }
};

#endif /* Solution17_hpp */

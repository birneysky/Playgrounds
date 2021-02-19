//
//  Combination.hpp
//  KataTest
//
//  Created by birney on 2020/9/8.
//

#ifndef Combination_hpp
#define Combination_hpp

#include <vector>


/* 给定两个整数 n 和 k，返回 1 ... n 中所有可能的 k 个数的组合。
示例:

输入: n = 4, k = 2
输出:
[
  [2,4],
  [3,4],
  [2,3],
  [1,2],
  [1,3],
  [1,4],
]

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/combinations
**/
class Combination {
private:
    std::vector<std::vector<int>> result;
    ///  求解 C(n,k), 当前已经找到的组合存储在 c 中, 需要从 star t开始搜索新的元素
    void _combine(int start, int n, int k, std::vector<int>& c) {
        if (c.size() == k) {
            result.push_back(c);
            return;
        }
        
        for (int i = start; i <= n; i++) {
            c.push_back(i);
            _combine(i + 1, n, k, c);
            c.pop_back();
        }
    }
public:
    std::vector<std::vector<int>> combine(int n, int k) {
        result.clear();
        std::vector<int> c;
        _combine(1, n, k, c);
        return result;
    }
};

#endif /* Combination_hpp */

//
//  Solution77.hpp
//  kata
//
//  Created by Bruce on 2022/4/24.
//

#ifndef Solution77_hpp
#define Solution77_hpp

/**
 给定两个整数 n 和 k，返回范围 [1, n] 中所有可能的 k 个数的组合。

 你可以按 任何顺序 返回答案。

  

 示例 1：

 输入：n = 4, k = 2
 输出：
 [
   [2,4],
   [3,4],
   [2,3],
   [1,2],
   [1,3],
   [1,4],
 ]
 示例 2：

 输入：n = 1, k = 1
 输出：[[1]]
  

 提示：

 1 <= n <= 20
 1 <= k <= n
 */
#include <vector>
using namespace std;
class Solution77 {
public:
    vector<vector<int>> combine(int n, int k) {
#if 1
        return {};
#endif
    }
};

#endif /* Solution77_hpp */

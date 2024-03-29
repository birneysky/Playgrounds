//
//  Solution78.hpp
//  kata
//
//  Created by Bruce on 2022/4/24.
//

#ifndef Solution78_hpp
#define Solution78_hpp

/**
 给你一个整数数组 nums ，数组中的元素 互不相同 。返回该数组所有可能的子集（幂集）。

 解集 不能 包含重复的子集。你可以按 任意顺序 返回解集。

  

 示例 1：

 输入：nums = [1,2,3]
 输出：[[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
 示例 2：

 输入：nums = [0]
 输出：[[],[0]]
  

 提示：

 1 <= nums.length <= 10
 -10 <= nums[i] <= 10
 nums 中的所有元素 互不相同
 */
#include <vector>
using namespace std;
class Solution78 {
public:
    vector<vector<int>> result;
    void backtrack(const vector<int>& nums, int start, vector<int>& s) {
        result.push_back(s);
        for (int i = start; i < nums.size(); i++) {
            s.push_back(nums[i]);
            backtrack(nums, i + 1, s);
            s.pop_back();
        }
    }
    vector< vector<int> > subsets(vector<int>& nums) {
        result.clear();
        if (nums.size() <= 0) {
            return {{}};
        }
        vector<int> subset;
        backtrack(nums, 0, subset);
        return result;
#if 1
        return {};
#endif
    }
};

#endif /* Solution78_hpp */

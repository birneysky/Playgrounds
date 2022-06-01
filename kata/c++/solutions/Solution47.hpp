//
//  Solution47.hpp
//  kata
//
//  Created by Bruce on 2022/4/24.
//

#ifndef Solution47_hpp
#define Solution47_hpp

/**
 给定一个不含重复数字的数组 nums ，返回其 所有可能的全排列 。你可以 按任意顺序 返回答案。

 示例 1：

 输入：nums = [1,2,3]
 输出：[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
 示例 2：

 输入：nums = [0,1]
 输出：[[0,1],[1,0]]
 示例 3：

 输入：nums = [1]
 输出：[[1]]
  

 提示：

 1 <= nums.length <= 6
 -10 <= nums[i] <= 10
 nums 中的所有整数 互不相同
 **/
#include <vector>
using namespace std;
class Solution47 {
private:
    vector<vector<int>> result;
    vector<bool> used;
    void backTrack(const vector<int>& nums, int index, vector<int>& p) {
        if (index == nums.size()) {
            result.push_back(p);
            return;
        }
        
        for (int i = 0; i < nums.size(); i++) {
            if (!used[i]) {
                p.push_back(nums[i]);
                used[i] = true;
                backTrack(nums, index + 1, p);
                p.pop_back();
                used[i] = false;
            }
        }
    }
public:
    vector<vector<int>> permute(vector<int>& nums) {
        result.clear();
        
        if (nums.size() <= 0) {
            return result;
        }
        used = vector<bool>(nums.size(), false);
        vector<int> p;
        backTrack(nums, 0, p);
        return result;
#if 1
        return {};
#endif
    }
};

#endif /* Solution47_hpp */

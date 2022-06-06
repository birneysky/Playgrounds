//
//  Solution90.hpp
//  kata
//
//  Created by Bruce on 2022/6/6.
//

#ifndef Solution90_hpp
#define Solution90_hpp

/**
 给你一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）。

 解集 不能 包含重复的子集。返回的解集中，子集可以按 任意顺序 排列。
 
 
 输入：nums = [1,2,2]
 输出：[[],[1],[1,2],[1,2,2],[2],[2,2]]
 
 输入：nums = [0]
 输出：[[],[0]]
 
 提示：

 1 <= nums.length <= 10
 -10 <= nums[i] <= 10
 
 */

class Solution90 {
public:
    vector<vector<int>> subsetsWithDup(vector<int>& nums) {
#if 1
        return {};
#endif
    }
};

#endif /* Solution90_hpp */

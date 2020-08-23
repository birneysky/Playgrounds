//
//  BirnarySearch.cpp
//  BinarySearchTest
//
//  Created by birneysky on 2020/7/2.
//

#include "BinarySearch.hpp"

///  在有序数组 nums 中进行二分查找，返回值等于 target 的元素在 nums 中的索引值
size_t binarySearch(const std::vector<int>& nums, int target) {
    size_t l = 0;
    size_t r = nums.size() - 1;
    while (l <= r) {
        size_t m = l + (r - l) / 2;
        if(nums[m] > target) {
            r = m -1;
        } else if (nums[m] < target) {
            l = m + 1;
        } else {
            return m;
        }
    }
    return -1;
}


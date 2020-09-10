//
//  FindMedianSortedArrays.hpp
//  KataTest
//
//  Created by birney on 2020/9/10.
//

#ifndef FindMedianSortedArrays_hpp
#define FindMedianSortedArrays_hpp

#include <vector>
/*
 4. 寻找两个正序数组的中位数
 给定两个大小为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。

 请你找出这两个正序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。

 你可以假设 nums1 和 nums2 不会同时为空。

  

 示例 1:

 nums1 = [1, 3]
 nums2 = [2]

 则中位数是 2.0
 示例 2:

 nums1 = [1, 2]
 nums2 = [3, 4]

 则中位数是 (2 + 3)/2 = 2.5
 
 https://leetcode-cn.com/problems/median-of-two-sorted-arrays/
 
 **/

/// 解题思路：由于是求 中位数
class FindMedianSortedArrays {
private:
    void merge(const std::vector<int>& nums1, const std::vector<int>& nums2, std::vector<int>&m) {
        int i = 0; /// 记录 nums1 的当前考察元素的索引
        int j = 0; /// 记录 nums2 的当前考察元素的索引
        /// k 表示归并数组中的当前待插入位置索引
        for (int k = 0; k < m.size(); k++) {
            if (i >= nums1.size()) {
                m[k] = nums2[j];
                j++;
            } else if (j >= nums2.size()) {
                m[k] = nums1[i];
                i++;
            } else if (nums1[i] < nums2[j]) {
                m[k] = nums1[i];
                i++;
            } else {
                m[k] = nums2[j];
                j++;
            }
        }
    }
public:
    double findMedianSortedArrays(std::vector<int>& nums1, std::vector<int>& nums2) {
        size_t totalSize = nums1.size() + nums2.size();
        std::vector<int> m(totalSize, 0);
        merge(nums1, nums2, m);
        if (totalSize % 2 == 0) {
            return (m[totalSize / 2] + m[(totalSize / 2) - 1]) / 2.0;
        } else {
            return m[totalSize / 2];
        }
    }
};
#endif /* FindMedianSortedArrays_hpp */

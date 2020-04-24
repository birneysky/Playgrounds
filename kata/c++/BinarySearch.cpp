#include<iostream>
#include<vector>
#include<cassert>

///  在有序数组 nums 中进行二分查找，返回值等于 target 的元素在 nums 中的索引值
int binarySearch(const std::vector<int>& nums, int target) {
	int l = 0;
	int r = nums.size() - 1;
	while (l <= r) {
		int m = l + (r - l) / 2;
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

int main( int argc, char* arv[]) {
	std::vector<int> nums1{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
	assert(binarySearch(nums1, 3) == 3);
	std::vector<int> nums2{10, 30, 45, 67, 89, 90, 91, 92, 93, 94};
	assert(binarySearch(nums2, 30) == 1);
	assert(binarySearch(nums1, 11) == -1);	
}

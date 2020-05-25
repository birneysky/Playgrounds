#include<vector>

/// 一个长度为 n 的数组里的所有数字都在[0, n-1]的范围内， 数组中
/// 的某些数字是重复的， 但不知道有几个数字重复了，
/// 也不知道每个数字重复了几次。 请找出数组中任意一个重复的数字
///  {2, 3, 1, 0, 2, 5, 3} 那么对应的输出的重复数字是 2 或者 3


bool duplicate1(std::vector<int> nums, int* duplication) {
	assert(duplication != nullptr);
	std::sort(nums.begin(), nums.end());
	for(int i = 0; i < nums.size(); i++ ) {
		if(i != nums[i]) {
			*duplication = nums[i];
			return true;
		}
	}
	return false;
}
			

int main(int argc, char* argv[]) {
	std::vector<int> nums1{2, 3, 1, 0, 2, 5, 3};
	int result = -1;
	duplicate1(nums1, &result);
	assert(result == 2);
	return 0;
}

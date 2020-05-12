#include<vector>
#include<iostream>
#include<sstream>

class ListNode {
public:
	int val;
	ListNode* next;
	ListNode(int x): val(x), next(nullptr) {}
	ListNode(): val(0), next(nullptr) {}
	ListNode(const std::vector<int>& nums) {
		ListNode* pHead = this;
		for(int i = 0; i < nums.size(); ++ i) {
			pHead->val = nums[i];
			if ( i != nums.size() - 1 ) {
				pHead->next = new ListNode();
			}
		}
	}

	friend std::ostream& operator << (std::ostream& os, const ListNode* head) {
		std::stringstream sstream;
		const ListNode* node = head;
		while (node != nullptr) {
			sstream << node->val << "-->";
			node =node->next;
		}
		sstream << "nullptr" << std::endl;
		os << sstream.str();
		return os;
	}
};

class Solution {
public:
	ListNode* MergeTwoLists(ListNode* l1, ListNode* l2) {
		ListNode* result = nullptr;
		if (l1 == nullptr) {
			return l2;
		}

		if (l2 == nullptr) {
			return l1;
		}

		if (l1->val < l2->val) {
			result = l1;
			result->next = MergeTwoLists(l1->next, l2);
		} else {
			result = l2;
			result->next = MergeTwoLists(l1, l2->next);
		}
		return result;
	}

};


int main(int argc, char* argv[]) {
	
	std::vector<int> nums1{1, 2, 4};
	ListNode* l1 = new ListNode(nums1);
	std::cout << l1;
}

